extends Node2D


func _ready():
	$Player.connect("player_stillness_achieved", self, "_player_stillness_achieved")
#	if not HomeMusic.playing:
#		MazeMusic.stop()
#		HomeMusic.play()
	if not Global.has_intro_animation_played:
		Global.has_intro_animation_played = true
		get_tree().paused = true
		$AnimationPlayer.play("MovePlayer")


func _player_stillness_achieved()->void:
	var distance = $Player.global_position.distance_to($DaughterNPC.global_position)
	if distance < 75:
		Global.reset()
		get_tree().change_scene("res://cutscene/WinCutscene.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().paused = false
	if not Global.has_move_and_talk_tutorial_played:
		$Player.teach(["move", "talk"])
