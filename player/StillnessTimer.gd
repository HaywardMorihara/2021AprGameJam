extends Timer

signal stillness_achieved


# For debugging
func _process(delta)->void:
	if time_left > 0:
		print(time_left)

func _on_StillnessTimer_timeout():
	emit_signal("stillness_achieved")
