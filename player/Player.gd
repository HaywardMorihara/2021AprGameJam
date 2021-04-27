extends KinematicBody2D


signal player_stillness_achieved 

export var walk_speed = 100  # speed in pixels/sec
export var sprint_speed = 400
export var is_outside : bool

var velocity = Vector2.ZERO

var require_sprint_release := false
var is_in_dialogue := false
var is_in_animation := false

var tutorials_queued := []

func _ready():
	$PlayerCanvasLayer/Watch.visible = false
	$StillnessTimer.start()
	$StillnessTimer.connect("stillness_achieved", self, "_stillness_achieved")
	$PlayerAnimation.playing = true
	$Light2D.visible = is_outside
	$PlayerCanvasLayer/SprintBar.visible = is_outside

	

func _get_input():
	if not is_in_animation:
		velocity = Vector2.ZERO
		if Input.is_action_pressed('right'):
			velocity.x += 1
			$StillnessTimer.start()
		if Input.is_action_pressed('left'):
			velocity.x -= 1
			$StillnessTimer.start()
		if Input.is_action_pressed('down'):
			velocity.y += 1
			$StillnessTimer.start()
		if Input.is_action_pressed('up'):
			velocity.y -= 1
			$StillnessTimer.start()
		
		if Input.is_action_just_released("sprint"):
			require_sprint_release = false
		
		var speed : float
		if is_outside and Input.is_action_pressed('sprint') and $PlayerCanvasLayer/SprintBar.value > 2 and not require_sprint_release:
			speed = sprint_speed
			$PlayerAnimation.speed_scale = 2
			$PlayerCanvasLayer/SprintBar.value -= 2
			if $Camera2D.zoom.x > 0.5 and $Camera2D.zoom.y > 0.5:
				$Camera2D.zoom -= Vector2(0.002, 0.002)
			if $Light2D.scale.x > 15 and $Light2D.scale.y > 15:
				$Light2D.scale -= Vector2(0.07,0.07)
		else:
			speed = walk_speed
			$PlayerAnimation.speed_scale = 1
			if $PlayerCanvasLayer/SprintBar.value < 100:
				$PlayerCanvasLayer/SprintBar.value += 1
				
		if $PlayerCanvasLayer/SprintBar.value <= 2:
			require_sprint_release = true
		
		# Make sure diagonal movement isn't faster
		velocity = velocity.normalized() * speed
		
		# TODO Probably should have this somehwere else...but I think it needs to
		# be part of _physics_process for optmization
		if velocity.length() == 0:
			$PlayerAnimation.animation = "still_down"
		elif abs(velocity.x) >= abs(velocity.y):
			if velocity.x < 0:
				$PlayerAnimation.animation = "moving_left"
			else:
				$PlayerAnimation.animation = "moving_right"
		else:
			if velocity.y < 0:
				$PlayerAnimation.animation = "moving_up"
			else:
				$PlayerAnimation.animation = "moving_down"


func animate_up():
	is_in_animation = true
	$PlayerAnimation.animation = "moving_up"
	$PlayerAnimation.playing = true
	$PlayerAnimation.play()


func animate_stop():
	$PlayerAnimation.animation = "still_down"
	$PlayerAnimation.stop()
	is_in_animation = false
	

func animation_dialogue(speaker : String, dialogue : Array):
	$PlayerCanvasLayer/DialoguePopup.dialogue_popup(speaker, dialogue)
	
func animation_dialogue_stop():
	$PlayerCanvasLayer/DialoguePopup.dialogue_stop()	

func teach(actions : Array):
	$PlayerCanvasLayer/Tutorials.teach(actions)

func _physics_process(delta):
	_get_input()
	velocity = move_and_slide(velocity)


func _input(event):
	if Input.is_action_just_pressed("check_watch"):
		if GlobalTimer.is_stopped():
			GlobalTimer.start()
		$PlayerCanvasLayer/Watch.visible = true
		$StillnessTimer.stop()
	if Input.is_action_just_released("check_watch"):
		$PlayerCanvasLayer/Watch.visible = false
		$StillnessTimer.start()
	if Input.is_action_just_pressed("interact"):
		if is_in_dialogue:
			is_in_dialogue = false
		elif not is_in_dialogue and $InteractionArea.get_overlapping_areas():
			for area in $InteractionArea.get_overlapping_areas():
				if area.has_method("determine_dialogue") and area.has_method("determine_speaker"):
					$PlayerCanvasLayer/DialoguePopup.dialogue_popup(area.determine_speaker(), area.determine_dialogue())
					is_in_dialogue = true
					# TODO I REALLY don't like this but you gotta do what you gotta do
					if area.name == "DoctorDialogueArea" and not Global.has_watch_tutorial_played:
						tutorials_queued.append("watch")
						if GlobalTimer.is_stopped():
							GlobalTimer.start()


func _stillness_achieved():
	# TODO We'll probably want to do some other fancy things
#	global_position.distance_to()
	emit_signal("player_stillness_achieved")
	if is_outside:
		$PlayerCanvasLayer/SprintBar.value = 1000
		$Camera2D.zoom = Vector2(1,1)
		$Light2D.scale = Vector2(45,45)


func _on_DialoguePopup_dialogue_complete():
	if tutorials_queued:
		$PlayerCanvasLayer/Tutorials.teach([tutorials_queued.pop_front()])
