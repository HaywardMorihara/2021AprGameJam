extends Control


func _process(delta)->void:
	if visible:
		$RichTextLabel.text = str(int(GlobalTimer.time_left))
