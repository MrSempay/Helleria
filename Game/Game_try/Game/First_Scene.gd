extends Node2D


var ally = preload("res://Game/Ally.tscn")
var enemy_1 = preload("res://Game/Enemy_1.tscn")
var enemy_2 = preload("res://Game/Enemy_2.tscn")
var enemy_3 = preload("res://Game/Enemy_33.tscn")
var heroe = preload("res://Game/Heroe.tscn")


var ally_1 = ally.instance()
var enemy_1_1 = enemy_1.instance()
var enemy_1_2 = enemy_2.instance()
var enemy_1_3 = enemy_3.instance()
var heroe_1 = heroe.instance()


func _ready():
	ally_1.position = $Ally.global_position
	self.add_child(ally_1)
	enemy_1_1.position = $Enemy_1.global_position
	self.add_child(enemy_1_1)
	enemy_1_2.position = $Enemy_2.global_position
	self.add_child(enemy_1_2)
	enemy_1_3.position = $Enemy_3.global_position
	self.add_child(enemy_1_3)
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)
	GLOBAL.heroe_uploaded = true
