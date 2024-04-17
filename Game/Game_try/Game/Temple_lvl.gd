extends "res://Locations.gd"



var ghost = preload("res://Game/Characters/Ghost.tscn")
var imaginary_heroe = preload("res://Game/Characters/Imaginary_Heroe.tscn")
var door = preload("res://Game/Tile_setsTools_for_level/Tools_for_level/Doors/Door.tscn")




var ghost_1 = ghost.instance()
var imaginary_heroe_1 = imaginary_heroe.instance()
var door_1 = door.instance()


var stop_Heroe_1D = false
var stop_Imaginary_Heroe_1D = false



func Temple_lvl():
	pass



func _ready():

	if GLOBAL.first_starting_temple_lvl:
		ghost_1.position = $Position_Ghost.global_position
		self.add_child(ghost_1)
		GLOBAL.first_starting_temple_lvl = false
	imaginary_heroe_1.position = $Position_Imaginary_Heroe.global_position
	self.add_child(imaginary_heroe_1)
	door_1.position = $Position_Door.global_position
	self.add_child(door_1)

func _physics_process(delta):
	pass

func dialoge_finished(dialoge_name):
	match dialoge_name:
		"Dialoge_Area_1":
			$Heroe/Camera_Of_Heroe._set_current(true)
			GLOBAL.cameras["Heroe/CanvasLayer"] = true
			GLOBAL.cameras["Camera_For_Speaking"] = false

