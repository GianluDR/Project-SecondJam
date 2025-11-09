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
	await get_tree().create_timer(10).timeout

	# 4. Dissolvenza del testo e torna al menu
	await fade.hide_text(1.0)
	await fade.fade_in(1.0)

	var root = get_tree().current_scene
	for child in root.get_children():
		child.queue_free()
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")

func scelta_verita():
	var fade = get_node("Fade_White")

	await fade.fade_in(1.5)

	var spawned_npcs = [] 
	var npc_scene = load("res://Scenes/Characters/Player_Good.tscn")
	var skin_types_list = ["default", "pentagono", "quadrato", "rombo", "triangolo"]

	for i in range(5):
		var npc_good = npc_scene.instantiate()
		npc_good.scale = Vector2(4, 4)

		# Aggiungi PRIMA alla scena, POI cambia animazione
		npc_good.position = Vector2(300 + i * 300, 400) 
		fade.add_child(npc_good)
		
		# Ora che è nella scena, cambia l'animazione
		var animated_sprite = npc_good.get_node("AnimatedSprite2D")
		animated_sprite.autoplay = ""
		animated_sprite.animation = skin_types_list[i]
		animated_sprite.play()
		
		npc_good.z_index = 1
		spawned_npcs.append(npc_good)
		
		# FADE IN con attesa tra uno e l'altro
		npc_good.modulate.a = 0
		var tween = create_tween()
		tween.tween_property(npc_good, "modulate:a", 1.0, 1)
		
		# Aspetta che il fade in finisca prima del prossimo NPC
		await tween.finished

	await get_tree().create_timer(2.0).timeout

	var dissolve_tween = get_tree().create_tween()
	for npc in spawned_npcs:
		dissolve_tween.tween_property(npc, "modulate:a", 0.0, 1)
	await dissolve_tween.finished

	for npc in spawned_npcs:
		npc.queue_free()

	await fade.show_text("Siamo tutti uguali.")
	await get_tree().create_timer(10).timeout
	await fade.hide_text(1.0)

	var root = get_tree().current_scene

	for child in root.get_children():
		child.queue_free()
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")


# --- QUESTA È LA FUNZIONE MODIFICATA ---
func scelta_trasformazione():
	# Prendiamo il riferimento al nodo "Fade" (quello nero)
	var fade = get_node("Fade")

	# Blocchiamo il movimento del giocatore
	player.set_physics_process(false)

	# Movimento del giocatore verso l'NPC
	var target_position = square_npc.global_position + Vector2(0, 40)
	var move_duration = 1.5
	var tween = get_tree().create_tween()
	tween.tween_property(player, "global_position", target_position, move_duration)
	await tween.finished
	
	# Sequenza dell'omicidio, ora usa il nodo "fade"
	await fade.fade_in(1.5)
	
	# --- suoni ---
	AudioManager.slash_sfx.play()
	await get_tree().create_timer(0.6).timeout
	AudioManager.bodyfall_sfx.play()
	await get_tree().create_timer(3).timeout
	AudioManager.paperbag_sfx.play()
	await get_tree().create_timer(4).timeout

	# --- carica e aggiunge l'npc ---
	var npc_scene = load("res://Scenes/Characters/Player_Evil.tscn")
	var npc_evil = npc_scene.instantiate()
	fade.add_child(npc_evil)
	npc_evil.global_position = get_viewport().get_visible_rect().size / 2
	npc_evil.z_index = 1

	npc_evil.scale = Vector2(4, 4)
	# fade-in
	npc_evil.modulate.a = 0.0
	var tween2 = create_tween()
	tween2.tween_property(npc_evil, "modulate:a", 3.0, 0.5)
	await tween2.finished

	# attesa prima della scomparsa
	await get_tree().create_timer(3.0).timeout

	# fade-out e rimozione
	var tween3 = create_tween()
	tween3.tween_property(npc_evil, "modulate:a", 0.0, 0.8)
	await tween3.finished

	npc_evil.queue_free()

	# mostra la scritta
	await fade.show_text("Non avresti dovuto vedere.", 1.5)
	await get_tree().create_timer(10).timeout

	var root = get_tree().current_scene
	for child in root.get_children():
		child.queue_free()
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
