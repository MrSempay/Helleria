extends Node2D


var heroe = preload("res://Game/Heroe.tscn")
var ghost = preload("res://Game/Ghost.tscn")

var heroe_1 = heroe.instance()
var ghost_1 = ghost.instance()


var stop_Heroe_1D = false
var stop_Imaginary_Heroe_1D = false



func Temple_lvl():
	pass



func _ready():
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)
	ghost_1.position = $Position_Ghost.global_position
	self.add_child(ghost_1)

func _physics_process(delta):
	if GLOBAL.heroe_dialoge_started && !stop_Heroe_1D:
		$Heroe.number_of_dialoge = 1
		$Heroe.array_dialoge_flags = [1,2,3,5,7,9,10,11,13,15]
		stop_Heroe_1D = true
		
	if GLOBAL.imaginary_heroe_dialoge_started && !stop_Imaginary_Heroe_1D:
		$Imaginary_Heroe.number_of_dialoge = 1
		$Imaginary_Heroe.array_dialoge_flags = [4,6,8,12,14]
		stop_Imaginary_Heroe_1D = true
