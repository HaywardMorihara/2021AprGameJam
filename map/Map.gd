extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.next_exit_map_position:
		$YSort/Player.global_position = Global.next_exit_map_position
	if Global.previous_scene == "res://map/Maze.tscn":
		$YSort/Player.global_position = $MazeEntrance/ExitPosition.global_position
	# Set map visibility to false so we don't jump to player position...lol this is a baad hack, should probably just fix it
	visible = true
	# So that we can have it bright while doing work 
	$CanvasModulate.visible = true
	Global.previous_scene = ""
