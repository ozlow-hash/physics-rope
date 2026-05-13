extends Node2D

var draw_start: Vector2
var draw_held: Vector2
var draw_end: Vector2
var dragging = false

var lines = [] #stores compelted liens

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("Draw"):
			dragging = true
			draw_start = get_global_mouse_position()
			draw_held = get_global_mouse_position()
			queue_redraw()
		else:
			dragging = false
			draw_end = get_global_mouse_position()
			lines.append({"start": draw_start, "end": draw_end})
			
			#create collision
			create_line_collision(draw_start, draw_end)
			
			queue_redraw()
	elif InputEventMouseMotion and dragging:
		draw_held = get_global_mouse_position()
		queue_redraw()

func create_line_collision(start: Vector2, end: Vector2):
	var static_body = StaticBody2D.new()
	var collision_shape = CollisionShape2D.new()
	var segment = SegmentShape2D.new()
	
	segment.a = start
	segment.b = end
	
	static_body.add_child(collision_shape) #makes collision shape child of static body
	add_child(static_body)

func _draw() -> void:
	for line in lines:
		draw_line(line["start"], line["end"], Color.ALICE_BLUE, 4, true)
	if dragging:
		draw_line(draw_start, draw_held, Color.RED, 2, true)
