extends Timer


func _on_Timer_timeout():
	get_tree().change_scene("res://cutscene/GameOverCutscene.tscn")
