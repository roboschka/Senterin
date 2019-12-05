extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scene_path_to_load
# Called when the node enters the scene tree for the first time.
func _ready():
	#$Menu/CenterRow/Buttons/NewGameButton.grab_focus()
#	$FadeOut.show()
#	$FadeOut.fade_out()
	for button in $menu/center_row/buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
		

func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	get_tree().change_scene(scene_path_to_load);
#	$FadeIn.show()
#	$FadeIn.fade_in()

#func _on_FadeIn_fade_finished():
#	print(scene_path_to_load)
#	if scene_path_to_load == "Exit":
#		get_tree().quit()
#	else:
#		get_tree().change_scene(scene_path_to_load)
#
#
#func _on_FadeOut_fade_finished():
#	$FadeOut.queue_free()
