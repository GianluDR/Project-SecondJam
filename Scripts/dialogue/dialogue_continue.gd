extends RichTextLabel

var underline_on := true

func _ready():
	bbcode_enabled = true

func _on_timer_timeout() -> void:
	underline_on = !underline_on

	if underline_on:
		$".".text = "[u]spazio[/u]"
	else:
		$".".text = "spazio"
