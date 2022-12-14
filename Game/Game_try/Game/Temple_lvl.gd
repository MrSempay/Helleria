extends Node2D


var heroe = preload("res://Game/Heroe.tscn")

var heroe_1 = heroe.instance()


func Temple_lvl():
	pass



func _ready():
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)


