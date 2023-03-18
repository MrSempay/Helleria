extends Node2D

onready var area_of_dialoge_camera = get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")


var in_area_for_artifical_intelligance_controlling
var point_1
var point_2
var point_3
var mass_of_points = []
var current_target

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

var fight_scene_for_Belotur = "Max_level_Fight_Scene"



func First_Scene():
	pass


func _ready():
	$NavigationPolygonInstance2.set_enter_cost(2)
	if GLOBAL.first_cat_scene:
		$Position_Heroe.set_global_position(Vector2(2535, 1528))
	elif GLOBAL.position_heroe_before_fight != Vector2(0, 0):
		$Position_Heroe.set_global_position(GLOBAL.position_heroe_before_fight)
		GLOBAL.position_heroe_before_fight = 0
	else:
		#$Position_Heroe.set_global_position(Vector2(2218, 1528))
		pass
		
	if GLOBAL.first_cat_scene:
		$Position_Belotur.set_global_position(Vector2(3535, 1528))
	else:
		$Position_Belotur.set_global_position(Vector2(1600, 1340))
		
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
	if GLOBAL.life_Aglea == true:
		enemy_1_1.position = $Position_Aglea.global_position
		self.add_child(enemy_1_1)
	if GLOBAL.life_Adalard == true:
		enemy_1_2.position = $Position_Adalard.global_position
		self.add_child(enemy_1_2)
	if GLOBAL.life_Belotur == true:
		enemy_1_3.position = $Position_Belotur.global_position
		self.add_child(enemy_1_3)
	if GLOBAL.life_Akira == true:
		enemy_1_4.position = $Position_Akira.global_position
		self.add_child(enemy_1_4)
	if GLOBAL.life_Jeison == true:
		enemy_1_5.position = $Position_Jeison.global_position
		self.add_child(enemy_1_5)
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)
	door_1.position = $Position_Door.global_position
	self.add_child(door_1)
	GLOBAL.heroe_uploaded = true
	
func _physics_process(delta):
	
	if self.has_node("Heroe"):
		if $Heroe.in_invisibility && self.get_node("Bush").global_position.x - $Heroe.global_position.x < 66 && (self.get_node("Bush").global_position.x - $Heroe.global_position.x > -66):
			current_target = Vector2(2525, 1533)
		if $Heroe.in_invisibility && self.get_node("Bush2").global_position.x - $Heroe.global_position.x < 66 && (self.get_node("Bush2").global_position.x - $Heroe.global_position.x > -66):
			current_target = Vector2(2231, 1400)
		if $Heroe.in_invisibility && self.get_node("Bush3").global_position.x - $Heroe.global_position.x < 66 && (self.get_node("Bush3").global_position.x - $Heroe.global_position.x > -66):
			current_target = Vector2(1347, 1111)
		if !$Heroe.in_invisibility:
			current_target = $Heroe.global_position
	
	
	
	if self.has_node("Heroe"):
		if $Heroe.global_position.y > get_node("Areas_For_Jumping/JA10/CollisionShape2D").global_position.y:
			get_node("Areas_For_Jumping/JA10/CollisionShape2D").set_disabled(true)
		else:
			get_node("Areas_For_Jumping/JA10/CollisionShape2D").set_disabled(false)
		if $Heroe.global_position.y > get_node("Areas_For_Jumping/JA18/CollisionShape2D").global_position.y:
			get_node("Areas_For_Jumping/JA18/CollisionShape2D").set_disabled(true)
		else:
			get_node("Areas_For_Jumping/JA18/CollisionShape2D").set_disabled(false)
		if $Heroe.global_position.y > get_node("Areas_For_Jumping/JA19/CollisionShape2D").global_position.y:
			get_node("Areas_For_Jumping/JA19/CollisionShape2D").set_disabled(true)
		else:
			get_node("Areas_For_Jumping/JA19/CollisionShape2D").set_disabled(false)
		if $Heroe.global_position.y > get_node("Areas_For_Jumping/JA20/CollisionShape2D").global_position.y:
			get_node("Areas_For_Jumping/JA20/CollisionShape2D").set_disabled(true)
		else:
			get_node("Areas_For_Jumping/JA20/CollisionShape2D").set_disabled(false)
		
		
	#if !GLOBAL.first_cat_scene && GLOBAL.life_Belotur == true:
		#if (($Belotur.global_position.x) - $Heroe.global_position.x < 25) && (($Belotur.global_position.x) - $Heroe.global_position.x > -26) && (($Belotur.global_position.y) - $Heroe.global_position.y < 15) && (($Belotur.global_position.y) - $Heroe.global_position.y > -15):
			#GLOBAL.position_heroe_before_fight = $Heroe.global_position
			#GLOBAL.scene("Max_level_Fight_Scene")
	
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
	
	
	
	
		
	
	
	
	
	
	
	
	
	


func _on_Stop_Machine_body_entered(body):
	if body.has_method("enemy"):
		get_node("Stop_Machine/CollisionShape2D").set_disabled(true)
		#body.stop_machine = true
		body.get_node("Timer_Stop_Machine").start()


func _on_NoSpeed_Area_body_entered(body):
	if body.has_method("enemy"):
		if $Heroe.global_position.y < get_node("Areas_For_Specifical_Controlling/No-Speed_Area").global_position.y:
			if body.get_node("RayCastHorizontal_For_Heroe").get_collider():
				if !body.get_node("RayCastHorizontal_For_Heroe").get_collider().has_method("Heroe"):
					body.speed = 0
					body.stop_machine = true

			if !body.get_node("RayCastHorizontal_For_Heroe").get_collider():
				body.speed = 0
				body.stop_machine = true


func _on_Speed_Area_body_entered(body):
	if body.has_method("enemy"):
		body.speed = 2.5
		body.stop_machine = false
