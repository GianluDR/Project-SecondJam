extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()

	if direction == Vector2.ZERO:
		animated_sprite_2d.play("idle_front")
		return

	# for diagonals pick the dominant axis to choose an appropriate animation
	if abs(direction.x) > abs(direction.y):
		if direction.x < 0:
			animated_sprite_2d.play("idle_left")
		else:
			animated_sprite_2d.play("idle_right")
	else:
		if direction.y < 0:
			animated_sprite_2d.play("idle_back")
		else:
			animated_sprite_2d.play("idle_front")

func _on_enter() -> void:
	pass


func _on_next_transitions() -> void:
	GameInputEvents.movement_input()

	if GameInputEvents.movement_input():
		transition.emit("Walk")

func _on_exit() -> void:
	animated_sprite_2d.stop()
