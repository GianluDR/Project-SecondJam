extends CanvasLayer

@onready var blur_rect := $BlurRect
@onready var overlay_rect := $OverlayRect
@onready var yes_btn := $YesBtn
@onready var no_btn := $NoBtn
@onready var label: Label = $Label

var pause_locked := false

func _ready():
	hide()

	process_mode = PROCESS_MODE_ALWAYS
	if blur_rect:
		blur_rect.process_mode = PROCESS_MODE_ALWAYS
	if overlay_rect:
		overlay_rect.process_mode = PROCESS_MODE_ALWAYS
		overlay_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	if yes_btn:
		yes_btn.process_mode = PROCESS_MODE_ALWAYS
	if no_btn:
		no_btn.process_mode = PROCESS_MODE_ALWAYS

	


func _unhandled_input(event): #QUI IL TRIGGER CON L'INPUT ("pause") CHE SAREBBE ESC
	if event.is_action_pressed("pause") and not pause_locked:
		pause_locked = true
		if get_tree().paused:
			resume()
		else:
			pause()
	if event.is_action_released("pause"):
		pause_locked = false


func pause():
	show()
	if label:
		label.visible = true
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

func _on_no_btn_pressed() -> void: #QUELLO CHE SUCCEDE QUANDO SCEGLI NOOOOOOOOOOO
	AudioManager.on_click_btn.play()
	resume()


func _on_no_btn_mouse_entered() -> void:
	AudioManager.on_hover_btn.play()


func _on_yes_btn_pressed() -> void: #QUELLO CHE SUCCEDE QUANDO SCEGLI SIIIIIII
	AudioManager.on_click_btn.play()


func _on_yes_btn_mouse_entered() -> void:
	AudioManager.on_hover_btn.play()
