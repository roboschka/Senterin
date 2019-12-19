extends Area2D

export var destination:PackedScene

func _on_door_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to(destination)