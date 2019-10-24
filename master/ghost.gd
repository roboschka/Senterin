extends KinematicBody2D

onready var wait_pos = position
var velocity = Vector2()
var accel = 8
var speed = 32

func _physics_process(delta):
	if! $Area2D2.get_overlapping_bodies().empty():
		for i in $Area2D2.get_overlapping_bodies():
			if i.is_in_group("player") and i.light.visible == true:
				if i.position.x > position.x:
					velocity.x += accel
				if i.position.x < position.x:
					velocity.x -= accel
				if i.position.y > position.y:
					velocity.y += accel
				if i.position.y < position.y:
					velocity.y -= accel
				velocity.x = clamp(velocity.x, -speed, speed)
				velocity.y = clamp(velocity.y, -speed, speed)
				velocity = move_and_slide(velocity)
#			else:
#				if position != wait_pos:
#					if wait_pos.x > position.x:
#						velocity.x += accel
#					if wait_pos.x < position.x:
#						velocity.x -= accel
#					if wait_pos.y > position.y:
#						velocity.y += accel
#					if wait_pos.y < position.y:
#						velocity.y -= accel
#					velocity.x = clamp(velocity.x, -speed, speed)
#					velocity.y = clamp(velocity.y, -speed, speed)
#					velocity = move_and_slide(velocity)