extends Node2D


var ally = preload("res://Game/Ally.tscn")
var enemy_1 = preload("res://Game/Enemy_1.tscn")
var enemy_33 = preload("res://Game/Enemy_33.tscn")
var heroe = preload("res://Game/Heroe.tscn")


var ally_1 = ally.instance()
var enemy_1_1 = enemy_1.instance()
var enemy_1_33 = enemy_33.instance()
var heroe_1 = heroe.instance()


func _ready():
	ally_1.position = $Position_Ally.global_position
	self.add_child(ally_1)
	enemy_1_33.position = $Position_Enemy.global_position
	self.add_child(enemy_1_33)
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)
