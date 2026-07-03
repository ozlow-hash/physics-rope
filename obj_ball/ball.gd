extends RigidBody2D

signal update_score

var score_value = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_objective_point_body_entered(body: Node2D) -> void:
	#print("entered", body.name, "Groups:", body.get_groups())
	if body.is_in_group("ball"):
		_destroy_ball(body)
	else:
		print("not ball")
	
func _destroy_ball(body):
	print("ball")
	print(body)
	await get_tree().create_timer(0.5).timeout
	if is_instance_valid(body):
		body.queue_free()
		emit_signal("update_score", $".".score_value)
