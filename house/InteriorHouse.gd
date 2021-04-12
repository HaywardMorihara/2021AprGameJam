extends Node2D


func _ready():
	$Player.connect("player_stillness_achieved", self, "_player_stillness_achieved")


func _player_stillness_achieved()->void:
	var distance = $Player.global_position.distance_to($DaughterNPC.global_position)
	print(distance)
	# TODO Debug and Tweak this distance
	if distance < 100:
		get_tree().chance_scene("res://cutscene/WinCutscene.tscn")
