extends Control

const SPRINT = preload("res://tutorial/SprintTutorial.tscn")
const TALK = preload("res://tutorial/TalkTutorial.tscn")
const WATCH = preload("res://tutorial/WatchTutorial.tscn")
const MOVE = preload("res://tutorial/MoveTutorial.tscn")
const NPC_TALK = preload("res://tutorial/NPCTalkTutorial.tscn")

var actions_to_teach := []
var action_in_session := ""

func teach(actions : Array):
	if (action_in_session == "npc_talk"):
		return
	actions_to_teach += actions
	if not action_in_session:
		teach_action(actions_to_teach.pop_front())

func teach_action(action : String):
	action_in_session = action
	match action:
		"sprint":
			start(SPRINT.instance())
		"talk":
			start(TALK.instance())
		"move":
			Global.has_move_tutorial_played = true
			start(MOVE.instance())
		"watch":
			start(WATCH.instance())
		"npc_talk":
			start(NPC_TALK.instance())
	
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
	match action_in_session:
		"sprint":
			Global.has_sprint_tutorial_played = true
		"talk":
			Global.has_talk_tutorial_played = true
		"watch":
			Global.has_watch_tutorial_played = true
	if actions_to_teach:
		teach_action(actions_to_teach.pop_front())
	else:
		action_in_session = ""
