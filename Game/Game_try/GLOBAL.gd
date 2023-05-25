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


var first_cat_scene = false
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
	



