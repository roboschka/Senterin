extends Area2D

func _on_battery_area_entered(area):
	if area.is_in_group("player"):
		$AnimationPlayer.play("explode")