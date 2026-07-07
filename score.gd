extends RichTextLabel

@onready var currentcore: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.point_scored.connect(_on_points_scored)
	
	text = str(currentcore)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_points_scored(points: int):
	currentcore += points
	text = str(currentcore)
