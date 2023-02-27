extends Node2D

var current_position_heroe = ""
var current_mega_position_heroe = ""
var current_position_enemy = ""


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

	if !self.has_node("Heroe"):
		$Sprite.set_visible(true)
	
	if current_position_heroe == "Area2DT" or current_position_heroe == "Area2DT2":
		get_node("Areas_For_Jumping/Jumping_Area12/CollisionShape2D").set_disabled(true)
		get_node("Areas_For_Jumping/Jumping_Area6/CollisionShape2D").set_disabled(true)
		get_node("Areas_For_Jumping/Jumping_Area7/CollisionShape2D").set_disabled(true)
	else:
		get_node("Areas_For_Jumping/Jumping_Area12/CollisionShape2D").set_disabled(false)
		get_node("Areas_For_Jumping/Jumping_Area6/CollisionShape2D").set_disabled(false)
		get_node("Areas_For_Jumping/Jumping_Area7/CollisionShape2D").set_disabled(false)
	if current_position_heroe == "Area2DT1" or current_position_heroe == "Area2DT4" or current_position_heroe == "Area2DT5":
		get_node("Areas_For_Jumping/Jumping_Area8/CollisionShape2D").set_disabled(true)
		get_node("Areas_For_Jumping/Jumping_Area9/CollisionShape2D").set_disabled(true)
	else:
		get_node("Areas_For_Jumping/Jumping_Area8/CollisionShape2D").set_disabled(false)
		get_node("Areas_For_Jumping/Jumping_Area9/CollisionShape2D").set_disabled(false)
	if current_position_heroe == "Area2DT5":
		get_node("Areas_For_Jumping/Jumping_Area14/CollisionShape2D").set_disabled(true)
	else:
		get_node("Areas_For_Jumping/Jumping_Area14/CollisionShape2D").set_disabled(false)
	if current_position_heroe == "Area2DT1":
		get_node("Areas_For_Jumping/Jumping_Area3/CollisionShape2D").set_disabled(true)
	else:
		get_node("Areas_For_Jumping/Jumping_Area3/CollisionShape2D").set_disabled(false)
	
	if self.has_node("Belotur") && in_area_for_artifical_intelligance_controlling:
		if self.get_node("Belotur/RayCastHorizontal_For_Heroe").get_collider():
			#print(current_position_enemy + "Bel")
			#print(current_position_heroe + "Her")
			if !self.get_node("Belotur/RayCastHorizontal_For_Heroe").get_collider().has_method("start_jump_heroe") && current_position_enemy != current_position_heroe:
				#print(mass_of_points)
				#print(current_position_heroe)
				match current_position_enemy:
					"Area2DT":
						if current_position_heroe == "Area2DT7":
							mass_of_points = [400]
						else:
							mass_of_points = [240, 290]
					"Area2DT1":
						if current_position_heroe == "Area2DT5":
							mass_of_points =[573]
						#if current_position_heroe == "Area2DT1":
						#	mass_of_points =[get_node("Heroe").global_position.x]
						else:
							mass_of_points = [630, 710]
					"Area2DT13":
						if current_mega_position_heroe == "Area2DT14":
							mass_of_points = [215]
						if current_mega_position_heroe == "Area2DT15":
							mass_of_points = [777]
						if current_mega_position_heroe == "Area2DT13":
							mass_of_points = []
					"Area2DT2":
						if current_position_heroe == "Area2DT":
							if get_node("Heroe").position.x > 290:
								mass_of_points = [350]
							else:
								mass_of_points = [240]
						if current_position_heroe == "Area2DT7":
							mass_of_points = [360]
						if current_position_heroe != "Area2DT7" && current_position_heroe != "Area2DT2" && current_position_heroe != "Area2DT":
							mass_of_points = [215]
					"Area2DT3":
						mass_of_points = []
					"Area2DT4":
						if current_position_heroe == "Area2DT1":
							mass_of_points = [630]
						if current_position_heroe == "Area2DT5":
							mass_of_points = [635]
						else:
							mass_of_points = [777]
					"Area2DT9":
						mass_of_points = [815]
					"Area2DT12":
						mass_of_points = [176]
					"Area2DT10":
						if current_position_heroe == "Area2DT11":
							mass_of_points = []
						else:
							mass_of_points = [777]
					"Area2DT6":
						mass_of_points = []
					"Area2DT8":
						mass_of_points = []


			else:
				mass_of_points = []
		else:
			match current_position_enemy:
					"Area2DT":
						if current_position_heroe == "Area2DT7":
							mass_of_points = [400]
						else:
							mass_of_points = [240, 290]
					"Area2DT1":
						if current_position_heroe == "Area2DT5":
							mass_of_points =[573]
						#if current_position_heroe == "Area2DT1":
						#	mass_of_points =[get_node("Heroe").global_position.x]
						else:
							mass_of_points = [630, 710]
					"Area2DT13":
						if current_mega_position_heroe == "Area2DT14":
							mass_of_points = [215]
						if current_mega_position_heroe == "Area2DT15":
							mass_of_points = [777]
						if current_mega_position_heroe == "Area2DT13":
							mass_of_points = []
					"Area2DT2":
						if current_position_heroe == "Area2DT":
							if get_node("Heroe").position.x > 290:
								print(true)
								mass_of_points = [350]
							else:
								print(false)
								mass_of_points = [240]
						if current_position_heroe == "Area2DT7":
							mass_of_points = [360]
						if current_position_heroe != "Area2DT7" && current_position_heroe != "Area2DT2" && current_position_heroe != "Area2DT":
							mass_of_points = [215]
					"Area2DT3":
						mass_of_points = []
					"Area2DT4":
						if current_position_heroe == "Area2DT1":
							mass_of_points = [630]
						if current_position_heroe == "Area2DT5":
							mass_of_points = [635]
						else:
							mass_of_points = [777]
					"Area2DT9":
						mass_of_points = [815]
					"Area2DT12":
						mass_of_points = [176]
					"Area2DT10":
						if current_position_heroe == "Area2DT11":
							mass_of_points = []
						else:
							mass_of_points = [777]
					"Area2DT6":
						mass_of_points = []
					"Area2DT8":
						mass_of_points = []



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
		pass
		#current_position_heroe = ""
	if body.has_method("enemy"):
		#mass_of_points = []
		pass
		#current_position_enemy = ""


func _on_Area2DT1_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT1"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT1"


func _on_Area2DT1_body_exited(body):
	if body.has_method("start_jump_heroe"):
		pass
		#current_position_heroe = ""
	if body.has_method("enemy"):
		pass
		#print(true)   
		#current_position_enemy = ""
		#mass_of_points = []


func _on_Area2DT2_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT2"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT2"


func _on_Area2DT4_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT4"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT4"


func _on_Area2DT4_body_exited(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = ""
	if body.has_method("enemy"):
		current_position_enemy = ""
		#mass_of_points = []


func _on_Area2DT5_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT5"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT5"


func _on_Area2DT5_body_exited(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = ""
	if body.has_method("enemy"):
		current_position_enemy = ""
		#mass_of_points = []


func _on_Area2DT6_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT6"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT6"


func _on_Area2DT7_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT7"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT7"


func _on_Area2DT9_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT9"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT9"


func _on_Area2DT10_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT10"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT10"





func _on_Area2DT11_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT11"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT11"


func _on_Area2DT2_body_exited(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = ""
	if body.has_method("enemy"):
		current_position_enemy = ""


func _on_Area2DT8_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT8"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT8"


func _on_Area2DT12_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT12"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT12"


func _on_Area2DT3_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_position_heroe = "Area2DT3"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT3"


func _on_Area2DT14_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_mega_position_heroe = "Area2DT14"


func _on_Area2DT13_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_mega_position_heroe = "Area2DT13"
	if body.has_method("enemy"):
		#mass_of_points = []
		in_area_for_artifical_intelligance_controlling = true
		current_position_enemy = "Area2DT13"


func _on_Area2DT15_body_entered(body):
	if body.has_method("start_jump_heroe"):
		current_mega_position_heroe = "Area2DT15"



func _on_Area2DT14_body_exited(body):
	if body.has_method("start_jump_heroe"):
		current_mega_position_heroe = ""


func _on_Area2DT15_body_exited(body):
	if body.has_method("start_jump_heroe"):
		current_mega_position_heroe = ""


func _on_Area_For_Falling_body_entered(body):
	if body.has_method("start_jump_heroe"):
		get_node("Heroe").queue_free()
	if body.has_method("enemy"):
		body.set_global_position(Vector2(946, -28))