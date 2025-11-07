class_name Player
extends CharacterBody2D

var player_direction: Vector2
@export var light: PointLight2D

func _physics_process(delta):
	var nearest = _get_nearest_interactable()
	if nearest == null:
		# Nessuna area vicina → luce bassa
		light.energy = lerp(light.energy, 0.5, 0.1)
		return
	
	var dist = global_position.distance_to(nearest.global_position)
	print(dist)

	# Calcolo intensità (regola i valori come vuoi)
	var intensity = clamp(200.0 / dist, 0.5, 4.0)

	# Transizione morbida
	light.energy = lerp(light.energy, intensity, 0.1)
	light.texture_scale = lerp(light.texture_scale, intensity * 0.8, 0.1)
	

func _get_nearest_interactable() -> Node2D:
	var areas = get_tree().get_nodes_in_group("Interactable")
	
	if areas.size() == 0:
		return null

	var nearest = null
	var nearest_dist = INF

	for area in areas:
		var d = global_position.distance_to(area.global_position)
		if d < nearest_dist:
			nearest_dist = d
			nearest = area
	
	return nearest
