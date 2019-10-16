extends Node

var multiplier

func _ready():
	multiplier = round(OS.get_screen_size().x / 512)

func _input(event):
	if Input.is_action_just_pressed("full_screen_toggle"):
		if !OS.window_fullscreen:
			OS.window_fullscreen = !OS.window_fullscreen
			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED,SceneTree.STRETCH_ASPECT_IGNORE, Vector2(512, 288), multiplier)
		else:
			OS.window_fullscreen = !OS.window_fullscreen
			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED,SceneTree.STRETCH_ASPECT_IGNORE, Vector2(512, 288), 1)