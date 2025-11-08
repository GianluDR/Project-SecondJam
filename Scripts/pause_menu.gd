extends Control

func _ready():
	hide()
	
func resume():
	hide()
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	print("resume")

func pause():
	show()
	$AnimationPlayer.play("blur")
	get_tree().paused = true
	
	print("pause")

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			resume()
		else:
			pause()


func _on_resume_btn_pressed() -> void:
	AudioManager.on_click_btn.play()
	resume()


func _on_exit_btn_pressed() -> void:
	AudioManager.on_click_btn.play()
	get_tree().quit()
	
	


func _on_resume_btn_mouse_entered() -> void:
	AudioManager.on_hover_btn.play()


func _on_exit_btn_mouse_entered() -> void:
	AudioManager.on_hover_btn.play()
