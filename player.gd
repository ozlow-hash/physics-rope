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
		if event.is_action_pressed("Draw"): #grab the first point of the line
			dragging = true
			draw_start = get_global_mouse_position()
			draw_held = get_global_mouse_position()
			queue_redraw()
		elif event.is_action_released("Draw"): #get the second point of the line
			dragging = false
			draw_end = get_global_mouse_position()
			lines.append({"start": draw_start, "end": draw_end})
			
			
			queue_redraw()
	elif event is InputEventMouseMotion and dragging: #draw the preview of the line
		draw_held = get_global_mouse_position()
		queue_redraw()
	if event is InputEventKey:
		if Input.is_key_pressed(KEY_SPACE):
			print("test")
			create_line_collision()

func create_line_collision():
	var static_body = StaticBody2D.new()
	var shape = RectangleShape2D.new()
	var length = draw_start.distance_to(draw_end)
	var height = 40
	var angle = (draw_end - draw_start).angle()
	
	static_body.rotation = angle
	static_body.position = (draw_start + draw_end) / 2
	add_child(static_body)
	
	var collision_shape = CollisionShape2D.new()
	static_body.add_child(collision_shape)
	
	collision_shape.shape = shape

func _draw() -> void:
	for line in lines:
		draw_line(line["start"], line["end"], Color.ALICE_BLUE, 4, true)
	if dragging:
		draw_line(draw_start, draw_held, Color.RED, 2, true)

func _create_static_body():
	##create staticbody2d Node
	#var static_body = StaticBody2D.new()
	#static_body.global_position = Vector2(0,0)
	#
	#var col_shape = CollisionShape2D.new()
	#var shape = RectangleShape2D.new()
	#shape.size = Vector2(100,20)
	#
	##connect it all together
	#col_shape.shape = shape
	#static_body.add_child(col_shape)
	#
	#add_child(static_body)
	#
	var static_body = StaticBody2D.new()
	var collision_shape = CollisionShape2D.new()
	var segment = SegmentShape2D.new()
	
	segment.a = draw_start
	segment.b = draw_end
	
	collision_shape.shape = segment
	
	static_body.add_child(collision_shape)
	
	get_parent().add_child(static_body)
	
