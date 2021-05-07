extends "res://npc/DialogueArea.gd"


func determine_dialogue()->Array:
	if not Global.has_player_healed_witch:
		return [
			"Your daughter is cursed! It's that WITCH to the NORTH! She's cursed her!",
			"You'll have to venture to the woods NORTH of here! Find the witch and make her reverse the curse to save your daughter!",
			"Keep your eye on the TIME! I don't think your daughter has more than 5 MINUTES LEFT!",
			"HURRY HURRY HURRY!"
		]
	else:
		return ["What are you doing back?? Did you get the witch to stop the curse?"]
