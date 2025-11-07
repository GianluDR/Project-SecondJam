extends Area2D

# --- Costanti e variabili di configurazione ---
@export var interactionType: int
@export var scene_index: int
@export var scene_paths = [
	"res://scenes/test_scene.tscn",
	"res://scenes/level2.tscn",
    "res://scenes/level3.tscn"
]

func _physics_process(delta):
	var player = $"../Player"#get_tree().get_nodes_in_group("Player")[0]
	var dist = global_position.distance_to(player.global_position)
	print(dist)


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "Player":   # oppure usa un gruppo "Player"
		print("Player ha raggiunto l'area!")
		if(interactionType == 0):
			print("interazione")
		else:
			print("nuovolivello")
			get_tree().change_scene_to_file(scene_paths[scene_index])
