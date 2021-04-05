extends KinematicBody2D

export var speed = 200  # speed in pixels/sec

var velocity = Vector2.ZERO

func _get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		print('right')
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	# Make sure diagonal movement isn't faster

	velocity = velocity.normalized() * speed

func _physics_process(delta):
	_get_input()
	print("moving %s" % velocity)
	velocity = move_and_slide(velocity)
