extends Popup


func _ready()->void:
	set_process_input(false)
	$ProceedLabel.visible = false
	$DialogueLabel.percent_visible = 0

func dialogue_popup(speaker : String, dialogue : String)->void:
	$SpeakerLabel.text = "%s:" % speaker
	$DialogueLabel.text = dialogue
	popup()
	get_tree().paused = true
	$AnimationPlayer.play("ShowDialogue")
	
func dialogue_stop()->void:
	hide()
	get_tree().paused = false 
	$ProceedLabel.visible = false
	$DialogueLabel.percent_visible = 0

func _input(event)->void:
	if Input.is_action_just_pressed("interact"):
		dialogue_stop()

func _on_AnimationPlayer_animation_finished(anim_name):
	set_process_input(true)
