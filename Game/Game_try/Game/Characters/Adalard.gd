extends KinematicBody2D


var speed = 2.5
var velocity = Vector2()
var name_character = "Adalard"
var trigger_of_ally = false
var sword_ready = true
var sword_finished = false
var sprite_position = Vector2(67,0)
var JUMP_POWER = 500
var stun = false
var EXTRA = false
var preparing_for_pushing_finished = false
var stop_pushing = false
var push_ready = true
var vector_push
var armor_ready = true
var armor = 1

onready var collision_of_push_area = get_node("Area_Pushing/CollisionShape2D")
onready var collision_of_sword = get_node("Sword/CollisionShape2D")
onready var area_of_dialoge_camera = get_parent().get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")

var stop_machine = false
var stop_distance_to_point = 1.5
var dialoge_window = preload("res://Game/Dialoge_Window.tscn")
var array_dialoge_flags = []
var i = 0
var c = 0
var j = 0
var saved_size_array = 0
var number_of_dialoge
var scale_gravity = 2
var manual_navigation = false
var nav_path = [Vector2()]



var file = File.new()
var point_of_position_string
var point_of_position_string_x
var point_of_position_string_x_saved = -10000
var point_of_position_string_y
var point_of_position_string_y_saved
var moving_state
var number_of_moving
var dat = 1



func _ready():
	
	if get_parent().has_method("Fight_Scene"):
		$AudioStreamPlayer2D.stream = load("res://metal-gear-rising-ost-the-only-thing-i-know-for-real_444559330.mp3")
		$AudioStreamPlayer2D.play()
	$HP_Enemy_1.max_value = SPELLS_PARAMETERS.HP_Adalard
	$HP_Enemy_1.value = SPELLS_PARAMETERS.HP_Adalard
	$value_of_HP.text = str($HP_Enemy_1.value)
	
	$Mana_Enemy_1.max_value = SPELLS_PARAMETERS.mana_Adalard
	$Mana_Enemy_1.value = SPELLS_PARAMETERS.mana_Adalard
	$value_of_Mana.text = str($Mana_Enemy_1.value)
	
	
func enemy():
	pass


func handle_hit(damage):
	$HP_Enemy_1.value -= damage * (1 - armor)
	$value_of_HP.text = str($HP_Enemy_1.value)
	if $HP_Enemy_1.value > 0:
		print(name_character + " was hit! Health of enemy: ", $HP_Enemy_1.value)
	else:
		print(name_character + " was destroyed")
		GLOBAL.life_Adalard = false
		get_parent().life_enemy = false
		queue_free()


func mana_using(manacost):
	$Mana_Enemy_1.value -= manacost
	$value_of_Mana.text = str($Mana_Enemy_1.value)


func _physics_process(delta):
	#print($Sprite.get_animation())
	#print($Sprite.get_frame())
	#print(armor)
	if stun:
		stop_pushing = true
		$Area_Pushing.set_monitoring(false)
	
	
	if $RayCastVertical_3.get_collider() && $Sprite.get_animation() == "jump":
		animate("idle")
		
	if $Sprite.get_animation() == "idle":
		speed = 2.5
	
	
	match $Sprite.get_animation():
		"idle":
			$Sprite.set_speed_scale(1)
		"run":
			$Sprite.set_speed_scale(1)
		"armor":
			$Sprite.set_speed_scale(SPELLS_PARAMETERS.scale_animation_speed_armor_Adalard)
		"sword":
			$Sprite.set_speed_scale(SPELLS_PARAMETERS.scale_animation_speed_sword_Adalard)
		"push":
			$Sprite.set_speed_scale(SPELLS_PARAMETERS.scale_animation_speed_push_Adalard)
		"jump":
			$Sprite.set_speed_scale(1)
			
			
			
	if !$RayCastVertical_3.get_collider():
		$Timer_For_Updaiting_Way.set_wait_time(0.1)
	else:
		$Timer_For_Updaiting_Way.set_wait_time(0.3)
		
	velocity.x = 0

	
	if moving_state:
		navigation(number_of_moving)
	
	if GLOBAL.adalard_dialoge_started && !GLOBAL.adalard_dialoge_finished:
		dialoge(array_dialoge_flags, number_of_dialoge)
	if GLOBAL.adalard_dialoge_finished && GLOBAL.first_cat_scene:
		if get_parent().has_method("First_Scene"):
				translate(Vector2(1,0) * 2)
				get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
				animate("run")
				$Sprite.flip_h = true
	
	velocity.y += delta * 970 * scale_gravity
	velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
	
	collision_of_sword.set_disabled(true)
	if get_parent().has_node("Heroe") && !stun:
		var heroe = get_parent().get_node("Heroe")
		var ally = get_parent().get_node("Ally")
		
		if trigger_of_ally or get_parent().has_method("Fight_Scene") or get_parent().get_node("Heroe").in_invisibility && get_parent().Adalard_was_triggered:       # This paragraph implemented for moving AI in "not-fight scenes". Here created algoritm for finding the shortest ways to heroe, alrotimes for jumping
		
			if get_parent().has_method("Fight_Scene"):
				
				if $Sprite.get_animation() != "push" && $Sprite.get_animation() != "sword" && $Sprite.get_animation() != "push_preparing" && armor_ready:
					#armor_ready = false
					#$Timer_Armor.set_wait_time(SPELLS_PARAMETERS.calldown_armor_Adalard)
					#$Timer_Armor.start()
					#armor = SPELLS_PARAMETERS.fraction_absorbed_damage_armor_Adalard					
					#animate("armor")
					pass
				if ((self.global_position.x) - heroe.global_position.x < 400) && (self.global_position.x - heroe.global_position.x > -400) && is_on_floor() && $Sprite.get_animation() != "sword" && push_ready: 
					push()
				
				if ((self.global_position.x) - heroe.global_position.x < 52) && (self.global_position.x - heroe.global_position.x > -52) && is_on_floor() && $Mana_Enemy_1.value >= SPELLS_PARAMETERS.manacost_sword_Adalard && $Sprite.get_animation() != "armor" && $Sprite.get_animation() != "push" && $Sprite.get_animation() != "push_preparing": 
					$Sprite.flip_h = ((self.global_position.x) - heroe.global_position.x) > 0
					if ((self.global_position.x) - heroe.global_position.x) > 0:
						$Sword.set_position(Vector2(-25,-6))
					else:
						$Sword.set_position(Vector2(25,-6))
					speed = 0
					sword_ready = false
					$Timer_Sword.start()
					animate("sword")
					if sword_finished:
						mana_using(SPELLS_PARAMETERS.manacost_sword_Adalard)
						collision_of_sword.set_disabled(false)
						sword_finished = false
							
				
			if $Sprite.get_animation() != "sword" && $Sprite.get_animation() != "armor" && $Sprite.get_animation() != "push" && $Sprite.get_animation() != "push_preparing":
				if j < nav_path.size() - 1:
					if $RayCastHorizontal_For_Heroe.get_collider() && !$RayCastVertical_2.get_collider():
						if ($RayCastHorizontal_1.get_collider() or $RayCastHorizontal_2.get_collider() or $RayCastHorizontal_4.get_collider()) && nav_path[j].y > nav_path[j+1].y:
							start_jump_enemy()
					elif ($RayCastHorizontal_1.get_collider() or $RayCastHorizontal_2.get_collider() or $RayCastHorizontal_4.get_collider()) && !$RayCastVertical_2.get_collider() && nav_path[j].y > nav_path[j+1].y:
						start_jump_enemy()
					if $RayCastVertical.get_collider():
						start_jump_enemy()
					if $RayCastHorizontal_3.get_collider():
						start_jump_enemy()

						
			if j < nav_path.size() - 1 && $Sprite.get_animation() != "sword" && $Sprite.get_animation() != "armor" && $Sprite.get_animation() != "push" && $Sprite.get_animation() != "push_preparing":
				if (nav_path[j].x - nav_path[j+1].x) >= 0:
					$RayCastHorizontal_1.set_cast_to(Vector2(-19,0))
					$RayCastHorizontal_2.set_cast_to(Vector2(-19,0))
					$RayCastHorizontal_3.set_cast_to(Vector2(-3,0))
					$RayCastHorizontal_4.set_cast_to(Vector2(-19,0))
					$RayCastHorizontal_For_Heroe.set_cast_to(Vector2(-192,0))
					$RayCastVertical.set_position(Vector2(-11,1))
					$Sword.set_position(Vector2(-25,-6))
					$Stone_Position.set_position(Vector2(-34,-2))
					$RayCastStone.set_position(Vector2(-34,-2))
					$RayCastStone.set_cast_to(get_parent().get_node("Heroe").global_position - self.global_position - Vector2(-34,-2))
					if !stop_machine:
						translate(Vector2(-1,0) * speed)
						get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
						if $Sprite.get_animation() != "jump":
							animate("run")
					$Sprite.flip_h = true

				if (nav_path[j].x - nav_path[j+1].x) <= -0:
					$RayCastHorizontal_1.set_cast_to(Vector2(19,0))
					$RayCastHorizontal_2.set_cast_to(Vector2(19,0))
					$RayCastHorizontal_3.set_cast_to(Vector2(3,0))
					$RayCastHorizontal_4.set_cast_to(Vector2(19,0))
					$RayCastHorizontal_For_Heroe.set_cast_to(Vector2(192,0))
					$RayCastVertical.set_position(Vector2(11,1))
					$Sword.set_position(Vector2(25,-6))
					$Stone_Position.set_position(Vector2(34,-2))
					$RayCastStone.set_position(Vector2(34,-2))
					$RayCastStone.set_cast_to(get_parent().get_node("Heroe").global_position - self.global_position - Vector2(34,-2))
					if !stop_machine:
						translate(Vector2(1,0) * speed)
						get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
						if $Sprite.get_animation() != "jump":
							animate("run")
					$Sprite.flip_h = false
				
			if j < nav_path.size() - 1:
				if ((self.global_position.x - nav_path[j+1].x) < stop_distance_to_point && (self.global_position.x - nav_path[j+1].x) > -stop_distance_to_point) && j < nav_path.size() - 1:
					j += 1

			saved_size_array = nav_path.size()



func start_jump_enemy():
	if is_on_floor():
		velocity.y = -JUMP_POWER 
		animate("jump")
		

func _on_Timer_Of_HP_timeout():
	$value_of_HP.text = str($HP_Enemy_1.value)
	$HP_Enemy_1.value += 1

	
func _on_Timer_Of_Mana_timeout():
	$value_of_Mana.text = str($Mana_Enemy_1.value)
	$Mana_Enemy_1.value += 1


func _on_Trigger_Area_body_entered(body):
	if body.has_method("ally"):
		trigger_of_ally = true
		get_parent().Adalard_was_triggered = true
		manual_navigation = false
		
		
func animate(art):
	$Sprite.play(art)


func _on_Sprite_animation_finished():
	if $Sprite.get_animation() == "sword":
		sword_finished = true
		mana_using(SPELLS_PARAMETERS.manacost_sword_Adalard)
		animate("idle")
		speed = 2.5
	if $Sprite.get_animation() == "push_preparing":
		preparing_for_pushing_finished = true
		stop_pushing = false
		get_node("Area_Pushing").set_monitoring(true)
		mana_using(SPELLS_PARAMETERS.manacost_push_Adalard)
		$Timer_Push.set_wait_time(SPELLS_PARAMETERS.calldown_push_Adalard)
		$Timer_Push.start()
		match self.global_position < get_parent().get_node("Heroe").global_position:
			true: vector_push = Vector2(1,0)
			false: vector_push = Vector2(-1,0)
	if $Sprite.get_animation() == "push":
		speed = 2.5
	if $Sprite.get_animation() == "armor":
		armor = SPELLS_PARAMETERS.fraction_absorbed_damage_armor_Adalard
		mana_using(SPELLS_PARAMETERS.manacost_armor_Adalard)
		animate("push_preparing")
		speed = 2.5
		$Timer_Armor_Duration.set_wait_time(SPELLS_PARAMETERS.duration_armor_Adalard)
		$Timer_Armor_Duration.start()
		

func _on_Sword_body_entered(body):
	if body.has_method("handle_hit") && body.has_method("start_jump_heroe"):
		body.handle_hit(SPELLS_PARAMETERS.damage_sword_Adalard)


func _on_Timer_Sword_timeout():
	sword_ready = true
	sword_finished = false


func _on_Timer_Push_timeout():
	push_ready = true


func _on_Timer_Armor_timeout():
	armor_ready = true


func navigation(number_of_moving):
	
	if !file.is_open() && moving_state:
		file.open("res://Navigations/" + name_character + "/navigation" + str(number_of_moving) + ".txt", File.READ)
	
	if file.is_open():
		if file.get_position() < file.get_len():
			point_of_position_string = file.get_line().split(",",true,1)
			point_of_position_string_x = ((point_of_position_string[0].split("(",false,1)))
			point_of_position_string_y = ((point_of_position_string[1].split(")",true,1)))
			scale_gravity = 0
			if point_of_position_string_x_saved != float(point_of_position_string_x[0]):
				if point_of_position_string_x_saved < float(point_of_position_string_x[0]):
					$Sprite.flip_h = false
				else:
					$Sprite.flip_h = true
				animate("run")
			else:
				animate("idle")
				
			self.set_global_position(Vector2(float(point_of_position_string_x[0]),float(point_of_position_string_y[0]) + 9))
			point_of_position_string_x_saved = float(point_of_position_string_x[0])
		elif file.is_open():
			moving_state = false
			file.close()
			animate("idle")
			scale_gravity = 2
			match number_of_moving:
				1: pass


func dialoge(array_dialoge_flags, number_of_dialoge):
	if array_dialoge_flags.size() != 0:
		if i != (array_dialoge_flags.size() - 1):
			if area_of_dialoge_camera.input_touch == array_dialoge_flags[i] && area_of_dialoge_camera.was_pressed:
				var dialoge_window_1 = dialoge_window.instance()
				dialoge_window_1.position = $Dialoge_Window_Position.position
				if array_dialoge_flags[i] - array_dialoge_flags[i - 1] == 1 && self.has_node("Dialoge_Window"):
					$Dialoge_Window.choosing_text(name_character, area_of_dialoge_camera.input_touch, number_of_dialoge)
					area_of_dialoge_camera.was_pressed = false
				else:
					add_child(dialoge_window_1)
					dialoge_window_1.choosing_text(name_character, area_of_dialoge_camera.input_touch, number_of_dialoge)
					area_of_dialoge_camera.was_pressed = false
				if i != (array_dialoge_flags.size() - 1):
					i += 1
		
		if (area_of_dialoge_camera.input_touch != array_dialoge_flags[i]) && area_of_dialoge_camera.was_pressed && self.has_node("Dialoge_Window"):
			$Dialoge_Window.queue_free()
			if i == (array_dialoge_flags.size() - 1):
				pass






func _on_VisibilityNotifier2D_screen_exited():
	if get_parent().has_method("First_Scene") && GLOBAL.first_cat_scene:
		queue_free()


func _on_Timer_Of_Stun_timeout():
	stun = false

func stun(duration):
	stun = true
	$Timer_Of_Stun.start()
	$Timer_Of_Stun.set_wait_time(duration)

func _on_Timer_Stop_Machine_timeout():
	stop_machine = false
	get_parent().get_node("Stop_Machine/CollisionShape2D").set_disabled(false)




func _on_NavigationAgent2D_path_changed():
	dat = 1


func _on_Area_For_Starting_Fight_body_entered(body):
	if body.has_method("start_jump_heroe"):
		if !body.in_invisibility:
			GLOBAL.enemy_for_fight = name_character
			GLOBAL.position_heroe_before_fight = get_parent().get_node("Heroe").global_position
			GLOBAL.scene("1lvl_Batle_Scene")


func _on_Timer_For_Updaiting_Way_timeout():
	if get_parent().has_node("Heroe"):
		#if get_parent().current_target != Vector2(0,0):
		if !manual_navigation:
			$NavigationAgent2D.set_target_location(get_parent().current_target)
			$NavigationAgent2D.get_final_location()
			nav_path = $NavigationAgent2D.get_nav_path()
			#get_parent().get_node("Line2D2").points = $NavigationAgent2D.get_nav_path()
			j = 0
		
func _on_start_timer_going_back():
	$Timer_For_Going_Back.start()


func push():
	if $Mana_Enemy_1.value >= (SPELLS_PARAMETERS.manacost_push_Adalard + SPELLS_PARAMETERS.manacost_armor_Adalard) && $Sprite.get_animation() != "push" && $Sprite.get_animation() != "push_preparing" && armor == 1:
		$Sprite.flip_h = self.global_position > get_parent().get_node("Heroe").global_position
		animate("armor")
	if $Sprite.get_animation() != "push" && $Sprite.get_animation() != "armor" && $Mana_Enemy_1.value >= SPELLS_PARAMETERS.manacost_push_Adalard:
		animate("push_preparing")
		$Sprite.flip_h = self.global_position > get_parent().get_node("Heroe").global_position
	if preparing_for_pushing_finished:
		animate("push")
		if !stop_pushing:
			translate(vector_push * SPELLS_PARAMETERS.speed_persenage_push_Adalard) 
		else:
			get_node("Area_Pushing").set_monitoring(false)
			preparing_for_pushing_finished = false
			animate("idle")
			push_ready = false
		
	
	
func _on_Area_Pushing_body_entered(body):
	stop_pushing = true
	if body.has_method("start_jump_heroe"):
		body.handle_hit(SPELLS_PARAMETERS.damage_push_Adalard)
		body.stun(SPELLS_PARAMETERS.stun_duration_push_Adalard)
	


func _on_Timer_Armor_Duration_timeout():
	armor = 1
