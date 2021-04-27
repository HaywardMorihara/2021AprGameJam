extends "res://npc/DialogueArea.gd"


func determine_dialogue()->Array:
	if not Global.has_player_healed_witch:
		return [
			"Hello stranger!",
			"Curse your daughter?? I've done no such thing! What do you take me for, a witch??",
			"Please, spend 10 SECONDS with me! It gets so lonely in these woods! Just 10 SECONDS OF STILLNESS",
			"It doesn't count if you're scurrying around or checking the time!"]
	else:
		return ["Go heal your daughter! Just spend 10 SECONDS with her! That's all it takes! 10 SECONDS OF STILLNESS",
		"You should try it yourself! STAY STILL FOR 10 SECONDS - you may find that you're able to see more clearly!"]
