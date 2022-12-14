extends Node2D

onready var area_of_dialoge_camera = get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")


var ally = preload("res://Game/Characters/Ally.tscn")
var enemy_1 = preload("res://Game/Characters/Enemy_1.tscn")
var enemy_2 = preload("res://Game/Characters/Enemy_2.tscn")
var enemy_3 = preload("res://Game/Characters/Enemy_33.tscn")
var enemy_4 = preload("res://Game/Characters/Enemy44.tscn")
var enemy_5 = preload("res://Game/Characters/Enemy55.tscn")
var heroe = preload("res://Game/Characters/Heroe.tscn")
var door = preload("res://Game/Tile_setsTools_for_level/Tools_for_level/Doors/Door.tscn")


var ally_1 = ally.instance()
var enemy_1_1 = enemy_1.instance()
var enemy_1_2 = enemy_2.instance()
var enemy_1_3 = enemy_3.instance()
var enemy_1_4 = enemy_4.instance()
var enemy_1_5 = enemy_5.instance()
var heroe_1 = heroe.instance()
var door_1 = door.instance()


var stop_Aglea_1M = false
var stop_Belotur_1M = false
var stop_Adalard_1M = false
var stop_Akira_1M = false
var stop_Jeison_1M = false
var stop_Aglea_1D = false
var stop_Akira_1D = false
var stop_Heroe_1M = false


func First_Scene():
	pass


func _ready():
	if GLOBAL.first_cat_scene:
		$Position_Heroe.set_global_position(Vector2(2535, 1528))
	else:
		$Position_Heroe.set_global_position(Vector2(2218, 1528))
		
	if GLOBAL.first_cat_scene:
		$Position_Belotur.set_global_position(Vector2(3535, 1528))
	else:
		$Position_Belotur.set_global_position(Vector2(1182, 1400))
		
	if GLOBAL.first_cat_scene:
		$Position_Adalard.set_global_position(Vector2(3535, 1528))
	else:
		$Position_Adalard.set_global_position(Vector2(2478, 1400))
		
	if GLOBAL.first_cat_scene:
		$Position_Jeison.set_global_position(Vector2(3535, 1528))
	else:
		$Position_Jeison.set_global_position(Vector2(2189, 1151))
	ally_1.position = $Ally.global_position
	self.add_child(ally_1)
	enemy_1_1.position = $Position_Aglea.global_position
	self.add_child(enemy_1_1)
	enemy_1_2.position = $Position_Adalard.global_position
	self.add_child(enemy_1_2)
	enemy_1_3.position = $Position_Belotur.global_position
	self.add_child(enemy_1_3)
	enemy_1_4.position = $Position_Akira.global_position
	self.add_child(enemy_1_4)
	enemy_1_5.position = $Position_Jeison.global_position
	self.add_child(enemy_1_5)
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)
	door_1.position = $Position_Door.global_position
	self.add_child(door_1)
	GLOBAL.heroe_uploaded = true
	
func _physics_process(delta):
	if !self.has_node("Heroe") && !stop_Aglea_1M && GLOBAL.first_cat_scene:
		$Aglea.number_of_moving = 1
		$Aglea.moving_state = true
		stop_Aglea_1M = true
		
	if !self.has_node("Heroe") && !stop_Belotur_1M && GLOBAL.first_cat_scene:
		$Belotur.number_of_moving = 1
		$Belotur.moving_state = true
		stop_Belotur_1M = true
		
	if !self.has_node("Heroe") && !stop_Adalard_1M && GLOBAL.first_cat_scene:
		$Adalard.number_of_moving = 1
		$Adalard.moving_state = true
		stop_Adalard_1M = true
		
	if !self.has_node("Heroe") && !stop_Akira_1M && GLOBAL.first_cat_scene:
		$Akira.number_of_moving = 1
		$Akira.moving_state = true
		stop_Akira_1M = true
		
	if !self.has_node("Heroe") && !stop_Jeison_1M && GLOBAL.first_cat_scene:
		$Jeison.number_of_moving = 1
		$Jeison.moving_state = true
		stop_Jeison_1M = true
		
	if self.has_node("Heroe") && !stop_Heroe_1M && GLOBAL.first_cat_scene:
		#$Heroe.number_of_moving = 1
		#$Heroe.moving_state = true
		#stop_Heroe_1M = true
		pass
	
	if GLOBAL.aglea_dialoge_started && !stop_Aglea_1D:
		$Aglea.number_of_dialoge = 1
		$Aglea.array_dialoge_flags = [1,2,3,5,7,9,10,11,13,15]
		stop_Aglea_1D = true

	if GLOBAL.akira_dialoge_started && !stop_Akira_1D:
		$Akira.number_of_dialoge = 1
		$Akira.array_dialoge_flags = [4,6,8,12,14]
		stop_Akira_1D = true
	
	if !self.has_node("Akira") && !self.has_node("Aglea") && !self.has_node("Jeison") && !self.has_node("Adalard") && !self.has_node("Belotur") && !self.has_node("Heroe"):
		match GLOBAL.first_cat_scene:
			true: GLOBAL.scene("Temple_lvl")
		GLOBAL.first_cat_scene = false
		area_of_dialoge_camera.was_pressed_1 = false
		area_of_dialoge_camera.was_pressed_2 = false
		area_of_dialoge_camera.was_pressed_3 = false
		area_of_dialoge_camera.was_pressed_4 = false
		area_of_dialoge_camera.input_touch = 0
		self.queue_free()
	
	
	
	
		
	
	
	
	
	
	
	
	
	
