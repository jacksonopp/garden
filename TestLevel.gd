extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Custom_Tile_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print(event)


func _on_UI_next_pressed() -> void:
	pass # Replace with function body.


func _on_UI_selection_pressed(value) -> void:
	pass # Replace with function body.
