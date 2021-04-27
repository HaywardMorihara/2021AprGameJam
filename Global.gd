extends Node


var next_exit_map_position : Vector2
var has_player_entered_witch_house : bool = false
var player_position_before_cutscene : Vector2
var has_player_healed_witch : bool = false
var previous_scene := "res://map/Map.tscn"
var has_intro_animation_played := false

# Tutorials
var has_move_and_talk_tutorial_played := false
var has_watch_tutorial_played := false
var has_print_tutorial_played := false

func reset():
	next_exit_map_position = Vector2.ZERO
	has_player_entered_witch_house = false
	player_position_before_cutscene = Vector2.ZERO
	has_player_healed_witch = false
	previous_scene = "res://map/Map.tscn"
	has_intro_animation_played = false
	has_move_and_talk_tutorial_played = false
	has_watch_tutorial_played = false
	has_print_tutorial_played = false
	HomeMusic.stop()
	MazeMusic.stop()
