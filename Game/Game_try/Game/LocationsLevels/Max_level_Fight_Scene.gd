extends Node2D

var current_position_heroe = ""
var current_mega_position_heroe = ""
var current_position_enemy = ""
var life_enemy = true

var in_area_for_artifical_intelligance_controlling
var point_1
var point_2
var point_3
var mass_of_points = []
var current_target
var Belotur_was_triggered = false

var enemy_1 = preload("res://Game/Characters/Enemy_1.tscn")
var enemy_2 = preload("res://Game/Characters/Enemy_2.tscn")
var enemy_3 = preload("res://Game/Characters/Enemy_33.tscn")
var enemy_4 = preload("res://Game/Characters/Enemy44.tscn")
var enemy_5 = preload("res://Game/Characters/Enemy55.tscn")

var heroe = preload("res://Game/Characters/Heroe.tscn")


func Fight_Scene():
	pass

func _ready():
	

	var heroe_1 = heroe.instance()
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)
	
	var enemy_1_3 = enemy_3.instance()
	enemy_1_3.position = $Position_Enemy.global_position
	self.add_child(enemy_1_3)
	
func _physics_process(delta):
	
	
	if has_node("Heroe"):
		get_node("Belotur").current_target = $Heroe.global_position
	
	if !life_enemy:
		GLOBAL.scene("First_Scene")

	if !self.has_node("Heroe"):
		$Sprite.set_visible(true)
		
	
	if current_position_heroe == "Area2DT" or current_position_heroe == "Area2DT2":
		pass
	
	
func _on_Area_For_Falling_body_entered(body):
	if body.has_method("start_jump_heroe"):
		get_node("Heroe").queue_free()
	if body.has_method("enemy"):
		body.set_global_position(Vector2(946, -28))


func _on_NoSpeed_Area_body_entered(body):
	if body.has_method("enemy"):
		if $Heroe.global_position.y < get_node("Areas_For_Specifical_Controlling/No-Speed_Area").global_position.y:
			if body.get_node("RayCastHorizontal_For_Heroe").get_collider():
				if !body.get_node("RayCastHorizontal_For_Heroe").get_collider().has_method("Heroe"):
					body.speed = 0
					body.stop_machine = true

			if !body.get_node("RayCastHorizontal_For_Heroe").get_collider():
				body.speed = 0
				body.stop_machine = true


func _on_Area2DT11_body_exited(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = ""


func _on_Speed_Area_body_entered(body):
	if body.has_method("enemy"):
		body.speed = 2.5
		body.stop_machine = false


func _on_NoSpeed_Area_area_entered(area):
	if area.get_parent().has_method("enemy"):
		area.get_parent().speed = 0
		area.get_parent().stop_machine = true
	
	
	
	


func _on_Speed_Area4_area_entered(area):
	pass # Replace with function body.


func _on_NoSpeed_Area2_area_entered(area):
	pass # Replace with function body.
