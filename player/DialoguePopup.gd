extends Popup

func _ready()->void:
	set_process_input(false)
	$ProceedLabel.visible = false


func dialogue_popup()->void:
	popup()
	get_tree().paused = true
	$AnimationPlayer.play("ShowDialogue")


func _input(event)->void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("interact"):
			get_tree().paused = false
			hide()


func _on_AnimationPlayer_animation_finished(anim_name):
	set_process_input(true)
