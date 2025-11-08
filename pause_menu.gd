extends CanvasLayer

@onready var blur_rect := $BlurRect
@onready var overlay_rect := $OverlayRect
@onready var resume_btn := $resumeBtn
@onready var quit_btn := $quitBtn

var pause_locked := false

func _ready():
	hide()

	process_mode = PROCESS_MODE_ALWAYS
	if blur_rect:
		blur_rect.process_mode = PROCESS_MODE_ALWAYS
	if overlay_rect:
		overlay_rect.process_mode = PROCESS_MODE_ALWAYS
		overlay_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if resume_btn:
		resume_btn.process_mode = PROCESS_MODE_ALWAYS
	if quit_btn:
		quit_btn.process_mode = PROCESS_MODE_ALWAYS

	# Collega bottoni
	if resume_btn:
		resume_btn.connect("pressed", Callable(self, "_on_resume_pressed"))
	if quit_btn:
		quit_btn.connect("pressed", Callable(self, "_on_quit_pressed"))


func _unhandled_input(event):
	if event.is_action_pressed("pause") and not pause_locked:
		pause_locked = true
		if get_tree().paused:
			resume()
		else:
			pause()
	if event.is_action_released("pause"):
		pause_locked = false


func pause():
	if get_tree().current_scene.name != "MainMenu":
		show()
		if blur_rect:
			blur_rect.visible = true
		if overlay_rect:
			overlay_rect.visible = true
		get_tree().paused = true


func resume():
	get_tree().paused = false
	if blur_rect:
		blur_rect.visible = false
	if overlay_rect:
		overlay_rect.visible = false
	hide()

func _on_resume_btn_pressed():
	AudioManager.on_click_btn.play()
	resume()

func _on_quit_btn_pressed():
	AudioManager.on_click_btn.play()
	get_tree().quit()

func _on_resume_btn_mouse_entered():
	AudioManager.on_hover_btn.play()

func _on_quit_btn_mouse_entered():
	AudioManager.on_hover_btn.play()
