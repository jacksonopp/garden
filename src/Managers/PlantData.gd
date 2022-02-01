extends Node

class PlantMetadata:
	enum Type {
		WEED,
		PINK_FLOWER
	}

class Plant:
	var type: int
	var Scene: PackedScene
	var name: String
	
	func _init(type: int, Scene: PackedScene, name: String) -> void:
		self.type = type
		self.Scene = Scene
		self.name = name
		
var weed = Plant.new(
	PlantMetadata.Type.WEED,
	preload("res://src/Plants/Weed.tscn"),
	"Weed"
)

var pink_flower = Plant.new(
	PlantMetadata.Type.PINK_FLOWER,
	preload("res://src/Plants/PinkFlower.tscn"),
	"Pink Flower"
)
