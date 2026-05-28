extends Node2D

#signal rope_placed()

var draw_start: Vector2
var draw_held: Vector2
var draw_end: Vector2
var dragging = false

#var line_length = 0
#var length = draw_start.distance_to(draw_end)

var drawn_lines = [] #stores completed liens

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("Draw"): #grab the first point of the line
			dragging = true
			draw_start = get_global_mouse_position()
			draw_held = get_global_mouse_position()
			queue_redraw()
		elif event.is_action_released("Draw"): #get the second point of the line
			dragging = false
			draw_end = get_global_mouse_position()
			drawn_lines.append({"start": draw_start, "end": draw_end})
			Global.line_length = draw_start.distance_to(draw_end)
			create_line_collision()
			#rope_placed.emit(Global.line_length)
			
			queue_redraw()
	elif event is InputEventMouseMotion and dragging: #draw the preview of the line
		draw_held = get_global_mouse_position()
		queue_redraw()


func create_line_collision():
	var static_body = StaticBody2D.new()
	
	#create shape and size of collision
	var shape = RectangleShape2D.new()
	var height = 10
	var col_shape = Vector2(Global.line_length,height)
	shape.size = col_shape
	
	#set angle of collision
	var angle = (draw_end - draw_start).angle()
	static_body.rotation = angle
	
	#set position of collision
	static_body.position = (draw_start + draw_end) / 2
	add_child(static_body)
	
	#create collision
	var collision_shape = CollisionShape2D.new()
	static_body.add_child(collision_shape)
	collision_shape.shape = shape

func _draw() -> void:
	for line in drawn_lines:
		draw_line(line["start"], line["end"], Color.ALICE_BLUE, 4, true)
	if dragging:
		draw_line(draw_start, draw_held, Color.RED, 2, true)
#
#func _on_rope_placed() -> void:
	#pass # Replace with function body.
