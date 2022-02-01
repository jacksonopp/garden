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
	var chance_for_growth: int
	
	func _init(type: int, Scene: PackedScene, name: String, chance_for_growth) -> void:
		self.type = type
		self.Scene = Scene
		self.name = name
		self.chance_for_growth = chance_for_growth
		
var weed = Plant.new(
	PlantMetadata.Type.WEED,
	preload("res://src/Plants/Weed.tscn"),
	"Weed",
	8
)

var pink_flower = Plant.new(
	PlantMetadata.Type.PINK_FLOWER,
	preload("res://src/Plants/PinkFlower.tscn"),
	"Pink Flower",
	0
)
