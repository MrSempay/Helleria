extends Node


var Attack = 1
var counter_of_phrase = 1
var counter = 0

var variable_1 
var variable_2 

var life_first_enemy = true
var stop = false
var continue_jump = false
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

var life_heroe = true
var heroe_uploaded = false


func scene(name):
	get_tree().change_scene("res://Game/"+name+".tscn")
	

func first_spell_changing(speed, armor=0):
	speed = speed * 0.5
	return speed
	
	



