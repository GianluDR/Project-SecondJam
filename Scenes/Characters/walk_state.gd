extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 50


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()

	if direction == Vector2.ZERO:
		# fallback animation if no direction (state machine should usually switch to idle)
		animated_sprite_2d.play("walk_front")
	else:
		# choose animation based on dominant axis so diagonals pick the most-representative sprite
		if abs(direction.x) > abs(direction.y):
			if direction.x < 0:
				animated_sprite_2d.play("walk_left")
			else:
				animated_sprite_2d.play("walk_right")
		else:
			if direction.y < 0:
				animated_sprite_2d.play("walk_back")
			else:
				animated_sprite_2d.play("walk_front")

	if direction != Vector2.ZERO:
		player.player_direction = direction

	# direction is normalized by GameInputEvents; multiply by speed for consistent movement
	player.velocity = direction * speed
	player.move_and_slide()


func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")
	pass


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
