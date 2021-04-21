extends Node2D


func _ready():
	if Global.next_exit_map_position:
		$YSort/Player.global_position = Global.next_exit_map_position
	if Global.previous_scene == "res://map/Map.tscn":
		$YSort/Player.global_position = $MazeExit/EntrancePosition.global_position
	# So we can turn it off for development
	$CanvasModulate.visible = true
	Global.previous_scene = ""
	if not MazeMusic.playing:
		HomeMusic.stop()
		MazeMusic.play()
