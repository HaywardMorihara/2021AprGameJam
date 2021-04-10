extends Control


func _process(delta)->void:
	if visible:
		$RichTextLabel.text = str(GlobalTimer.time_left)
