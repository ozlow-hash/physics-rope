extends Node2D

@export var ball_scene = preload("res://obj_ball/ball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	var ball_spawn = ball_scene.instantiate()
	ball_spawn.global_position = global_position
	
	get_parent().add_child(ball_spawn)
	ball_spawn.add_to_group("ball")
	print("spawned", ball_spawn.get_groups())
