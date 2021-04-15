extends KinematicBody2D


signal player_stillness_achieved 

export var speed = 200  # speed in pixels/sec

var velocity = Vector2.ZERO


func _ready():
	$PlayerCanvasLayer/Watch.visible = false
	$StillnessTimer.start()
	$StillnessTimer.connect("stillness_achieved", self, "_stillness_achieved")
	$PlayerAnimation.playing = true

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
	
	if velocity.length() == 0:
		$PlayerAnimation.animation = "still_down"
	elif abs(velocity.x) >= abs(velocity.y):
		pass
	else:
		if velocity.y < 0:
			pass
		else:
			print("moving down")
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
