extends "res://Scripts/dialogue/dialogue_area.gd"


func _on_body_entered(body: Node2D) -> void:

	if only_activate_once and has_activated_already:
		return
	if body.is_in_group("player"):
		$ContinueText.visible = true
		player_body_in = true
		player_body_in = true
		var parent = get_parent()  # risali al CharacterBody2D
		parent.get_node("Sprite2D_Highlight").visible = true

		if activate_instant:
			if only_activate_once and !has_activated_already:
				_activate_dialogue()
			

func _on_body_exited(body: Node2D) -> void:
	player_body_in = false
	var parent = get_parent()
	parent.get_node("Sprite2D_Highlight").visible = false
	if body.is_in_group("player"):
		$ContinueText.visible = false
		player_body_in = false
