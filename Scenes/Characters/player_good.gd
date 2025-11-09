
extends CharacterBody2D


@export var npc_sprite_frames: SpriteFrames
@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:

	if npc_sprite_frames:
		animated_sprite.sprite_frames = npc_sprite_frames
	animated_sprite.play("default")
