extends "res://npc/DialogueArea.gd"


func determine_dialogue()->Array:
	if not Global.has_player_healed_witch:
		return ["Daddy! Please stay and play with me!"]
	else:
		return ["Daddy I missed you! Please spend 10 SECONDS with me?"]
