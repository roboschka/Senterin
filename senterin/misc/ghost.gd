extends KinematicBody2D

onready var wait_pos = position
var velocity = Vector2()
var accel = 4
var speed = 32
var state = "hiding"
var anim_done = true

onready var detection_area = $detection_area
onready var anim = $AnimationPlayer
onready var sprite = $Sprite

func _process(delta):
	_flip()

func _physics_process(delta):
	_state_machine()

func _flip():
	if velocity.x > 0 and sprite.flip_h:
		sprite.set_flip_h(false)
	elif velocity.x < 0 and !sprite.flip_h:
		sprite.set_flip_h(true)

func _state_machine():
	match state:
		"hiding":
			if anim_done and _player_trigger():
				anim_done = false
				state = "appearing"
				anim.play("appearing")
		"appearing":
			if anim_done:
				state = "chasing"
		"chasing":
			if !_player_trigger():
				state = "going_back"
			if _player_trigger():
				var temp = Vector2(_player_trigger().global_position.x - global_position.x, _player_trigger().global_position.y - global_position.y)
				if abs(temp.x) >= 4:
					if _player_trigger().global_position.x < global_position.x:
						velocity.x -= accel
					if _player_trigger().global_position.x > global_position.x:
						velocity.x += accel
				if abs(temp.y) > 4:
					if _player_trigger().global_position.y < global_position.y:
						velocity.y -= accel
					if _player_trigger().global_position.y > global_position.y:
						velocity.y += accel
				elif abs(temp.y) <= 4: #hehe
					velocity.y = 0
				velocity.x = clamp(velocity.x, -speed, speed)
				velocity.y = clamp(velocity.y, -speed, speed)
				velocity = move_and_slide(velocity)
		"going_back":
			var temp = wait_pos - position
			if _player_trigger():
				state = "chasing"
			if temp.abs() <= Vector2(1, 1):
				anim_done = false
				state = "hiding"
				anim.play("hiding")
			if abs(temp.x) >= 4:
				if wait_pos.x < position.x:
					velocity.x -= accel
				if wait_pos.x >  position.x:
					velocity.x += accel
			if abs(temp.y) > 4:
				if wait_pos.y <  position.y:
					velocity.y -= accel
				if wait_pos.y >  position.y:
					velocity.y += accel
			elif abs(temp.y) <= 4: #hehe
					velocity.y = 0
			velocity.x = clamp(velocity.x, -speed, speed)
			velocity.y = clamp(velocity.y, -speed, speed)
			velocity = move_and_slide(velocity)

func _player_trigger():
	for i in detection_area.get_overlapping_bodies():
		if i.is_in_group("player") and i.light.visible == true:
			return i
	return false

func _on_AnimationPlayer_animation_finished(anim_name):
	anim_done = true
