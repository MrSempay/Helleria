extends Node2D

onready var area_of_dialoge_camera = get_parent().get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")

var dialoge_window = preload("res://Game/Dialoge_Window.tscn")

var name_character = "Imaginary_Heroe"
var array_dialoge_flags = []
var i = 0
var number_of_dialoge


var file = File.new()
var point_of_position_string
var point_of_position_string_x
var point_of_position_string_x_saved = -10000
var point_of_position_string_y
var point_of_position_string_y_saved
var moving_state
var number_of_moving


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if GLOBAL.imaginary_heroe_dialoge_started:
		dialoge(array_dialoge_flags, number_of_dialoge)
		
		
func dialoge(array_dialoge_flags, number_of_dialoge):
	if array_dialoge_flags.size() != 0:
		
		if $Sprite.is_flipped_h():
			$Dialoge_Window_Position.set_position(Vector2(-10,-42))
		else:
			$Dialoge_Window_Position.set_position(Vector2(10,-42))
			
		if array_dialoge_flags[i] == 1:
			var dialoge_window_1 = dialoge_window.instance()
			dialoge_window_1.position = $Dialoge_Window_Position.position
			add_child(dialoge_window_1)
			$Dialoge_Window.choosing_text(name_character, 1, number_of_dialoge)
			area_of_dialoge_camera.was_pressed_3 = false
			area_of_dialoge_camera.input_touch += 1
			if i != (array_dialoge_flags.size() - 1):
					i += 1
		
		if i != (array_dialoge_flags.size() - 1):
			if area_of_dialoge_camera.input_touch == array_dialoge_flags[i] && area_of_dialoge_camera.was_pressed_3:
				var dialoge_window_1 = dialoge_window.instance()
				dialoge_window_1.position = $Dialoge_Window_Position.position
				if array_dialoge_flags[i] - array_dialoge_flags[i - 1] == 1 && self.has_node("Dialoge_Window"):
					$Dialoge_Window.choosing_text(name_character, area_of_dialoge_camera.input_touch, number_of_dialoge)
					area_of_dialoge_camera.was_pressed_3 = false
				else:
					add_child(dialoge_window_1)
					dialoge_window_1.choosing_text(name_character, area_of_dialoge_camera.input_touch, number_of_dialoge)
					area_of_dialoge_camera.was_pressed_3 = false
				if i != (array_dialoge_flags.size() - 1):
					i += 1
					
		if (area_of_dialoge_camera.input_touch != array_dialoge_flags[i]) && area_of_dialoge_camera.was_pressed_3 && self.has_node("Dialoge_Window"):
			if i == (array_dialoge_flags.size() - 1):
				match number_of_dialoge:
					1: queue_free()
			$Dialoge_Window.queue_free()
