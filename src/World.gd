extends Node2D

class_name WorldNode

var available_placement_patterns: Array
var selected_placement_pattern: int

enum PlacementPattern {
	VERTICAL,
	HORIZONTAL,
	BOX
}

onready var grid := $Grid
onready var ui := $UI

func set_available_placements() -> void:
	available_placement_patterns.clear()
	for i in 2:
		var chance = rand_range(0, 100)
		if chance < 33:
			available_placement_patterns.append(PlacementPattern.VERTICAL)
		elif chance > 33 and chance < 66:
			available_placement_patterns.append(PlacementPattern.HORIZONTAL)
		else:
			available_placement_patterns.append(PlacementPattern.BOX)


func _on_UI_next_pressed() -> void:
	set_available_placements()
	ui.set_selection_button_text(available_placement_patterns)
	print(grid.placement_patterns)
	grid.clear_placement_patterns()
	print(grid.placement_patterns)
	for pattern in available_placement_patterns:
		match pattern:
			PlacementPattern.VERTICAL:
				grid.generate_vertical_tiles()
			PlacementPattern.HORIZONTAL:
				grid.generate_horizontal_tiles()
			PlacementPattern.BOX:
				grid.generate_box_tiles()
func _on_UI_selection_pressed(value: int) -> void:
	grid.highlight_tiles(value)
