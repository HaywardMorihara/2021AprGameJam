extends Control

const SPRINT = preload("res://tutorial/SprintTutorial.tscn")
const TALK = preload("res://tutorial/TalkTutorial.tscn")
const WATCH = preload("res://tutorial/WatchTutorial.tscn")
const MOVE = preload("res://tutorial/MoveTutorial.tscn")

func teach(action : String):
	match action:
		"sprint":
			add_child(SPRINT.instance())
		"talk":
			add_child(TALK.instance())
		"move":
			add_child(MOVE.instance())
		"watch":
			add_child(WATCH.instance())
	
	
func stop():
	for n in get_children():
		remove_child(n)
		n.queue_free()
