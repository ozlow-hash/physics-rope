extends RichTextLabel

@onready var startingscore = 0
@onready var score = startingscore

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$"../../../ball".score_value.connect()
	text = str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
