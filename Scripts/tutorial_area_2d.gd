extends Area2D

var player_node: CharacterBody2D = null

func _ready() -> void:
	for i in get_tree().get_nodes_in_group("player"):
		player_node = i

func _process(_delta: float) -> void:
	if !player_node: 
		for i in get_tree().get_nodes_in_group("player"):
			player_node = i
		return


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"): 
		if $"../DialogueArea2D".has_activated_already:
			$"../DialogueArea2D".monitoring = false
			$"..".collision_layer = 2
			$"..".visible = false
			$"../../Area2D2".remove_from_group("Interactable")
