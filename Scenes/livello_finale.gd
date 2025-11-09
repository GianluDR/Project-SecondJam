extends Node2D

@onready var player = $Player 
@onready var square_npc = $NpcSquare
# @onready var cutscene_layer = $CutsceneLayer -> Non più necessario per queste funzioni

# QUESTA FUNZIONE È GIÀ CORRETTA E USA "Fade"
func scelta_stagno():
	var fade = get_node("Fade") # Usa il fade nero

	# 1. Dissolvenza a nero
	await fade.fade_in(1.5)

	# 2. Mostra il testo finale
	await fade.show_text("Tutto svanisce nel buio...")

	# 3. Attendi un paio di secondi
	await get_tree().create_timer(2.0).timeout

	# 4. Dissolvenza del testo e torna al menu
	await fade.hide_text(1.0)
	await fade.fade_in(1.0)

	$NpcSquare.queue_free()
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")

# QUESTA FUNZIONE È GIÀ CORRETTA E USA "Fade_White"
func scelta_verita():
	var fade = get_node("Fade_White") # Usa il fade bianco

	await fade.fade_in(1.5)

	var spawned_npcs = [] 
	var npc_scene = load("res://Scenes/Characters/npc_rombo.tscn")
	for i in range(6):
		var npc = npc_scene.instantiate()
		npc.position = Vector2(300 + i * 100, 400)
		fade.add_child(npc)
		npc.z_index = 1
		spawned_npcs.append(npc)

	await get_tree().create_timer(2.0).timeout

	var dissolve_tween = get_tree().create_tween()
	for npc in spawned_npcs:
		dissolve_tween.tween_property(npc, "modulate:a", 0.0, 1.5)
	await dissolve_tween.finished

	for npc in spawned_npcs:
		npc.queue_free()

	await fade.show_text("Siamo tutti uguali.")
	await get_tree().create_timer(2.5).timeout
	await fade.hide_text(1.0)
	await fade.fade_out(1.0)

	$NpcSquare.queue_free()
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")


# --- QUESTA È LA FUNZIONE MODIFICATA ---
func scelta_trasformazione():
	# Prendiamo il riferimento al nodo "Fade" (quello nero)
	var fade = get_node("Fade")

	# Blocchiamo il movimento del giocatore
	player.set_physics_process(false)

	# Movimento del giocatore verso l'NPC
	var target_position = square_npc.global_position + Vector2(-50, 0)
	var move_duration = 2.0
	var tween = get_tree().create_tween()
	tween.tween_property(player, "global_position", target_position, move_duration)
	await tween.finished
	
	# Sequenza dell'omicidio, ora usa il nodo "fade"
	await fade.fade_in(1.5)
	
	# Assumendo che "Fade" abbia i nodi audio come figli
	#fade.get_node("cut_sound").play() 
	await get_tree().create_timer(0.8).timeout
	
	#fade.get_node("fall_sound").play()
	await get_tree().create_timer(1.2).timeout
	
	#fade.get_node("bag_sound").play()
	await get_tree().create_timer(1.0).timeout
	
	await fade.show_text("Non avresti dovuto vedere.", 1.5)
	
	await get_tree().create_timer(4.0).timeout
	$NpcSquare.queue_free()
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
