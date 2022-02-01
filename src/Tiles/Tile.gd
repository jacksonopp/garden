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
	if highlight.visible:
		if event is InputEventMouseButton and event.is_pressed():
			place_plant_on_click()

func place_plant_on_click() -> void:
	if highlight.visible:
		place_plant(GameManager.plant_to_place)
		emit_signal("plant_placed")


func _on_Tile_mouse_entered() -> void:
	if highlight.visible:
		var p = GameManager.plant_to_place.Scene.instance()
		self.add_child(p)


func _on_Tile_mouse_exited() -> void:
	if highlight.visible and !has_plant:
		var children = get_children().size()
		var plant_child = get_child(children - 1)
		plant_child.queue_free()
