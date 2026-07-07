extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		print("collission")
		await get_tree().create_timer(0.5).timeout
		if is_instance_valid(body):
			body.queue_free()
		Global.point_scored.emit(1)
