extends Node2D


func _ready():
	$Player.connect("player_stillness_achieved", self, "_player_stillness_achieved")
	if Global.player_position_before_cutscene:
		$Player/PlayerBody.global_position = Global.player_position_before_cutscene


func _player_stillness_achieved()->void:
	var distance = $Player/PlayerBody.global_position.distance_to($WitchNPC/KinematicBody2D.global_position)
	if distance < 75:
		Global.player_position_before_cutscene = $Player/PlayerBody.global_position
		get_tree().change_scene("res://cutscene/WitchHealedCutscene.tscn")
