extends Node2D

func scelta_sbura():
	var fade = get_node("Fade")

	# 1. Dissolvenza a nero
	await fade.fade_in(1.5)

	# 2. Mostra il testo finale
	await fade.show_text("Tutto svanisce nel buio...")

	# 3. Attendi un paio di secondi
	await get_tree().create_timer(2.0).timeout

	# 4. Dissolvenza del testo e torna al menu
	await fade.hide_text(1.0)

	# (facoltativo) fade totale prima del cambio scena
	await fade.fade_in(1.0)

	print("prima di free")
	$NpcSquare.queue_free()
	print("dopo freew")
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")


func scelta_cacca():
	print("Hai scelto cacca!")
	# Qui metti la logica che vuoi eseguire

func scelta_pipi():
	print("Hai scelto pipi!")
	# Qui metti la logica che vuoi eseguire
