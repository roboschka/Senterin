extends Button

export var back_scene: PackedScene

func _on_Button_pressed():
	$AudioStreamPlayer.play()

func _on_AudioStreamPlayer_finished():
	get_tree().change_scene_to(back_scene)
