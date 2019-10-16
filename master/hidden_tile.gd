extends StaticBody2D

func _on_Area2D_area_entered(area):
	if area.is_in_group("light"):
		layers = 1
		$AnimationPlayer.play("appear")

func _on_Area2D_area_exited(area):
	if area.is_in_group("light"):
		layers = 2
		$AnimationPlayer.play("dissapear")