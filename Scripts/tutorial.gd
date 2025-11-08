extends TileMapLayer

func _physics_process(delta):
	if $"../../NpcRombo/DialogueArea2D".has_activated_already:
		$".".visible = true
		$"../../Area2D3".monitoring = true
	else:
		$".".visible = false
		$"../../Area2D3".monitoring = false
