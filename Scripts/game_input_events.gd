class_name GameInputEvents

static var direction: Vector2

static func movement_input() -> Vector2:
	var dir: Vector2 = Vector2.ZERO

	if Input.is_action_pressed("walk_right"):
		dir.x += 1
	if Input.is_action_pressed("walk_left"):
		dir.x -= 1
	if Input.is_action_pressed("walk_down"):
		dir.y += 1
	if Input.is_action_pressed("walk_up"):
		dir.y -= 1

	if dir == Vector2.ZERO:
		direction = Vector2.ZERO
	else:
		# normalize so diagonal speed equals cardinal speed
		direction = dir.normalized()

	return direction

static func is_movement_input() -> bool:
	return movement_input() != Vector2.ZERO	