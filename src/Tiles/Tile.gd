extends Area2D

class_name GameTile

var has_plant = false

onready var highlight = $Highlight

signal plant_placed()

func place_plant(plant) -> void:
	var p = plant.Scene.instance()
	self.add_child(p)
	has_plant = true


func _on_Tile_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if highlight.visible:
			place_plant(GameManager.plant_to_place)
			emit_signal("plant_placed")
