extends Node2D

var current_position_heroe
var current_position_enemy

var in_area_for_artifical_intelligance_controlling
var point_1
var point_2
var point_3
var mass_of_points = []

var enemy_33 = preload("res://Game/Characters/Enemy_33.tscn")

var heroe = preload("res://Game/Characters/Heroe.tscn")


func Fight_Scene():
	pass


func _physics_process(delta):
	
	if !self.has_node("Belotur"):
		GLOBAL.scene("First_Scene")
	
	if current_position_heroe == "Area2DT":
		get_node("Areas_For_Jumping/Jumping_Area12/CollisionShape2D").set_disabled(true)
	else:
		get_node("Areas_For_Jumping/Jumping_Area12/CollisionShape2D").set_disabled(false)
	
	if self.has_node("Belotur") && in_area_for_artifical_intelligance_controlling:
		if self.get_node("Belotur/RayCastHorizontal_For_Heroe").get_collider():
			if !self.get_node("Belotur/RayCastHorizontal_For_Heroe").get_collider().has_method("start_jump_heroe"):
				match current_position_enemy:
					"Area2DT":
						mass_of_points = [240, 290]
					"Area2DT1":
						mass_of_points = [215]
					"Area2DT2":
						if current_position_heroe == "Area2DT":
							mass_of_points = [240]
						else:
							mass_of_points = [215]
					"Area2DT3":
						point_1
						point_2
						point_3
					"Area2DT4":
						point_1
						point_2
						point_3
			else:
				mass_of_points = []
		else:
			match current_position_enemy:
					"Area2DT":
						mass_of_points = [198, 231]
					"Area2DT1":
						mass_of_points = [170]
					"Area2DT2":
						if current_position_heroe == "Area2DT":
							mass_of_points = [198]
						else:
							mass_of_points = [170]
					"Area2DT3":
						point_1
						point_2
						point_3
					"Area2DT4":
						point_1
						point_2
						point_3


var enemy_1_33 = enemy_33.instance()

var heroe_1 = heroe.instance()


func _ready():
	enemy_1_33.position = $Position_Belotur.global_position
	self.add_child(enemy_1_33)
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)


func _on_Area2DT_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT"
	if body.has_method("enemy"):
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT"
		

func _on_Area2DT_body_exited(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = ""
	if body.has_method("enemy"):
		current_position_enemy = ""


func _on_Area2DT1_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT1"
	if body.has_method("enemy"):
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT1"


func _on_Area2DT1_body_exited(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = ""
	if body.has_method("enemy"):
		current_position_enemy = ""


func _on_Area2DT2_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT2"
	if body.has_method("enemy"):
		print(true)
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT2"
