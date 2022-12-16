extends CanvasLayer

onready var heroe = get_parent()

signal use_move_vector
var ongoing_drag = -1


func _input(event):
	if !get_parent().get_parent().has_node("Ghost"):
		if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
			if $TouchScreenButton.is_pressed() or event.get_index() == ongoing_drag:
				var move_vector = calculate_move_vector(event.position)
				emit_signal("use_move_vector", move_vector)
				ongoing_drag = event.get_index()
				GLOBAL.move_vector_1 = move_vector
				
		if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
			ongoing_drag = -1
			GLOBAL.move_vector_1 = Vector2(0, 0)
			
	
func calculate_move_vector(event_position):
	var texture_center = $TouchScreenButton.position + Vector2(64, 64)
	return (event_position - texture_center).normalized()
	
	
func _physics_process(delta):
	if GLOBAL.continue_jump && GLOBAL.stop != true:
			heroe.start_jump_heroe()


func return_move_vector(move_vector):
	return(move_vector)


func _on_Area2D_mouse_entered():
	if $TouchScreenButton.is_pressed():
		GLOBAL.continue_jump = true
		GLOBAL.stop = false
		
		
func _on_Area2D_mouse_exited():
	GLOBAL.stop = true


func _on_TouchScreenButton_released():
	GLOBAL.stop = true

