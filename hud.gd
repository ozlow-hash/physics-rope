extends ProgressBar

@onready var rope_bar = self

func _ready():
	var player_max_length = get_parent().max_length
	value = player_max_length


func _on_player_length_change(player) -> void:
	pass # Replace with function body.
