extends Control

const SPRINT = preload("res://tutorial/SprintTutorial.tscn")
const TALK = preload("res://tutorial/TalkTutorial.tscn")
const WATCH = preload("res://tutorial/WatchTutorial.tscn")
const MOVE = preload("res://tutorial/MoveTutorial.tscn")

var actions_to_teach : Array

func teach(actions : Array):
	actions_to_teach = actions
	if actions_to_teach:
		teach_action(actions_to_teach.pop_front())

func teach_action(action : String):
	match action:
		"sprint":
			start(SPRINT.instance())
		"talk":
			start(TALK.instance())
		"move":
			start(MOVE.instance())
		"watch":
			start(WATCH.instance())
	
func start(child : Node):
	add_child(child)
	$Timer.start()
	
func stop():
	for n in get_children():
		if n.name != "Timer":
			remove_child(n)
			n.queue_free()

func _on_Timer_timeout():
	stop()
	if actions_to_teach:
		teach_action(actions_to_teach.pop_front())
