extends Node2D


var heroe = preload("res://Game/Characters/Heroe.tscn")
var ghost = preload("res://Game/Characters/Ghost.tscn")
var imaginary_heroe = preload("res://Game/Characters/Imaginary_Heroe.tscn")
var door = preload("res://Game/Tile_setsTools_for_level/Tools_for_level/Doors/Door.tscn")

var heroe_1 = heroe.instance()
var ghost_1 = ghost.instance()
var imaginary_heroe_1 = imaginary_heroe.instance()
var door_1 = door.instance()


var stop_Heroe_1D = false
var stop_Imaginary_Heroe_1D = false



func Temple_lvl():
	pass



func _ready():
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)
	if GLOBAL.first_starting_temple_lvl:
		ghost_1.position = $Position_Ghost.global_position
		self.add_child(ghost_1)
		GLOBAL.first_starting_temple_lvl = false
	imaginary_heroe_1.position = $Position_Imaginary_Heroe.global_position
	self.add_child(imaginary_heroe_1)
	door_1.position = $Position_Door.global_position
	self.add_child(door_1)

func _physics_process(delta):
	if GLOBAL.heroe_dialoge_started && !stop_Heroe_1D:
		$Heroe.number_of_dialoge = 1
		$Heroe.array_dialoge_flags = [1,2,3,5,7,9,10,11,13,15]
		stop_Heroe_1D = true
		
	if GLOBAL.imaginary_heroe_dialoge_started && !stop_Imaginary_Heroe_1D:
		$Imaginary_Heroe.number_of_dialoge = 1
		$Imaginary_Heroe.array_dialoge_flags = [4,6,8,12,14]
		stop_Imaginary_Heroe_1D = true
