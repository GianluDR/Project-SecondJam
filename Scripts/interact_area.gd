extends Area2D

# --- Costanti e variabili di configurazione ---
@export var interactionType: int
@export var scene_index: int
@export var scene_paths = [
	"res://scenes/levelflowtesting/level0.tscn",
	"res://scenes/levelflowtesting/level1.tscn",
	"res://scenes/levelflowtesting/level2.tscn",
	"res://scenes/levelflowtesting/level3.tscn",
	"res://scenes/levelflowtesting/level4.tscn",
]

var player_body_in: bool = false

var player_node: CharacterBody2D = null

func _ready() -> void:
	add_to_group("Interactable")
	for i in get_tree().get_nodes_in_group("player"):
		player_node = i

func _process(_delta: float) -> void:
	if !player_node: 
		for i in get_tree().get_nodes_in_group("player"):
			player_node = i
		return
		
	if player_body_in:
		if Input.is_action_just_pressed("ui_accept"):
			player_body_in = false
			get_tree().change_scene_to_file(scene_paths[scene_index])

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):   
		print("Player ha raggiunto l'area!")
		if(interactionType == 0):
			print("interazione")
		else:
			print("nuovolivello")
			player_body_in = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):  
		print("Player uscito dall'area!")
		if(interactionType == 0):
			print("interazione")
		else:
			print("nuovolivello")
			player_body_in = false
