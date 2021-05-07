extends Node2D

export var destination_scene : String
export var is_witch_house : bool

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Entrance.destination_scene = destination_scene
	$Entrance.is_witch_entrance = is_witch_house


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
