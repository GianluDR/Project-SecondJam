extends TileMapLayer

func _physics_process(delta):
	if $"../../NpcRombo/DialogueArea2D".has_activated_already:
		$".".visible = true
		$"../../StairArea".monitoring = true
		$"../../StairArea".add_to_group("Interactable")
	else:
		$".".visible = false
		$"../../StairArea".monitoring = false
		$"../../StairArea".remove_from_group("Interactable")
