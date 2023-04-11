extends Node2D


var life_enemy = true

var current_target
var Adalard_was_triggered = false

var enemy_1 = preload("res://Game/Characters/Adalard.tscn")

var heroe = preload("res://Game/Characters/Heroe.tscn")


func Fight_Scene():
	pass

func _ready():
	
	
	var heroe_1 = heroe.instance()
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)
	
	var enemy_1_1 = enemy_1.instance()
	enemy_1_1.position = $Position_Enemy.global_position
	self.add_child(enemy_1_1)

func _physics_process(delta):
	
	
	if has_node("Heroe"):
		current_target = $Heroe.global_position
	
	if !life_enemy:
		GLOBAL.scene("First_Scene")

	if !self.has_node("Heroe"):
		$Sprite.set_visible(true)
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
