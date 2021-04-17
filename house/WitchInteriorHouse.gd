extends Node2D


func _ready():
	$Player.connect("player_stillness_achieved", self, "_player_stillness_achieved")
	if Global.player_position_before_cutscene:
		$Player.global_position = Global.player_position_before_cutscene


func _player_stillness_achieved()->void:
	var distance = $Player.global_position.distance_to($WitchNPC/KinematicBody2D.global_position)
	if distance < 75 && not Global.has_player_healed_witch:
		Global.has_player_healed_witch = true
		Global.player_position_before_cutscene = $Player.global_position
		get_tree().change_scene("res://cutscene/WitchHealedCutscene.tscn")
