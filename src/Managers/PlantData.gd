extends Node

class PlantMetadata:
	enum Type {
		WEED,
		PINK_FLOWER
	}

class Plant:
	var type: int
	
	var Scene: PackedScene
	
	func _init(type: int, Scene: PackedScene) -> void:
		self.type = type
		self.Scene = Scene
		
var weed = Plant.new(
	PlantMetadata.Type.WEED,
	preload("res://src/Plants/Weed.tscn")
)

var pink_flower = Plant.new(
	PlantMetadata.Type.PINK_FLOWER,
	preload("res://src/Plants/PinkFlower.tscn")
)
