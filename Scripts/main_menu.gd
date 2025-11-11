extends Control

@onready var blocker: TextureRect = $blocker

@onready var logo: AnimatedSprite2D = $Logo

func _ready() -> void:
	AudioManager.final_music.stop()
	start_wait(3)
	AudioManager.fiammifero_sfx.play()
	AudioManager.menu_music.play()
	AudioManager.candela_sfxloop.play()
	$Fade.show()
	$Fade/fadeTimer.start()
	$Fade/AnimationPlayer.play("fadeIntro")
	await get_tree().create_timer(5).timeout
	$StartBtn.visible = true
	$ExitBtn.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_btn_pressed() -> void:
	AudioManager.on_click_btn.play()
	await get_tree().create_timer(0.4).timeout
	$StartBtn.visible = false
	$ExitBtn.visible = false
	AudioManager.soffio_sfx.play()
	$Logo.animation = "soffio"
	$Logo.play()
	$Fade.show()
	$Fade/fadeTimer.start()
	$Fade/AnimationPlayer.play("fadeOut")
	await get_tree().create_timer(4.0).timeout

	start_wait(5)
	AudioManager.menu_music.stop()
	AudioManager.candela_sfxloop.stop()

	get_tree().change_scene_to_file("res://Scenes/livello-0.tscn")
	

func start_wait(seconds: float):
	blocker.visible = true  # blocca input
	await get_tree().create_timer(seconds).timeout  # attesa tot secondi
	blocker.visible = false  # sblocca input
	
func _on_exit_btn_pressed() -> void:
	AudioManager.on_click_btn.play()
	await AudioManager.on_click_btn.finished
	get_tree().quit()
	

func _on_start_btn_mouse_entered() -> void:
	AudioManager.on_hover_btn.play()


func _on_exit_btn_mouse_entered() -> void:
	AudioManager.on_hover_btn.play()
	
func fade_alpha_except(container: Control, target_alpha: float, exclude: Control, duration: float):
	for child in container.get_children():
		if child is Control:
			if child != exclude:
				var target_color = child.modulate
				target_color.a = target_alpha
				var tween = create_tween()
				tween.tween_property(child, "modulate", target_color, duration)
			# Ricorsione per contenitori annidati
			fade_alpha_except(child, target_alpha, exclude, duration)
