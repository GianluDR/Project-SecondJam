extends Panel

@onready var stylebox: StyleBoxTexture = self.get_theme_stylebox("panel")
@onready var noise_tex: NoiseTexture2D = stylebox.texture
@onready var noise: FastNoiseLite = noise_tex.noise

var t := 0.0

func _process(delta):
	t += delta * 1
	if noise:
		# Modifica l'offset per animare il fumo
		noise.offset = Vector3(t * 10, t * 5, 0)
