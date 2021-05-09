extends Area2D


func _on_InteractionArea_area_entered(area):
	if area.has_method("teach"):
		area.teach(["npc_talk"])
