extends Control

var show_selection_buttons = false

onready var selection_buttons := $SideBar/SelectionButtons
onready var selection_one_btn := $SideBar/SelectionButtons/SelectionOne
onready var selection_two_btn := $SideBar/SelectionButtons/SelectionTwo

signal next_pressed()
signal selection_pressed(value)

func _ready() -> void:
	selection_buttons.visible = false

func set_selection_button_text(selections: Array) -> void:
	selection_buttons.visible = true
	var selection_texts: Array
	for selection in selections:
		var sel = ""
		match selection:
			WorldNode.PlacementPattern.BOX:
				sel += "Box"
			WorldNode.PlacementPattern.HORIZONTAL:
				sel += "Horiz"
			WorldNode.PlacementPattern.VERTICAL:
				sel += "Vert"
		selection_texts.append(sel)
		
	selection_one_btn.text = selection_texts[0]
	selection_two_btn.text = selection_texts[1]
	
func _on_Button_pressed() -> void:
	emit_signal("next_pressed")


func _on_SelectionOne_pressed() -> void:
	emit_signal("selection_pressed", 0)


func _on_SelectionTwo_pressed() -> void:
	emit_signal("selection_pressed", 1)
