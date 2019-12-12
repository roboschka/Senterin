extends KinematicBody2D

var move_input = 0
var velocity = Vector2()
export var debug = true
export var walk_accel = 30
export var walk_speed = 170
const WALK_ACCEL_NORMAL = 30
const WALK_SPEED_NORMAL = 120
const WALK_ACCEL_OIL = 45
const WALK_SPEED_OIL = 250
export var friction = 30
const FRICTION_NORMAL = 30
const FRICTION_OIL = 3
export var gravity_accel = 30
export var gravity_speed = 300
export var jump_accel = 50
export var jump_speed = 200
var is_jumping = false
var jump_hold = true
var battery_duration = 0

var standing_on = []
var status = []
var disable_input = false
var disable_horizontal_movement = false
var star = 0
var state = "idle"

onready var sprite = $Sprite
onready var small_jump_timer = $small_jump_timer
onready var full_jump_timer = $full_jump_timer
onready var standing_on_area = $Area2D3
onready var anim = $AnimationPlayer
onready var label = $Label
onready var light = $Sprite2
onready var light_area = $Area2D2
onready var light_area_shape = $Area2D2/CollisionPolygon2D
onready var battery_timer = $battery_timer
onready var battery_bars = $gui/battery_ui/bar_container.get_children()
onready var battery_amount = $gui/battery_ui/Label

func _process(delta):
	_flip()
	_status()
	_state_machine()
	_timer_var_sync()
	if debug:
		_debug()
	_battery_ui_update()

func _physics_process(delta):
	_movement()
	_standing_on()

func _input(event):
	if !disable_input:
		#horizontal_movement
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
#			if Input.is_action_pressed("left") and Input.is_action_pressed("right"):
#				move_input = 0
			if Input.is_action_pressed("left"):
				move_input = -1
			elif Input.is_action_pressed("right"):
				move_input = 1
		else:
			move_input = 0
		
		#jump
		if Input.is_action_just_pressed("jump") and is_on_floor():
			is_jumping = true
			jump_hold = true
			small_jump_timer.start(.08)
			full_jump_timer.start(.2)
		if Input.is_action_just_released("jump"):
			jump_hold = false
		
		#action
		if Input.is_action_just_pressed("flashlight"):
			if !light.is_visible() and battery_duration > 0:
				light.set_deferred("visible",true)
	#			light_area.monitorable = true
				light_area_shape.set_deferred("disabled", false)
				battery_timer.start(battery_duration)
			else:
				light.set_deferred("visible",false)
	#			light_area.monitorable = false
				light_area_shape.set_deferred("disabled", true)
				battery_timer.stop()

func _movement():
	#gravity
	velocity.y += gravity_accel
	
	#horizontal_movement
	if !disable_horizontal_movement:
		if move_input != 0:
			if move_input == 1:
				velocity.x += walk_accel
			else:
				velocity.x -= walk_accel
			velocity.x = clamp(velocity.x, -walk_speed, walk_speed)
		else:
			if velocity.x < 0:
				velocity.x += friction
				velocity.x = clamp(velocity.x, -walk_speed, 0)
			elif velocity.x > 0:
				velocity.x -= friction
				velocity.x = clamp(velocity.x, 0, walk_speed)
	else:
		velocity.x = 0
	
	#jump
	if is_jumping:
		velocity.y -= jump_accel
		velocity.y = min(velocity.y, -jump_speed)
	if is_on_ceiling():
		is_jumping = false
		velocity.y += gravity_accel
	
	velocity.y = clamp(velocity.y, -jump_speed, gravity_speed)
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _clear_status():
	if status.has("slippery"):
		walk_accel = WALK_ACCEL_NORMAL
		walk_speed = WALK_SPEED_NORMAL
		friction = FRICTION_NORMAL
	status.clear()

func _reset_action():
	light.set_deferred("visible", false)
#	light_area.monitorable = false
	light_area_shape.set_deferred("disabled", true)

func _die():
	_clear_status()
	_reset_action()
	velocity = Vector2(0, velocity.y)
	disable_input = true
	disable_horizontal_movement = true
	battery_timer.stop()
	_respawn()

func _respawn():
	if get_parent():
		move_input = 0
		velocity = Vector2(0, 0)
		position = get_parent().get_node("respawn_position").position
		disable_input = false
		disable_horizontal_movement = false
		get_tree().reload_current_scene()

func _status():
	# checking for status infliction
	if standing_on.has("motor_oil") and !status.has("slippery"):
		status.append("slippery")
	elif !standing_on.has("motor_oil") and status.has("slippery"):
		status.erase("slippery")
	
	# applying status
	if !status.empty():
		if status.has("slippery"):
			walk_accel = WALK_ACCEL_OIL
			walk_speed = WALK_SPEED_OIL
			friction = FRICTION_OIL
		else: # *got something to do with multiple status
			walk_accel = WALK_ACCEL_NORMAL
			walk_speed = WALK_SPEED_NORMAL
			friction = FRICTION_NORMAL
	else:
		walk_accel = WALK_ACCEL_NORMAL
		walk_speed = WALK_SPEED_NORMAL
		friction = FRICTION_NORMAL

func _standing_on():
	standing_on.clear()
	if !standing_on_area.get_overlapping_bodies().empty():
		for i in standing_on_area.get_overlapping_bodies():
			if i.is_in_group("motor_oil") and !standing_on.has("motor_oil"):
				standing_on.push_front("motor_oil")

func _flip():
	if move_input == -1 and !sprite.flip_h:
		sprite.flip_h = true
	if move_input == 1 and sprite.flip_h:
		sprite.flip_h = false

func _state_machine():
	match state:
		"idle":
			if move_input != 0:
				state = "walk"
			if velocity.y != 0:
				state = "jump"
			if standing_on.has("motor_oil"):
				state = "slip"
		"walk":
			if move_input == 0:
				state = "idle"
			if velocity.y != 0:
				state = "jump"
			if standing_on.has("motor_oil"):
				state = "slip"
		"jump":
			if velocity.y == 0:
				state = "idle"
		"slip":
			if !standing_on.has("motor_oil"):
				state = "idle"
	anim.play(state)

func _timer_var_sync():
	if !battery_timer.is_stopped():
		battery_duration = battery_timer.get_time_left()

func _battery_ui_update():
	battery_bars[0].visible = false
	battery_bars[1].visible = false
	battery_bars[2].visible = false
	battery_bars[3].visible = false
	battery_bars[4].visible = false
	if battery_duration <= 10:
		if battery_duration <= 0:
			pass
		elif battery_duration <= 2:
			battery_bars[0].visible = true
		elif battery_duration <= 4:
			battery_bars[0].visible = true
			battery_bars[1].visible = true
		elif battery_duration <= 6:
			battery_bars[0].visible = true
			battery_bars[1].visible = true
			battery_bars[2].visible = true
		elif battery_duration <= 8:
			battery_bars[0].visible = true
			battery_bars[1].visible = true
			battery_bars[2].visible = true
			battery_bars[3].visible = true
		elif battery_duration <= 10:
			battery_bars[0].visible = true
			battery_bars[1].visible = true
			battery_bars[2].visible = true
			battery_bars[3].visible = true
			battery_bars[4].visible = true
	else:
		if int(battery_duration)%10 <= 0:
			pass
		elif int(battery_duration)%10 <= 2:
			battery_bars[0].visible = true
		elif int(battery_duration)%10 <= 4:
			battery_bars[0].visible = true
			battery_bars[1].visible = true
		elif int(battery_duration)%10 <= 6:
			battery_bars[0].visible = true
			battery_bars[1].visible = true
			battery_bars[2].visible = true
		elif int(battery_duration)%10 <= 8:
			battery_bars[0].visible = true
			battery_bars[1].visible = true
			battery_bars[2].visible = true
			battery_bars[3].visible = true
		elif int(battery_duration)%10 <= 10:
			battery_bars[0].visible = true
			battery_bars[1].visible = true
			battery_bars[2].visible = true
			battery_bars[3].visible = true
			battery_bars[4].visible = true
	battery_amount.text = "x" + str(int(battery_duration/10))

func _on_small_jump_timer_timeout():
	if !jump_hold:
		is_jumping = false

func _on_full_jump_timer_timeout():
	is_jumping = false

func _on_battery_timer_timeout():
	battery_duration = 0
	light.set_deferred("visible",false)
#	light_area.monitorable = false
	light_area_shape.set_deferred("disabled", true)
	battery_timer.stop()

func _on_Area2D_area_entered(area):
	if area.is_in_group("destroyer"):
		_die()
	if area.is_in_group("star"):
		star += 1
	if area.is_in_group("battery"):
		if !battery_timer.is_stopped():
			battery_timer.stop()
			battery_duration += 10
			battery_timer.start(battery_duration)
		else:
			battery_duration += 10

func _on_AnimationPlayer_animation_finished(anim_name):
	pass

func _debug():
	label.text = "status : " +str(status)
	label.text += "\n" + str(standing_on)
	label.text += "\n" + str(battery_duration)




#end