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

var cameras = {
	"Heroe/CanvasLayer": true,
	"Camera_For_Speaking": false
}

var died_enemies_at_first_level = {
	"Jeison": false,
	"Adalard": false,
	"Belotur": false
}

var position_for_died_enemies_at_Gasria_fight = {
	"Jeison": Vector2(906, 75),
	"Belotur": Vector2(914, 213),
	"Adalard": Vector2(906, 355)
}


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


var first_cat_scene = false
var first_starting_temple_lvl = true

var heroe_pos_changed = false
var enemy_for_fight = ""

var heroe_is_observe = false
var ibo = true


var name_of_dialoge_for_dialoge_field_scene = ""
func scene(name, dialoge_between_scenes = false):
	get_tree().get_current_scene().queue_free()
	if !dialoge_between_scenes:
		get_tree().change_scene("res://Game/LocationsLevels/"+name+".tscn")
		return
	else:
		name_of_dialoge_for_dialoge_field_scene = get_tree().get_current_scene().get_name() + "-" + name
		get_tree().change_scene("res://Game/Dialoge_Field.tscn")
		
	

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
	var t
	var s
	var A = Vector2.ZERO
	var B = Vector2.ZERO
	var C = Vector2.ZERO
	var D = Vector2.ZERO
	var is_intersection = false
	for i in range(mass_segment1.size()):
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
				t = ((C.x - A.x) * (D.y - C.y) - (C.y - A.y) * (D.x - C.x)) / ((B.x - A.x) * (D.y - C.y) - (B.y - A.y) * (D.x - C.x))
				s = (A.x + t * (B.x - A.x) - C.x)/(D.x + 0.0001 - C.x)
				if s >= 0 && s <= 1 && t >= 0 && t <= 1:
					return true
	return false

func making_animation_for_sprite_from_folder(path, sprite, anim_name, animation_loop = false, sprite_position = Vector2(0, 0), fps = 5, start_animation_after_completing = true):
	var dir_animation = Directory.new()
	if dir_animation.open(path) == OK:
		dir_animation.list_dir_begin(true)
		var animation_frame = dir_animation.get_next()
		sprite.set_sprite_frames(SpriteFrames.new())
		sprite.get_sprite_frames().add_animation(anim_name)
		sprite.get_sprite_frames().set_animation_loop(anim_name, animation_loop)
		sprite.set_position(sprite_position)
		sprite.get_sprite_frames().set_animation_speed(anim_name, fps)
		sprite.scale = Vector2(2, 2)
		while animation_frame != "":
			sprite.get_sprite_frames().add_frame(anim_name, load(path + "/" + animation_frame))
			animation_frame = dir_animation.get_next()
	if start_animation_after_completing:
		sprite.play(anim_name)
	return sprite


