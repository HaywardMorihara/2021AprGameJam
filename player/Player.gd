extends KinematicBody2D


signal player_stillness_achieved 

export var walk_speed = 100  # speed in pixels/sec
export var sprint_speed = 400
export var is_outside : bool

var velocity = Vector2.ZERO

var require_sprint_release := false

func _ready():
	$PlayerCanvasLayer/Watch.visible = false
	$StillnessTimer.start()
	$StillnessTimer.connect("stillness_achieved", self, "_stillness_achieved")
	$PlayerAnimation.playing = true
	$Light2D.visible = is_outside
	$PlayerCanvasLayer/SprintBar.visible = is_outside
	
	# TODO Put where it actually belongs
	$PlayerCanvasLayer/DialoguePopup.popup()

func _get_input():
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


func _physics_process(delta):
	_get_input()
	velocity = move_and_slide(velocity)


func _input(event):
	if Input.is_action_just_pressed("check_watch"):
		$PlayerCanvasLayer/Watch.visible = true
		$StillnessTimer.stop()
	if Input.is_action_just_released("check_watch"):
		$PlayerCanvasLayer/Watch.visible = false
		$StillnessTimer.start()


func _stillness_achieved():
	# TODO We'll probably want to do some other fancy things
#	global_position.distance_to()
	emit_signal("player_stillness_achieved")
	if is_outside:
		$PlayerCanvasLayer/SprintBar.value = 1000
		$Camera2D.zoom = Vector2(1,1)
		$Light2D.scale = Vector2(45,45)
