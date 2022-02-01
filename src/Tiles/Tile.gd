extends Area2D

class_name GameTile

var has_plant = false
var plant_on_tile: int
var life_of_plant = 0
var chance_for_growth: int
var flash_plant = false
var show_temp_plant = false
var will_spawn_plant = false

onready var highlight = $Highlight
onready var grow_highlight = $GrowHighlight
onready var flash_timer = $FlashTimer

signal plant_placed()

func place_plant(plant) -> void:
	var p = plant.Scene.instance()
	self.add_child(p)
	has_plant = true
	plant_on_tile = plant.type
	chance_for_growth = plant.chance_for_growth

func place_temp_plant(plant) -> void:
	var p = plant.Scene.instance()
	self.add_child(p)

func add_plant_life() -> void:
	life_of_plant += 1

func _on_Tile_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if highlight.visible:
		if event is InputEventMouseButton and event.is_pressed():
			place_plant_on_click()

func place_plant_on_click() -> void:
	if highlight.visible:
		place_plant(GameManager.plant_to_place)
		emit_signal("plant_placed")

func toggle_flashing_plant(on: bool) -> void:
	if on:
		flash_timer.start()
	else:
		flash_timer.stop()

func toggle_grow_highlight(on: bool) -> void:
	grow_highlight.visible = on

func _on_Tile_mouse_entered() -> void:
	if highlight.visible:
		var p = GameManager.plant_to_place.Scene.instance()
		self.add_child(p)

func _on_Tile_mouse_exited() -> void:
	if highlight.visible and !has_plant:
		var children = get_children().size()
		var plant_child = get_child(children - 1)
		plant_child.queue_free()


func _on_FlashTimer_timeout() -> void:
	var plant_child = get_child(get_children().size() - 1)
	if show_temp_plant:
		plant_child.visible = true
		show_temp_plant = false
	else:
		plant_child.visible = false
		show_temp_plant = true
	pass # Replace with function body.
