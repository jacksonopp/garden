extends Node2D

class_name WorldNode

#var available_placement_patterns: Array

enum PlacementPattern {
	VERTICAL,
	HORIZONTAL,
	BOX
}

onready var grid := $Grid
onready var ui := $UI

func set_available_placements() -> void:
	GameManager.available_placement_patterns.clear()
	var placement_patterns: Array = []
	for i in 2:
		var placement_pattern: int = randi() % GameManager.PlacementPattern.size()
		var placement_plant
#		TODO: Select a plant
		placement_plant = PlantData.pink_flower
		GameManager.set_placement_patterns(placement_pattern, placement_plant)

# Clicking "Next" will set the available patterns and plants
func _on_UI_next_pressed() -> void:
	set_available_placements()
	ui.set_selection_button_text()
	grid.clear_placement_patterns()
	grid.clear_all_tile_highlights()
	for pattern in GameManager.available_placement_patterns:
		match pattern.pattern:
			PlacementPattern.VERTICAL:
				grid.generate_vertical_tiles()
			PlacementPattern.HORIZONTAL:
				grid.generate_horizontal_tiles()
			PlacementPattern.BOX:
				grid.generate_box_tiles()

# Clicking a selection option will highlight the available tiles
func _on_UI_selection_pressed(value: int) -> void:
	grid.highlight_tiles(value)
