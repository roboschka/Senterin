extends Node2D

export var battery:PackedScene

func _respawn_batteries(batteries_coordinate):
	for i in batteries_coordinate:
		var new_battery = battery.instance()
		new_battery.set_name("battery")
		new_battery.position = i
		add_child(new_battery)
		new_battery.set_owner(get_parent())
