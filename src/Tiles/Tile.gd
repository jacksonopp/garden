extends Area2D

class_name GameTile

var has_plant = false

onready var highlight = $Highlight

func place_plant(plant) -> void:
	var p = plant.Scene.instance()
	self.add_child(p)
	has_plant = true


func _on_Tile_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print(viewport, event, shape_idx)
