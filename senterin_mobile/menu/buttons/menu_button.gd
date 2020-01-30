extends TextureButton

export(int) var has_another_scene;

func _on_Button_pressed():
	$AudioStreamPlayer.play()
