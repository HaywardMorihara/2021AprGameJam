extends Node


var next_exit_map_position : Vector2
var has_player_entered_witch_house : bool = false
var player_position_before_cutscene : Vector2
var has_player_healed_witch : bool = false
var previous_scene := "res://map/Map.tscn"

func reset():
	next_exit_map_position = Vector2.ZERO
	has_player_entered_witch_house = false
	player_position_before_cutscene = Vector2.ZERO
	has_player_healed_witch = false
	previous_scene = "res://map/Map.tscn"
