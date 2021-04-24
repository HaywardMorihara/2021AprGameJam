extends Node2D


func _ready():
	$Player.connect("player_stillness_achieved", self, "_player_stillness_achieved")
#	if not HomeMusic.playing:
#		MazeMusic.stop()
#		HomeMusic.play()

func _player_stillness_achieved()->void:
	var distance = $Player.global_position.distance_to($DaughterNPC.global_position)
	if distance < 75:
		Global.reset()
		get_tree().change_scene("res://cutscene/WinCutscene.tscn")
