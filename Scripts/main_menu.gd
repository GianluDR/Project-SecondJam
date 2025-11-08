extends Control

@onready var tex_rect = $TextureRect
var new_tex = load("res://Assets/UI/Logo/Sprite-candela-spenta.png")

func _ready() -> void:
	AudioManager.menu_music.play()
	$Fade.show()
	$Fade/fadeTimer.start()
	$Fade/AnimationPlayer.play("fadeIn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_btn_pressed() -> void:
	AudioManager.on_click_btn.play()
	tex_rect.texture = new_tex
	await get_tree().create_timer(1.0).timeout
	$Fade.show()
	$Fade/fadeTimer.start()
	$Fade/AnimationPlayer.play("fadeOut")
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file("res://Scenes/light_test_scene.tscn")
	

func _on_exit_btn_pressed() -> void:
	AudioManager.on_click_btn.play()
	await AudioManager.on_click_btn.finished
	get_tree().quit()
	

func _on_start_btn_mouse_entered() -> void:
	AudioManager.on_hover_btn.play()


func _on_exit_btn_mouse_entered() -> void:
	AudioManager.on_hover_btn.play()
