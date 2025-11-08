extends Area2D

const DialogueSystemPreload = preload("res://Scenes/Dialogue/dialogue_system.tscn")

@export var activate_instant: bool
@export var only_activate_once: bool
@export var override_dialogue_position: bool
@export var ovverride_position: Vector2
@export var dialogue: Array[DE]

var dialogue_top_pos: Vector2 = Vector2(0, -65)
var dialogue_bottom_pos: Vector2 = Vector2(0, 65)

var player_body_in: bool = false
var has_activated_already: bool = false
var desired_dialogue_pos: Vector2

var player_node: CharacterBody2D = null

func _ready() -> void:
	for i in get_tree().get_nodes_in_group("player"):
		player_node = i

func _process(_delta: float) -> void:
	if !player_node: 
		for i in get_tree().get_nodes_in_group("player"):
			player_node = i
		return
	
	if !activate_instant and player_body_in:
		if only_activate_once and has_activated_already:
			set_process(false)
			return
		
		if Input.is_action_just_pressed("ui_accept"):
			_activate_dialogue()
			player_body_in = false

func _activate_dialogue() -> void:
	player_node.can_move = false
	has_activated_already = true
	
	var new_dialogue = DialogueSystemPreload.instantiate()
	if override_dialogue_position:
		desired_dialogue_pos = ovverride_position
	else:
		if player_node.global_position.y > get_viewport().get_camera_2d().get_screen_center_position().y:
			desired_dialogue_pos = dialogue_top_pos
		else:	
			desired_dialogue_pos = dialogue_bottom_pos
		new_dialogue.global_position = desired_dialogue_pos
		new_dialogue.dialogue = dialogue
		get_parent().add_child(new_dialogue)
		new_dialogue.global_position.x = get_viewport().get_camera_2d().get_screen_center_position().x

func _on_body_entered(body: Node2D) -> void:
	if only_activate_once and has_activated_already:
		return
	if body.is_in_group("player"):
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
		player_body_in = false
