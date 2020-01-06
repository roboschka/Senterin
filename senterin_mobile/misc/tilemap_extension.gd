tool
extends TileMap

export var playable:bool = false setget _set_playable
export var exposed_electric:PackedScene
export var exposed_electric_vertical:PackedScene
export var motor_oil:PackedScene
export var hidden_tile:PackedScene
export var door:PackedScene
export var destination:PackedScene
export var battery:PackedScene
export var hole_destroyer:PackedScene
export var checkpoint:PackedScene

func _set_playable(value):
	if Engine.editor_hint:
		var map_element = get_parent().get_node("map_element")
		
		if value == true:
			# exposed_electric
			for i in get_used_cells_by_id(3):
				# instance
				if get_cell(i.x, i.y - 1) == 3 or get_cell(i.x, i.y + 1) == 3:
					var new_exposed_electric = exposed_electric_vertical.instance()
					new_exposed_electric.set_name("exposed_electric")
					new_exposed_electric.position = map_to_world(i) + Vector2(8, 8)
					map_element.add_child(new_exposed_electric)
					new_exposed_electric.set_owner(get_parent())
				else:
					var new_exposed_electric = exposed_electric.instance()
					new_exposed_electric.set_name("exposed_electric")
					new_exposed_electric.position = map_to_world(i) + Vector2(8, 8)
					map_element.add_child(new_exposed_electric)
					new_exposed_electric.set_owner(get_parent())
				
				# remove tiles, because it doesnt use the same visual as the tileset
				set_cell(i.x, i.y, -1)
			
			# motor_oil
			for i in get_used_cells_by_id(4):
				# instance
				var new_motor_oil = motor_oil.instance()
				new_motor_oil.set_name("motor_oil")
				new_motor_oil.position = map_to_world(i) + Vector2(8, 8)
				map_element.add_child(new_motor_oil)
				new_motor_oil.set_owner(get_parent())
			
			# hidden_tiles
			for i in get_used_cells_by_id(5):
				# instance
				var new_hidden_tile = hidden_tile.instance()
				new_hidden_tile.set_name("hidden_tile")
				new_hidden_tile.position = map_to_world(i) + Vector2(8, 8)
				map_element.add_child(new_hidden_tile)
				new_hidden_tile.set_owner(get_parent())
				
				# remove tiles, because it doesnt use the same visual as the tileset
				set_cell(i.x, i.y, -1)
			
			# door
			for i in get_used_cells_by_id(6):
				# instance
				var new_door = door.instance()
				new_door.set_name("door")
				new_door.position = map_to_world(i) + Vector2(16, 16)
				new_door.destination = destination
				map_element.add_child(new_door)
				new_door.set_owner(get_parent())
			
			# battery
			for i in get_used_cells_by_id(8):
				# instance
				var new_battery = battery.instance()
				new_battery.set_name("battery")
				new_battery.position = map_to_world(i) + Vector2(8, 8)
				map_element.add_child(new_battery)
				new_battery.set_owner(get_parent())
				
				# remove tiles, because it doesnt use the same visual as the tileset
				set_cell(i.x, i.y, -1)
			
			# hole_destroyer
			for i in get_used_cells_by_id(9):
				# instance
				var new_hole_destroyer = hole_destroyer.instance()
				new_hole_destroyer.set_name("hole_destroyer")
				new_hole_destroyer.position = map_to_world(i) + Vector2(8, 8)
				map_element.add_child(new_hole_destroyer)
				new_hole_destroyer.set_owner(get_parent())
				
				# remove tiles, because it doesnt use the same visual as the tileset
				set_cell(i.x, i.y, -1)
			
			# checkpoint
			for i in get_used_cells_by_id(10):
				# instance
				var new_checkpoint = checkpoint.instance()
				new_checkpoint.set_name("checkpoint")
				new_checkpoint.position = map_to_world(i) + Vector2(8, 8)
				map_element.add_child(new_checkpoint)
				new_checkpoint.set_owner(get_parent())
				
				# remove tiles, because it doesnt use the same visual as the tileset
				set_cell(i.x, i.y, -1)
			
			playable = value
		else:
			# only for ones that doesnt used the tileset's visual
			for i in map_element.get_children():
				if i.is_in_group("exposed_electric"):
					set_cell(world_to_map(i.position).x, world_to_map(i.position).y, 3)
				if i.is_in_group("hidden_tile"):
					set_cell(world_to_map(i.position).x, world_to_map(i.position).y, 5)
				if i.is_in_group("battery"):
					set_cell(world_to_map(i.position).x, world_to_map(i.position).y, 8)
				if i.is_in_group("hole_destroyer"):
					set_cell(world_to_map(i.position).x, world_to_map(i.position).y, 9)
				if i.is_in_group("checkpoint"):
					set_cell(world_to_map(i.position).x, world_to_map(i.position).y, 10)
				
				i.queue_free()
			
			playable = value






