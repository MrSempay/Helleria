extends Node2D


var enemy_33 = preload("res://Game/Characters/Enemy_33.tscn")

var heroe = preload("res://Game/Characters/Heroe.tscn")


func Fight_Scene():
	pass



var enemy_1_33 = enemy_33.instance()

var heroe_1 = heroe.instance()


func _ready():

	enemy_1_33.position = $Position_Belotur.global_position
	self.add_child(enemy_1_33)
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)
