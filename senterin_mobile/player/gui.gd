tool
extends CanvasLayer

func _ready():
	if Engine.editor_hint:
		for i in get_children():
			if not i.is_in_group("pause_menu") and i.name != "AudioStreamPlayer":
				i.visible = false
	else:
		for i in get_children():
			if not i.is_in_group("pause_menu") and i.name != "AudioStreamPlayer":
				i.visible = true

func _on_button_pressed():
	$AudioStreamPlayer.play()


func _on_TextureButton_pressed():
	get_tree().paused = true
	get_node("pause_menu").visible = true
	for i in get_children():
		if not i is AudioStreamPlayer and not i.is_in_group("pause_menu"):
			i.visible = false
