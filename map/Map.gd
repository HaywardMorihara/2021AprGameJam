extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.next_exit_map_position:
		$YSort/Player.position = Global.next_exit_map_position
	# Set map visibility to false so we don't jump to player position...lol this is a baad hack, should probably just fix it
	visible = true
