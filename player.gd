extends Node2D

var draw_start: Vector2
var draw_held: Vector2
var draw_end: Vector2
var mouse_drag = false

var lines = [] #stores compelted liens

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		draw_start = event.position
		if event.is_action_pressed("Draw"):
			draw_held = event.position
			mouse_drag = true
		if event.is_action_released("Draw"):
			mouse_drag = false
			draw_end = event.position
			lines.append({"start": draw_start, "end": draw_end})
	
		
		#if event.is_action_just_pressed("Draw"):
			#draw_start = event.position
			#lines.append(draw_start)
		#if Input.is_action_pressed("Draw"):
			#draw_held = event.position
			#mouse_drag = true
			#queue_redraw()
		#if Input.is_action_just_released("Draw"):
			#draw_end = event.position
			#mouse_drag = false
			#lines.append(draw_end)
		
		print(lines)

func _draw() -> void:
	if mouse_drag == false:
		draw_line(draw_start, draw_end, Color.WHITE, 20.0)
	else:
		draw_line(draw_start, draw_held, Color.RED, 10)
