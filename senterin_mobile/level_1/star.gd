extends Area2D

func _on_star_area_entered(area):
	if area.is_in_group("player"):
		$AnimationPlayer.play("explode")

func _on_AnimationPlayer_animation_finished(anim_name):
		queue_free()
