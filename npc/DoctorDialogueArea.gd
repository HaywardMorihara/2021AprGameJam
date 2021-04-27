extends "res://npc/DialogueArea.gd"


func determine_dialogue()->Array:
	if not Global.has_player_healed_witch:
		return [
			"Your daughter is cursed! It's that WITCH to the NORTH! You'll have to go to her to save your daughter!",
			"Keep your eye on the time! I don't think your daughter has more than 5 minutes left! Hurry hurry hurry!"
		]
	else:
		return ["What are you doing back?? Did you get the witch to stop the curse?"]
