extends Node2D

export(int) var spawn_chance := 50
export var box_size = Vector2(5,4)

var all_tiles: Array
const tile_size := 16.0
var map_size = Vector2(20, 16)
var available_placement_patterns: Array
var placement_patterns: Array = []

var Tile = preload("res://src/Tiles/Tile.tscn")

signal plant_placed()

func _ready() -> void:
	randomize()
	generate_grid()
	all_tiles = get_tree().get_nodes_in_group("Tiles")
	
	for i in range(all_tiles.size()):
		var tile: GameTile = all_tiles[i]
		var chance = randi() % spawn_chance;
		if chance < 1:
			var Weed = PlantData.weed
			tile.place_plant(Weed)
		tile.connect("plant_placed", self, "_on_plant_placed")

func _on_plant_placed() -> void:
	emit_signal("plant_placed")

func generate_grid() -> void:
	for x in map_size.x:
		for y in map_size.y:
			var tile = Tile.instance()
			tile.position = Vector2(x * tile_size + 8, y * tile_size + 8)
			tile.add_to_group("Tiles")
			self.add_child(tile)

func generate_vertical_tiles() -> void:
	var rand_x = randi() % int(map_size.x + 1) * 16 - 8
	var clean_rand_x = max(rand_x, 8)
	var positions := []

	for i in range(all_tiles.size()):
		var tile: GameTile = all_tiles[i]
		if tile.position.x == clean_rand_x:
			var t = get_tile_at_position(tile.position)
			if t != null:
				positions.append(t.position)
	placement_patterns.append(positions)

func generate_horizontal_tiles() -> void:
	var rand_y = randi() % int(map_size.y + 1) * 16 - 8
	var clean_rand_y = max(rand_y, 8)
	var positions := []

	for tile in all_tiles:
		if tile.position.y == clean_rand_y:
			var t = get_tile_at_position(tile.position)
			if t != null:
				positions.append(t.position)
	
	placement_patterns.append(positions)

func generate_box_tiles() -> void:
	var box_positions: Array
	var positions := []

	var random_starting_pos = Vector2.ZERO
	random_starting_pos.x = randi() % int(map_size.x - box_size.x) * 16 - 8
	random_starting_pos.y = randi() % int(map_size.y - box_size.y) * 16 - 8
	var clean_x = max(random_starting_pos.x, 8)
	var clean_y = max(random_starting_pos.y, 8)
	random_starting_pos.x = clean_x
	random_starting_pos.y = clean_y
	box_positions.append(random_starting_pos)
	
	for x in box_size.x:
		for y in box_size.y:
			var new_box_pos = Vector2.ZERO
			new_box_pos = random_starting_pos + (Vector2(x, y) * 16)
			box_positions.append(new_box_pos)
	
	for pos in box_positions:
		var tile = get_tile_at_position(pos)
		if tile != null:
			positions.append(tile.position)
	
	placement_patterns.append(positions)

func clear_placement_patterns() -> void:
	placement_patterns.clear()

func highlight_tiles(idx: int) -> void:
	clear_all_tile_highlights()
	var highlight_pos = placement_patterns[idx]
	
	for pos in highlight_pos:
		var tile = get_tile_at_position(pos)
		if tile != null:
			tile.highlight.visible = true

func get_tile_at_position(position: Vector2) -> GameTile:
	for i in range(all_tiles.size()):
		var tile: GameTile = all_tiles[i]
		if tile.position == position and !tile.has_plant:
			return tile
	return null

func clear_all_tile_highlights() -> void:
	for tile in all_tiles:
		tile.highlight.visible = false

func grow_plants() -> void:
	print('growing plants')
	for tile in all_tiles:
		var t: GameTile = tile
		if t.has_plant:
			t.add_plant_life()
			match t.plant_on_tile:
				PlantData.PlantMetadata.Type.WEED:
					grow_weed(t)

func grow_weed(plant: GameTile) -> void:
	var neighbor_tiles = get_neighbor_tiles(plant)
	
	for t in neighbor_tiles:
		var tile: GameTile = t
		if tile != null and !tile.has_plant:
			if plant.life_of_plant % 2 == 1:
				tile.toggle_grow_highlight(true)
			if plant.life_of_plant % 2 == 0:
				tile.toggle_grow_highlight(false)
				var chance = rand_range(0, plant.chance_for_growth) < 1
				if chance:
					tile.place_temp_plant(PlantData.weed)
					tile.toggle_flashing_plant(true)

func get_neighbor_tiles(plant: GameTile) -> Array:
	var n_tile := get_tile_at_position(plant.position + Vector2(0, tile_size))
	var ne_tile := get_tile_at_position(plant.position + Vector2(tile_size, tile_size))
	var e_tile := get_tile_at_position(plant.position + Vector2(tile_size, 0))
	var se_tile := get_tile_at_position(plant.position + Vector2(tile_size, -tile_size))
	var s_tile := get_tile_at_position(plant.position + Vector2(0, -tile_size))
	var sw_tile := get_tile_at_position(plant.position + Vector2(-tile_size, -tile_size))
	var w_tile := get_tile_at_position(plant.position + Vector2(-tile_size, 0))
	var nw_tile := get_tile_at_position(plant.position + Vector2(-tile_size, tile_size))
	var neighbor_tiles = [
		n_tile,
		ne_tile,
		e_tile,
		se_tile,
		s_tile,
		sw_tile,
		w_tile,
		nw_tile
	]
	return neighbor_tiles
