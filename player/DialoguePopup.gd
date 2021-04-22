extends Popup

func popup(bounds: Rect2 = Rect2( 0, 0, 0, 0 ))->void:
	.popup(bounds)
	get_tree().paused = true

func _input(event)->void:
	if event is InputEventKey:
		if event.scancode == KEY_SPACE:
			get_tree().paused = false
			hide()
