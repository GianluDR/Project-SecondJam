extends CharacterBody2D

@export var npc_texture: Texture2D
@export var highlight_texture: Texture2D

func _ready() -> void:
	if npc_texture:
		$Sprite2D.texture = npc_texture
	
	if highlight_texture:
		$Sprite2D_Highlight.texture = highlight_texture
	
