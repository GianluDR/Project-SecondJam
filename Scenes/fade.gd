extends CanvasLayer

@onready var rect = $ColorRect
@onready var label = $Label

# Dissolvenza verso nero
func fade_in(duration := 1.5):
	rect.visible = true
	rect.modulate.a = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(rect, "modulate:a", 1.0, duration)
	await tween.finished

# Dissolvenza da nero (schermo torna visibile)
func fade_out(duration := 1.5):
	var tween = get_tree().create_tween()
	tween.tween_property(rect, "modulate:a", 0.0, duration)
	await tween.finished
	rect.visible = false

# Mostra testo grande centrato
func show_text(text_to_show: String, fade_duration := 1.0):
	label.text = text_to_show
	label.visible = true
	label.modulate.a = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(label, "modulate:a", 1.0, fade_duration)
	await tween.finished

# Nasconde il testo (per la dissolvenza finale)
func hide_text(fade_duration := 1.0):
	var tween = get_tree().create_tween()
	tween.tween_property(label, "modulate:a", 0.0, fade_duration)
	await tween.finished
	label.visible = false
