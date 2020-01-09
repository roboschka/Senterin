extends Node

var multiplier
var purchased = false

func _ready():
	multiplier = 3 #int(OS.get_screen_size().x / 512)
#	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if Input.is_action_just_pressed("full_screen_toggle"):
		if !OS.window_fullscreen:
			OS.window_fullscreen = !OS.window_fullscreen
#			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED,SceneTree.STRETCH_ASPECT_IGNORE, Vector2(512, 288), multiplier)
#			get_viewport().set_global_canvas_transform(Transform2D(Vector2(1, 0), Vector2(0, 1), Vector2(0, 0)))
		else:
			OS.window_fullscreen = !OS.window_fullscreen
#			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED,SceneTree.STRETCH_ASPECT_IGNORE, Vector2(512, 288))
#			get_viewport().set_canvas_transform(Transform2D(Vector2(1, 0), Vector2(0, 1), Vector2(0, 0)))