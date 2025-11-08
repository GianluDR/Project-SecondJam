extends TileMapLayer

func _physics_process(delta):
	if $"../../NpcRombo/DialogueArea2D".has_activated_already:
		$".".visible = true
	else:
		$".".visible = false
