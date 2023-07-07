extends Node2D


var Sed_was_triggered = false
var current_target
var jeison = preload("res://Game/Characters/Enemy55.tscn")
var sed = preload("res://Game/Characters/Sed.tscn")
#var enemy_3 = preload("res://Game/Characters/Hir.tscn")

var heroe = preload("res://Game/Characters/Heroe.tscn")


func Fight_Scene():
	pass

func _ready():
	

	var heroe_1 = heroe.instance()
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)
	
	var jeison_1 = jeison.instance()
	jeison_1.position = $Position_Jeison.global_position
	self.add_child(jeison_1)
	var sed_1 = sed.instance()
	sed_1.position = $Position_Sed.global_position
	self.add_child(sed_1)
	
func _physics_process(delta):
	if has_node("Heroe"):
		current_target = $Heroe.global_position
