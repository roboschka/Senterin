extends Control

export var scene_to_load: PackedScene

func _ready():
	for button in $menu/centre_row/buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed",[button.has_another_scene])


func _on_Button_pressed(has_another_scene):
	if(has_another_scene == 1):
		$FadeIn.show()
		$FadeIn.fade_in()
	else:
		get_tree().paused = false
		visible = false
		if get_parent():
			for i in get_parent().get_children():
				if not i is AudioStreamPlayer and not i.is_in_group("pause_menu"):
					i.visible = true

func _on_FadeIn_fade_finished():
	get_tree().paused = false
	visible = false
	get_tree().change_scene_to(scene_to_load)
