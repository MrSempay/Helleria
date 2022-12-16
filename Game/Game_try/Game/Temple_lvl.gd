extends Node2D


var heroe = preload("res://Game/Heroe.tscn")
var ghost = preload("res://Game/Ghost.tscn")

var heroe_1 = heroe.instance()
var ghost_1 = ghost.instance()


func Temple_lvl():
	pass



func _ready():
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)
	ghost_1.position = $Position_Ghost.global_position
	self.add_child(ghost_1)


