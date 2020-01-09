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
	get_tree().change_scene_to(scene_to_load)
