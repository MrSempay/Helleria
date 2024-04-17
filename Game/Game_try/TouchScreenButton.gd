extends TouchScreenButton

onready var heroe = get_node("../../Heroe")
onready var continue_jump = get_node("../../StaticBody2D2/CollisionShape2D")
onready var stop_jump = get_node("../../Area2D/CollisionShape2D")

var radius = Vector2(97, 108)
var boundary = 200
var ongoing_drag = -1
var return_accel = 20
var threshold = 10


func jump_joystick():
	pass


func _process(delta):
	if ongoing_drag == -1:
		var pos_difference = (Vector2(0, 0) - radius) - position
		position += pos_difference * return_accel * delta
	if get_button_pos().length() >= (boundary * 0.95) && GLOBAL.continue_jump && GLOBAL.stop != true:
		heroe.start_jump()
		

func get_button_pos():
	return position + radius
	

func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_centre = (event.position - get_parent().global_position).length()
	
		if event_dist_from_centre <= boundary * global_scale.x or event.get_index() == ongoing_drag:
			set_global_position(event.position - radius * global_scale)

			if get_button_pos().length() > boundary:
				set_position( get_button_pos().normalized() * boundary - radius)
				
				
			ongoing_drag = event.get_index()
			
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1
		

func get_value():
	if get_button_pos().length() > threshold:
		return get_button_pos().normalized()
	return Vector2(0, 0)


func _on_Jump2_body_entered(body: Node) -> void:
	if body.has_method("jump_joystick"):
		GLOBAL.continue_jump = true
		GLOBAL.stop = false
		

func _on_Jump2_body_exited(body):
	GLOBAL.stop = true
	
	
	
	
	
	
	
	
	"""
	
		var event_dist_from_centreX = (event.position.x - get_parent().position.x - 187)
		var event_dist_from_centreY = (event.position.y - get_parent().position.y - 1038)
		var event_dist_from_centre = Vector2(event_dist_from_centreX, event_dist_from_centreY).length()
		##(get_parent().position.x - 187)
		#(event_dist_from_centre)
		##(get_parent().position.y - 1038)
		##(event.position.y - get_parent().position.x - 1074)
		
	"""
