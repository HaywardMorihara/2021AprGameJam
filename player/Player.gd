extends KinematicBody2D


signal player_stillness_achieved 

export var speed = 200  # speed in pixels/sec
export var is_light_on := false

var velocity = Vector2.ZERO


func _ready():
	$PlayerCanvasLayer/Watch.visible = false
	$StillnessTimer.start()
	$StillnessTimer.connect("stillness_achieved", self, "_stillness_achieved")
	$PlayerAnimation.playing = true
	$Light2D.visible = is_light_on

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
