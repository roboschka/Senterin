tool
extends CanvasLayer

func _ready():
	if Engine.editor_hint:
		for i in get_children():
			if not i.is_in_group("pause_menu"):
				i.visible = false
	else:
		for i in get_children():
			if not i.is_in_group("pause_menu"):
				i.visible = true