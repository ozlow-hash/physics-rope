extends RigidBody2D


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
	body.queue_free()
