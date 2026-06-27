extends ProgressBar

@onready var rope_bar = self

func _ready():
	pass


func _on_player_update_remaining(line_rem) -> void:
	print(line_rem)
