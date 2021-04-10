extends Node2D

func _ready():
	$PlayerCanvasLayer/Watch.visible = false

func _input(event):
	if Input.is_action_just_pressed("check_watch"):
		$PlayerCanvasLayer/Watch.visible = true
	if Input.is_action_just_released("check_watch"):
		$PlayerCanvasLayer/Watch.visible = false
