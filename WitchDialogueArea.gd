extends "res://npc/DialogueArea.gd"


func determine_dialogue()->Array:
	if not Global.has_player_healed_witch:
		return ["Hello stranger! Please, spend 10 seconds with me!"]
	else:
		return ["Go heal your daughter! Spend 10 seconds with her!"]
