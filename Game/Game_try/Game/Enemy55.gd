extends KinematicBody2D


var speed = 2.5
var velocity = Vector2()
var name_character = "Jeison"
var trigger_of_ally = false
var file = File.new()
var point_of_position_string
var point_of_position_string_x
var point_of_position_string_x_saved = -10000
var point_of_position_string_y
var point_of_position_string_y_saved
var JUMP_POWER = 500
var stun = false
var nav_path = Vector2()
var manual_navigation = false

onready var heroe = get_parent().get_node("Heroe")
onready var ally = get_parent().get_node("Ally")
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
var dfg = 1

var moving_state
var number_of_moving


func handle_hit(damage):
	#health -= damage
	$HP_Enemy_1.value -= damage
	$value_of_HP.text = str($HP_Enemy_1.value)
	if $HP_Enemy_1.value > 0:
		print(name_character + " was hit! Health of enemy: ", $HP_Enemy_1.value)
	else:
		print(name_character + " was destroyed")
		GLOBAL.life_first_enemy = false
		get_parent().life_enemy = false
		queue_free()


func mana_using(manacost):
	$Mana_Enemy_1.value -= manacost
	$value_of_Mana.text = str($Mana_Enemy_1.value)


func enemy():
	pass


func _ready():
	pass


func _physics_process(delta):
	
	if !$RayCastVertical_3.get_collider():
		$Timer_For_Updaiting_Way.set_wait_time(0.1)
	else:
		$Timer_For_Updaiting_Way.set_wait_time(0.3)
	
	#print(j)
	
	#if $RayCastHorizontal_For_Heroe.get_collider():
	#	if $RayCastHorizontal_For_Heroe.get_collider().has_method("start_jump_heroe"):
	#		GLOBAL.heroe_is_observe = true
	#	else:
	#		GLOBAL.heroe_is_observe = false


	velocity.x = 0

	if get_parent().has_node("Heroe"):
		if get_parent().has_node("NavigationPolygonInstance") &&  dfg == 1:
			#$NavigationAgent2D.set_target_location(get_parent().get_node("Heroe").global_position)
			#$NavigationAgent2D.get_final_location()
			#$NavigationAgent2D.set_final_location()
			#nav_path
			dfg = 2
			#get_parent().get_node("Line2D2").points = nav_path
			#j = 0

	if moving_state:
		navigation(number_of_moving)
	
	if GLOBAL.jeison_dialoge_started && !GLOBAL.jeison_dialoge_finished:
		dialoge(array_dialoge_flags, number_of_dialoge)
	if GLOBAL.jeison_dialoge_finished && GLOBAL.first_cat_scene:
		if get_parent().has_method("First_Scene"):
				translate(Vector2(1,0) * speed)
				get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
				animate("run")
				$Sprite.flip_h = false
	
	
	
	if get_parent().has_node("Heroe"):
		var heroe = get_parent().get_node("Heroe")
		var ally = get_parent().get_node("Ally")
		
	if get_parent().has_node("Heroe") && !stun:

		if trigger_of_ally or get_parent().get_node("Heroe").in_invisibility:       # This paragraph implemented for moving AI in "not-fight scenes". Here created algoritm for finding the shortest ways to heroe, alrotimes for jumping
			if j < nav_path.size() - 1:
				if $RayCastHorizontal_For_Heroe.get_collider() && !$RayCastVertical_2.get_collider():
					if !$RayCastHorizontal_For_Heroe.get_collider().has_method("start_jump_heroe"):
						if ($RayCastHorizontal_1.get_collider() or $RayCastHorizontal_2.get_collider() or $RayCastHorizontal_4.get_collider()) && nav_path[j].y > nav_path[j+1].y:
							start_jump_enemy()
				elif ($RayCastHorizontal_1.get_collider() or $RayCastHorizontal_2.get_collider() or $RayCastHorizontal_4.get_collider()) && !$RayCastVertical_2.get_collider() && nav_path[j].y > nav_path[j+1].y:
							start_jump_enemy()
				if $RayCastVertical.get_collider():
					start_jump_enemy()
				if $RayCastHorizontal_3.get_collider():
					start_jump_enemy()
			#if get_parent().get_node("Line2D").points.size() <= j:
			#		j = 0
			#print(nav_path)
		#	print(nav_path[0].x)
			#print($NavigationAgent2D.get_next_location().x)
			#print(get_parent().get_node("Line2D2").points.size())
			#print(get_parent().get_node("Line2D2").points[j].x)
			#print(get_parent().get_node("Line2D2").points[j].x)
			#print(get_parent().get_node("Line2D2").points[j+1].x)
			#print(j)
			#print(get_parent().get_node("Line2D2").points)
			if $RayCastHorizontal_For_Heroe.get_collider() && !$RayCastVertical_2.get_collider():
				if $RayCastHorizontal_For_Heroe.get_collider().has_method("start_jump_heroe"):
					stop_machine = false
			
			
			#if get_parent().get_node("Line2D2").points.size() == 2:
			#	stop_distance_to_point = 1.5
			#else:
			#	stop_distance_to_point = 1.5
			#print(get_parent().get_node("Line2D").points)
			if j < nav_path.size() - 1:
				#if (self.global_position.x - get_parent().get_node("Line2D").points[j].x) > 0:
				#if (nav_path[0].x - $NavigationAgent2D.get_next_location().x) >= 0:
				if (nav_path[j].x - nav_path[j+1].x) >= 0:
						#speed = 2
						#print(true)
						#print("e1")
						$RayCastHorizontal_1.set_cast_to(Vector2(-19,0))
						$RayCastHorizontal_2.set_cast_to(Vector2(-19,0))
						$RayCastHorizontal_3.set_cast_to(Vector2(-3,0))
						$RayCastHorizontal_4.set_cast_to(Vector2(-19,0))
						$RayCastHorizontal_For_Heroe.set_cast_to(Vector2(-192,0))
						$RayCastVertical.set_position(Vector2(-11,1))
						if !stop_machine:
							speed = 2.5
							translate(Vector2(-1,0) * speed)
							get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
							animate("run")
						$Sprite.flip_h = true
				#if (self.global_position.x - get_parent().get_node("Line2D").points[j].x) < -0:
				#print(global_position.distance_to($NavigationAgent2D.get_next_location()))
				if (nav_path[j].x - nav_path[j+1].x) <= -0:
						#speed = 2
						#print(false)
						#print("e1")
						$RayCastHorizontal_1.set_cast_to(Vector2(19,0))
						$RayCastHorizontal_2.set_cast_to(Vector2(19,0))
						$RayCastHorizontal_3.set_cast_to(Vector2(3,0))
						$RayCastHorizontal_4.set_cast_to(Vector2(19,0))
						$RayCastHorizontal_For_Heroe.set_cast_to(Vector2(192,0))
						$RayCastVertical.set_position(Vector2(11,1))
						if !stop_machine:
							speed = 2.5
							translate(Vector2(1,0) * speed)
							get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
							animate("run")
						$Sprite.flip_h = false
			#(get_parent().get_node("Line2D2").points.size())
			#print(j)
			
			else:
				animate("idle")
			
			if j < nav_path.size() - 1:
				if ((self.global_position.x - nav_path[j+1].x) < stop_distance_to_point && (self.global_position.x - nav_path[j+1].x) > -stop_distance_to_point) && j < nav_path.size() - 1:
						#if get_parent().get_node("Line2D").points.size() != 2:
							j += 1
			#print($NavigationAgent2D.get_nav_path_index())
			#if (self.global_position.x - get_parent().get_node("Heroe").global_position.x) > -stop_distance_to_point && (self.global_position.x - get_parent().get_node("Heroe").global_position.x) < stop_distance_to_point:
			#	speed = 0
			#	animate("idle")
					#if get_parent().get_node("Line2D").points.size() == 2 && j != 1:
					#	j += 1
			saved_size_array = nav_path.size()
		
				

	velocity.y += delta * 970 * scale_gravity
	velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)

func start_jump_enemy():
	if is_on_floor():
		velocity.y = -JUMP_POWER 
		#collision_of_jumping_area.set_disabled(true)

func _on_Timer_Of_HP_timeout():
	$value_of_HP.text = str($HP_Enemy_1.value)
	$HP_Enemy_1.value += 1

	
func _on_Timer_Of_Mana_timeout():
	$value_of_Mana.text = str($Mana_Enemy_1.value)
	$Mana_Enemy_1.value += 1


func _on_Trigger_Area_body_entered(body):
	if body.has_method("ally"):
		trigger_of_ally = true
		manual_navigation = false
		
		
func animate(art):
	$Sprite.play(art)


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
				
			self.set_global_position(Vector2(float(point_of_position_string_x[0]),float(point_of_position_string_y[0]) + 2))
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


func _on_VisibilityNotifier2D_screen_exited():
	if get_parent().has_method("First_Scene") && GLOBAL.first_cat_scene:
		queue_free()


func _on_NavigationAgent2D_path_changed():
	#$NavigationAgent2D.set_target_location(get_parent().get_node("Heroe").global_position)
	#$NavigationAgent2D.get_final_location()
	pass
	j = 0


func _on_Timer_For_Updaiting_Way_timeout():
	if get_parent().get_node("Heroe"):
		#if get_parent().current_target != Vector2(0,0):
		if !manual_navigation:
			$NavigationAgent2D.set_target_location(get_parent().current_target)
			$NavigationAgent2D.get_final_location()
			nav_path = $NavigationAgent2D.get_nav_path()
			get_parent().get_node("Line2D2").points = $NavigationAgent2D.get_nav_path()
			j = 0


func _on_Area_For_Starting_Fight_body_entered(body):
	if body.has_method("start_jump_heroe"):
		if !body.in_invisibility:
			GLOBAL.enemy_for_fight = name_character
			GLOBAL.position_heroe_before_fight = get_parent().get_node("Heroe").global_position
			#GLOBAL.scene("Max_level_Fight_Scene")



