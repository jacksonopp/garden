extends Node

enum PlacementPattern {
	VERTICAL,
	HORIZONTAL,
	BOX
}

var available_placement_patterns: Array
var selected_placement_pattern: int
var selected_plant: int

var plant_to_place = null

func set_placement_patterns(pattern: int, plant) -> void:
	if available_placement_patterns.size() >= 2:
		available_placement_patterns.clear()
	var temp = {"pattern": pattern, "plant": plant}
	available_placement_patterns.append(temp)

func set_selected_plant(plant) -> void:
	plant_to_place = plant
	print(plant)
