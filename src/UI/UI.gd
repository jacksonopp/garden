extends Control

var show_selection_buttons = false

onready var selection_buttons := $SideBar/SelectionButtons
onready var selection_one_btn := $SideBar/SelectionButtons/SelectionOne
onready var selection_two_btn := $SideBar/SelectionButtons/SelectionTwo
onready var bottom_bar_button := $BottomBar/Button

signal next_pressed()
signal selection_pressed(value)

func _ready() -> void:
	selection_buttons.visible = false
	bottom_bar_button.visible = true

func hide_selection_buttons() -> void:
	selection_buttons.visible = false
	
func show_bottom_bar_button() -> void:
	bottom_bar_button.visible = true

func set_selection_button_text() -> void:
	selection_buttons.visible = true
	bottom_bar_button.visible = false
	var selection_texts: Array
	for pattern in GameManager.available_placement_patterns:
		var sel = ""
		sel += get_selection_pattern_text(pattern.pattern)
		sel += " "
		sel += pattern.plant.name
		selection_texts.append(sel)

	selection_one_btn.text = selection_texts[0]
	selection_two_btn.text = selection_texts[1]

func get_selection_pattern_text(pattern: int) -> String:
	var sel_str = ""
	match pattern:
		GameManager.PlacementPattern.BOX:
			sel_str += "Box"
		GameManager.PlacementPattern.HORIZONTAL:
			sel_str += "Horiz"
		GameManager.PlacementPattern.VERTICAL:
			sel_str += "Vert"
	return sel_str

func _on_Button_pressed() -> void:
	emit_signal("next_pressed")


func _on_SelectionOne_pressed() -> void:
	emit_signal("selection_pressed", 0)


func _on_SelectionTwo_pressed() -> void:
	emit_signal("selection_pressed", 1)
