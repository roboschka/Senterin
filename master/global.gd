extends Node

var multiplier
#
#func _enter_tree():
#	ProjectSettings.set("display/window/size/width", OS.get_screen_size().x)
#	ProjectSettings.set("display/window/size/height", OS.get_screen_size().y)
#	ProjectSettings.set("display/window/size/fullscreen", true)
#	print(ProjectSettings.get("display/window/size/width"))
#	print(ProjectSettings.get("display/window/size/height"))

func _ready():
	multiplier = int(OS.get_screen_size().x / 512)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if Input.is_action_just_pressed("full_screen_toggle"):
		if !OS.window_fullscreen:
			OS.window_fullscreen = !OS.window_fullscreen
			get_viewport().set_canvas_transform(Transform2D(Vector2(1, 0), Vector2(0, 1), Vector2(0, 0)))
			print(get_viewport().get_canvas_transform())
#			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED,SceneTree.STRETCH_ASPECT_IGNORE, Vector2(512, 288), multiplier)
		else:
			OS.window_fullscreen = !OS.window_fullscreen
			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED,SceneTree.STRETCH_ASPECT_IGNORE, Vector2(512, 288), 1)