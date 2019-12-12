extends Control

var scene_path_to_load
func _ready():
	$FadeOut.show()
	$FadeOut.fade_out()
	for button in $menu/centre_row/buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
		

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)

func _on_FadeOut_fade_finished():
	$FadeOut.queue_free()

