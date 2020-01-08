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
		pass
		#Resume Game here

func _on_FadeIn_fade_finished():
	get_tree().change_scene_to(scene_to_load)