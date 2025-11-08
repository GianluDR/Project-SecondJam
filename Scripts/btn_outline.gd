extends Button

# parametri outline
const OUTLINE_SIZE := 10
const OUTLINE_COLOR := Color("#D68C19FF") # bianco
#const OUTLINE_COLOR := Color("#FFFFFFFF") # bianco

func _ready():
	# connetti segnali (se non l'hai fatto dall'editor)
	connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_mouse_entered():
	# imposta colore e dimensione outline sul singolo nodo (override locale)
	add_theme_color_override("font_outline_color", OUTLINE_COLOR)
	add_theme_constant_override("outline_size", OUTLINE_SIZE)

func _on_mouse_exited():
	# rimuovi gli override (ritorna al tema originale)
	remove_theme_color_override("font_outline_color")
	remove_theme_constant_override("outline_size")
