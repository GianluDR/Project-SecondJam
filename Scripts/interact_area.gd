extends Area2D

# --- Costanti e variabili di configurazione ---
@export var interactionType: int
@export var testoPG: String
@export var scene_index: int
@export var scene_paths = [
	"res://scenes/levelflowtesting/level0.tscn",
	"res://scenes/levelflowtesting/level1.tscn",
	"res://scenes/levelflowtesting/level2.tscn",
	"res://scenes/levelflowtesting/level3.tscn",
	"res://scenes/levelflowtesting/level4.tscn",
	"res://scenes/levelflowtesting/level5.tscn",
]

var player_body_in: bool = false

var player_node: CharacterBody2D = null

func _ready() -> void:
	if interactionType != 1:
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
			if interactionType == 2:
				player_body_in = false
				get_tree().change_scene_to_file(scene_paths[scene_index])
			elif interactionType == 3:
				ConfirmMenu.pause()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):   
		print("Player ha raggiunto l'area!")
		if(interactionType == 0):
			print("interazione")
		elif(interactionType == 1):
			print("pg")
			$Label.visible = true
			$Label.text = testoPG
			#$PointLight2D.enabled = true
		else:
			print("nuovolivello")
			$ContinueText.visible = true
			player_body_in = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):  
		print("Player uscito dall'area!")
		if(interactionType == 0):
			print("interazione")
			$Label.visible = false
		elif(interactionType == 1):
			print("pg")
			$Label.visible = false
			#$PointLight2D.enabled = false
		else:
			print("nuovolivello")
			$ContinueText.visible = false
			player_body_in = false
