tool
extends CanvasLayer

func _ready():
	if Engine.editor_hint:
		for i in get_children():
			i.visible = false
	else:
		for i in get_children():
			i.visible = true