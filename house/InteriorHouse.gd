extends Node2D


func _ready():
	$Player.connect("player_stillness_achieved", self, "_player_stillness_achieved")


func _player_stillness_achieved()->void:
	var distance = $Player/PlayerBody.global_position.distance_to($DaughterNPC/KinematicBody2D.global_position)
	if distance < 75:
		get_tree().change_scene("res://cutscene/WinCutscene.tscn")
