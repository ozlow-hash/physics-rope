extends Node2D

var draw_start: Vector2
var draw_held: Vector2
var draw_end: Vector2
var dragging = false

var line_length = 0 #current line length DO NOT DELETE
var line_preview = 0 #preview of line length

var drawn_lines = [] #stores completed liens

signal update_remaining

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	
	if event is InputEventMouseButton:	
		if event.is_action_pressed("Draw"): #grab the first point of the line
			if Global.length_health <= 0:
				return
			
			dragging = true
			draw_start = mouse_pos
			draw_held = mouse_pos
			
		elif event.is_action_released("Draw"): #get the second point of the line and draw it
			dragging = false
			
			draw_end = draw_held
			
			line_length = draw_start.distance_to(draw_end)
			
			Global.length_health -= line_length
			
			drawn_lines.append({
				"start": draw_start, 
				"end": draw_end
				})
			
			queue_redraw()
			create_line_collision()
			emit_signal("update_remaining", line_length) #send line spent to updae healthbar
			
	elif event is InputEventMouseMotion and dragging: #draw the preview of the line
		var line_direction = (mouse_pos - draw_start).normalized()
		var distance = draw_start.distance_to(mouse_pos)
		
		if distance > Global.length_health:
			draw_held = draw_start + line_direction * Global.length_health
		else:
			draw_held = mouse_pos
		
		line_preview = draw_start.distance_to(draw_held)
		queue_redraw()

func create_line_collision():
	var static_body = StaticBody2D.new()
	
	#create shape and size of collision
	var shape = RectangleShape2D.new()
	var height = 10
	var col_shape = Vector2(line_length,height)
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
