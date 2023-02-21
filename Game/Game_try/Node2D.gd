extends Node2D


var ally = preload("res://Game/Characters/Ally.tscn")
var enemy_1 = preload("res://Game/Characters/Enemy_1.tscn")
var enemy_33 = preload("res://Game/Characters/Enemy_33.tscn")
var enemy_44 = preload("res://Game/Characters/Enemy44.tscn")
var heroe = preload("res://Game/Characters/Heroe.tscn")


var in_area_for_artifical_intelligance_controlling
var mass_of_points = []

func Fight_Scene():
	pass

func landscape():
	pass


var ally_1 = ally.instance()
var enemy_1_1 = enemy_1.instance()
var enemy_1_33 = enemy_33.instance()
var enemy_1_44 = enemy_44.instance()
var heroe_1 = heroe.instance()


func _ready():
	enemy_1_1.position = $Position_Aglea.global_position
	self.add_child(enemy_1_1)
	ally_1.position = $Position_Ally.global_position
	self.add_child(ally_1)
	enemy_1_33.position = $Position_Belotur.global_position
	self.add_child(enemy_1_33)
	enemy_1_44.position = $Position_Akira.global_position
	self.add_child(enemy_1_44)
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)


