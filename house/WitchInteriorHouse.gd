extends Node2D


func _ready():
	$Player.connect("player_stillness_achieved", self, "_player_stillness_achieved")
	if Global.player_position_before_cutscene:
		$Player.global_position = Global.player_position_before_cutscene
		Global.player_position_before_cutscene = Vector2()
	if not HomeMusic.playing:
		MazeMusic.stop()
		HomeMusic.play()


func _player_stillness_achieved()->void:
	var distance = $Player.global_position.distance_to($WitchNPC.global_position)
	if distance < 75 && not Global.has_player_healed_witch:
		Global.has_player_healed_witch = true
		Global.player_position_before_cutscene = $Player.global_position
		# I don't think we're doing cutscenes like this...an animation would be ideal
#		get_tree().change_scene("res://cutscene/WitchHealedCutscene.tscn")
		$Player.animation_dialogue("Witch", ["Ahhh that's much better! Thank you very much for your time!"])
