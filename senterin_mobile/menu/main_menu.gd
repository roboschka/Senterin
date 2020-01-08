extends Control
export var scene_to_load: PackedScene

func _ready():
	#Test
	$FadeOut.show()
	$FadeOut.fade_out()
	for button in $menu/center_row/buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed",[button.has_another_scene])
		
func _on_Button_pressed(has_another_scene):
	if(has_another_scene == 0):
		get_tree().quit()
	else:
		$FadeIn.show()
		$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene_to(scene_to_load)

func _on_FadeOut_fade_finished():
	$FadeOut.queue_free()
