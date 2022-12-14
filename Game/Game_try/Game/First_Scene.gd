extends Node2D


var ally = preload("res://Game/Ally.tscn")
var enemy_1 = preload("res://Game/Enemy_1.tscn")
var enemy_2 = preload("res://Game/Enemy_2.tscn")
var enemy_3 = preload("res://Game/Enemy_33.tscn")
var enemy_4 = preload("res://Game/Enemy44.tscn")
var enemy_5 = preload("res://Game/Enemy55.tscn")
var heroe = preload("res://Game/Heroe.tscn")


var ally_1 = ally.instance()
var enemy_1_1 = enemy_1.instance()
var enemy_1_2 = enemy_2.instance()
var enemy_1_3 = enemy_3.instance()
var enemy_1_4 = enemy_4.instance()
var enemy_1_5 = enemy_5.instance()
var heroe_1 = heroe.instance()


var stop_Aglea_1M = false
var stop_Belotur_1M = false
var stop_Adalard_1M = false
var stop_Akira_1M = false
var stop_Jeison_1M = false
var stop_Aglea_1D = false
var stop_Akira_1D = false
var stop_Heroe_1M = false





func _ready():
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
	GLOBAL.heroe_uploaded = true
	
func _physics_process(delta):
	if !self.has_node("Heroe") && !stop_Aglea_1M:
		$Aglea.number_of_moving = 1
		$Aglea.moving_state = true
		stop_Aglea_1M = true
		
	if !self.has_node("Heroe") && !stop_Belotur_1M:
		$Belotur.number_of_moving = 1
		$Belotur.moving_state = true
		stop_Belotur_1M = true
		
	if !self.has_node("Heroe") && !stop_Adalard_1M:
		$Adalard.number_of_moving = 1
		$Adalard.moving_state = true
		stop_Adalard_1M = true
		
	if !self.has_node("Heroe") && !stop_Akira_1M:
		$Akira.number_of_moving = 1
		$Akira.moving_state = true
		stop_Akira_1M = true
		
	if !self.has_node("Heroe") && !stop_Jeison_1M:
		$Jeison.number_of_moving = 1
		$Jeison.moving_state = true
		stop_Jeison_1M = true
		
	if self.has_node("Heroe") && !stop_Heroe_1M:
		$Heroe.number_of_moving = 1
		$Heroe.moving_state = true
		stop_Heroe_1M = true
	
	if GLOBAL.aglea_dialoge_started && !stop_Aglea_1D:
		$Aglea.number_of_dialoge = 1
		$Aglea.array_dialoge_flags = [1,2,3,5,7,9,10,11,13,15]
		stop_Aglea_1D = true
		
	if GLOBAL.akira_dialoge_started && !stop_Akira_1D:
		$Akira.number_of_dialoge = 1
		$Akira.array_dialoge_flags = [4,6,8,12,14]
		stop_Akira_1D = true
	
	if !self.has_node("Akira") && !self.has_node("Aglea") && !self.has_node("Jeison") && !self.has_node("Adalard") && !self.has_node("Belotur"):
		GLOBAL.scene("Temple_lvl")
		self.queue_free()
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
