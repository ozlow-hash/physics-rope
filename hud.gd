extends ProgressBar

@onready var rope_bar = self

var length_pct = 0

func _ready():
	value = 100

func _on_player_update_remaining(line_length) -> void:
	Global.length_health = Global.length_health - line_length
	length_pct = clamp((float(Global.length_health) / Global.length_max) * 100, 0, 100)
	value = length_pct
	emit_signal("value_changed", Global.length_health)
