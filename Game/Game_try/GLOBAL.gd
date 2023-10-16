extends Node


var Attack = 1
var counter_of_phrase = 1
var counter = 0

var variable_1 
var variable_2 

var life_Belotur = true
var life_Aglea = true
var life_Akira = true
var life_Adalard = true
var life_Jeison = true
var stop = false
var stop_ghost = false
var continue_jump = false
var continue_jump_ghost = false
var spell_of_button
var counter_of_body_armor = 0
var time_out_of_body_seal = false


var stone = 2 


var counter_of_first_button = 0
var counter_of_second_button = 0
var counter_of_third_button = 0




var counter_of_bow = 0
var counter_of_stone = 0
var counter_of_hedgehod = 0


var arrow_amount = 7
var vector_of_moving = 1
var count_of_containment = 7
var move_vector_1 = Vector2(0, 0)
var move_vector_1_ghost = Vector2(0, 0)

var life_heroe = true
var heroe_uploaded = false
var position_heroe_before_fight = Vector2(0, 0)

var dialoge_heroe_camera = true
var dialoge_No_heroe_camera = false

var aglea_dialoge_started = false
var heroe_dialoge_started = false
var imaginary_heroe_dialoge_started = false
var akira_dialoge_started = false
var belotur_dialoge_started = false
var adalard_dialoge_started = false
var jeison_dialoge_started = false

var aglea_dialoge_finished = false
var heroe_dialoge_finished = false
var imaginary_heroe_dialoge_finished = false
var akira_dialoge_finished = false
var belotur_dialoge_finished = false
var adalard_dialoge_finished = false
var jeison_dialoge_finished = false


var first_cat_scene = true
var first_starting_temple_lvl = true

var heroe_pos_changed = false
var enemy_for_fight = ""

var heroe_is_observe = false
var ibo = true
func scene(name):
	get_tree().get_current_scene().queue_free()
	get_tree().change_scene("res://Game/LocationsLevels/"+name+".tscn")
	

func first_spell_changing(speed, armor=0):
	speed = speed * 0.5
	return speed
	
func get_segments_from_CollisionShape_or_collisionPolygon(area):
	var array_of_segments = []
	var shape = area.get_children()[0]
	var shape_classname = shape.get_class()
	var array_points = []
	match shape_classname:
		"CollisionPolygon2D":
			for i in range(shape.polygon.size()):
				if i == shape.polygon.size() - 1:
					array_of_segments.append([shape.polygon[i] + area.global_position, shape.polygon[0] + area.global_position])
					return array_of_segments
				array_of_segments.append([shape.polygon[i] + area.global_position, shape.polygon[i + 1] + area.global_position])
		"CollisionShape2D":
			array_points.append(Vector2(area.global_position.x - shape.shape.extents.x, area.global_position.y - shape.shape.extents.y))
			array_points.append(Vector2(area.global_position.x + shape.shape.extents.x, area.global_position.y - shape.shape.extents.y))
			array_points.append(Vector2(area.global_position.x + shape.shape.extents.x, area.global_position.y + shape.shape.extents.y))
			array_points.append(Vector2(area.global_position.x - shape.shape.extents.x, area.global_position.y + shape.shape.extents.y))
			for i in range(array_points.size()):
				if i == array_points.size() - 1:
					array_of_segments.append([array_points[i], array_points[0]])
					return array_of_segments
				array_of_segments.append([array_points[i], array_points[i + 1]])

		




func intersecting_vectors(mass_segment1, mass_segment2):
	#X_AB(t) = mass_points1[i][0].x + t * (mass_points1[i][1].x - mass_points1[i][0].x)
	#C.y + s * (D.y - C.y) = A.y + t * (B.y - A.y)
	#C.x + s * (D.x - C.x) = A.x + t * (B.x - A.x)          s * (D.x - C.x) - (s * coefficient_at_s + absolute_term_at_s) * (B.x - A.x) = A.x - C.x
	#(C.y + s * (D.y - C.y) - A.y)/(B.y - A.y) = t			s * (D.x - C.x) - s * coefficient_at_s * (B.x - A.x) = A.x - C.x - absolute_term_at_s * (B.x - A.x)
	#(A.x + t * (B.x - A.x) - C.x)/(D.x - C.x) = s			s = (A.x - C.x - absolute_term_at_s * (B.x - A.x))/((D.x - C.x) - coefficient_at_s * (B.x - A.x))
	var t
	var s	
	var A = Vector2.ZERO
	var B = Vector2.ZERO
	var C = Vector2.ZERO
	var D = Vector2.ZERO
	# правильные: var t = ((C.x - A.x) * (D.y - C.y) - (C.y - A.y) * (D.x - C.x)) / ((B.x - A.x) * (D.y - C.y) - (B.y - A.y) * (D.x - C.x))
	# правильные: var s = (A.x + t * (B.x - A.x) - C.x)/(D.x - C.x)
	var is_intersection = false
	for i in range(mass_segment1.size()):
		#print((B.x - A.x))
		#print((D.x - C.x))
		A.x = mass_segment1[i][0].x
		A.y = mass_segment1[i][0].y
		B.x = mass_segment1[i][1].x
		B.y = mass_segment1[i][1].y
		for j in range(mass_segment2.size()):
			C.x = mass_segment2[j][0].x
			C.y = mass_segment2[j][0].y
			D.x = mass_segment2[j][1].x
			D.y = mass_segment2[j][1].y
			if ((B.x - A.x) * (D.y - C.y) == (B.y - A.y) * (D.x - C.x)):
				pass
			else:
				#print(((B.x - A.x) * (D.y - C.y) - (B.y - A.y) * (D.x - C.x)))
				#print(((mass_segment1[i][1].x - mass_segment1[i][0].x) * (mass_segment2[i][1].x - mass_segment2[i][0].x) - (mass_segment1[j][1].y - mass_segment1[j][0].y) * (mass_segment2[j][1].y - mass_segment2[j][0].y)))
				t = ((C.x - A.x) * (D.y - C.y) - (C.y - A.y) * (D.x - C.x)) / ((B.x - A.x) * (D.y - C.y) - (B.y - A.y) * (D.x - C.x))
				s = (A.x + t * (B.x - A.x) - C.x)/(D.x + 0.0001 - C.x)
				if s >= 0 && s <= 1 && t >= 0 && t <= 1:
					return true	
	#var coefficient_at_s = (D.x - C.x)/(B.y - A.y)
	#var absolute_term_at_s = (C.y - A.y)/(B.y - A.y)
	#var ibo = (A.x - C.x - absolute_term_at_s * (B.x - A.x))/((D.x - C.x) - coefficient_at_s * (B.x - A.x))
	#C.x + s * (D.x - C.x) = A.x + (C.y + s * (D.y - C.y) - A.y)/(B.y - A.y) * (B.x - A.x)
	#var s = (A.x - C.x + (C.y - A.y)/(B.y - A.y) * (B.x - A.x)) / ((D.x - C.x) - (D.y - C.y)/(B.y - A.y) * (B.x - A.x))
	#var ibo = (C.x + s * (D.x - C.x) - A.x)/(B.x - A.x)
	#var t = ((C.y - A.y) * (D.x - C.x) + (A.x - C.x) * (D.y - C.y)) / ((B.x - A.x) * (D.y - C.y) - (B.y - A.y) * (D.x - C.x))
	#print(ibo)
	return false


