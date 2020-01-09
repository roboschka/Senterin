extends Area2D

export var destination:PackedScene

func _on_door_body_entered(body):
	if body.is_in_group("player"):
		$ColorRect.show()
		$ColorRect.fade_in()
		


func _on_ColorRect_fade_finished():
	get_tree().change_scene_to(destination)
