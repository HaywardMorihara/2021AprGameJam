extends Popup

var speaker : String
var dialogues := PoolStringArray()

func _ready()->void:
	_reset()

func dialogue_popup(speaker_param : String, dialogues_param : PoolStringArray)->void:
	speaker = speaker_param
	dialogues = dialogues_param
	dialogue_next()
	
func dialogue_next():
	_reset()
	$SpeakerLabel.text = "%s:" % speaker
	$DialogueLabel.text = dialogues.pop()
	popup()
	get_tree().paused = true
	$AnimationPlayer.play("ShowDialogue")
	
func dialogue_stop()->void:
	hide()
	get_tree().paused = false 
	$ProceedLabel.visible = false
	$DialogueLabel.percent_visible = 0

func _reset()->void:
	set_process_input(false)
	$ProceedLabel.visible = false
	$DialogueLabel.percent_visible = 0

func _input(event)->void:
	if Input.is_action_just_pressed("interact"):
		dialogue_stop()

func _on_AnimationPlayer_animation_finished(anim_name):
	set_process_input(true)
