extends Button

export(int) var has_another_scene;
export var scene_to_load: PackedScene
export(String) var level
export(bool) var is_unlocked

onready var level_label = $Label

func _ready():
	setup()
func setup():
	level_label.text = level

func _on_Button_pressed():
	if level == "2" and get_tree().root.get_node("/root/global").purchased == false:
		get_node("../../../../ToolButton").emit_signal("pressed") 
	$AudioStreamPlayer.play()

func _on_AudioStreamPlayer_finished():
	if level == "2" and get_tree().root.get_node("/root/global").purchased == true:
		get_tree().change_scene_to(scene_to_load)
	elif level == "2" and get_tree().root.get_node("/root/global").purchased == false:
		pass
	else:
		get_tree().change_scene_to(scene_to_load)
