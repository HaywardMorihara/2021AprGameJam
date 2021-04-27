extends Control

const SPRINT = preload("res://tutorial/SprintTutorial.tscn")
const TALK = preload("res://tutorial/TalkTutorial.tscn")
const WATCH = preload("res://tutorial/WatchTutorial.tscn")
const MOVE = preload("res://tutorial/MoveTutorial.tscn")

var actions_to_teach := []
var is_tutorial_in_session := false

func teach(actions : Array):
	actions_to_teach += actions
	if not is_tutorial_in_session:
		teach_action(actions_to_teach.pop_front())

func teach_action(action : String):
	is_tutorial_in_session = true
	match action:
		"sprint":
			Global.has_print_tutorial_played = true
			start(SPRINT.instance())
		"talk":
			Global.has_move_and_talk_tutorial_played = true
			start(TALK.instance())
		"move":
			Global.has_move_and_talk_tutorial_played = true
			start(MOVE.instance())
		"watch":
			Global.has_watch_tutorial_played = true
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
	else:
		is_tutorial_in_session = false
