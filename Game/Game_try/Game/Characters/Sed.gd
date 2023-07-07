extends KinematicBody2D


var speed = 2.5
var velocity = Vector2()
var name_character = "Sed"
var trigger_of_ally = false
var file = File.new()
var JUMP_POWER = 500
var stun = false
var nav_path = [Vector2()]
var manual_navigation = false


onready var ally = get_parent().get_node("Ally")
onready var area_of_dialoge_camera = get_parent().get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")

var stop_machine = false
var dialoge_window = preload("res://Game/Dialoge_Window.tscn")
var i = 0
var c = 0
var j = 0
var scale_gravity = 2
var dfg = 1
var stop_distance_to_point = 1.5

var moving_state
var number_of_moving

var chaining_ready


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
	


	velocity.x = 0

	if get_parent().has_node("Heroe"):
		if get_parent().has_node("NavigationPolygonInstance") &&  dfg == 1:
			dfg = 2

	
	
	if get_parent().has_node("Heroe"):
		var heroe = get_parent().get_node("Heroe")
		var ally = get_parent().get_node("Ally")
		
	if get_parent().has_node("Heroe") && !stun:
		var heroe = get_parent().get_node("Heroe")
		if trigger_of_ally or get_parent().get_node("Heroe").in_invisibility && get_parent().Sed_was_triggered:       # This paragraph implemented for moving AI in "not-fight scenes". Here created algoritm for finding the shortest ways to heroe, alrotimes for jumping
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
			#print($Sprite.get_animation())
			if $RayCastHorizontal_For_Heroe.get_collider() && get_parent().get_node("Heroe/RayCastForFloor").get_collider() && $Mana_Enemy_1.value >= SPELLS_PARAMETERS.manacost_chaining:
				#print(false)
				if ((((self.global_position.x - heroe.global_position.x) < 800) && ((self.global_position.x - heroe.global_position.x) > 53)) or (((self.global_position.x - heroe.global_position.x) > -800) && ((self.global_position.x - heroe.global_position.x) < -53))) && chaining_ready && is_on_floor() && $RayCastHorizontal_For_Heroe.get_collider().has_method("start_jump_heroe"):
					if $Sprite.get_animation() != "shield_punch":
						if((self.global_position.x) - heroe.global_position.x) > 0:
							$Sprite.flip_h = true
						else:
							$Sprite.flip_h = false
						mana_using(SPELLS_PARAMETERS.manacost_chaining)
						$Timer_Chaining.set_wait_time(SPELLS_PARAMETERS.calldown_chaining)
						$Timer_Chaining.start()
						speed = 0
						chaining_ready = false
						animate("chaining")
						get_parent().get_node("Heroe").stun(SPELLS_PARAMETERS.chaining_stun_duration) 
						get_parent().get_node("Heroe").slowdown(SPELLS_PARAMETERS.chaining_slowdown, SPELLS_PARAMETERS.chaining_slowdown_duration)
			
			
			if $RayCastHorizontal_For_Heroe.get_collider() && !$RayCastVertical_2.get_collider():
				if $RayCastHorizontal_For_Heroe.get_collider().has_method("start_jump_heroe"):
					stop_machine = false
			#print(j)
			#print( nav_path.size() - 1)
			if j < nav_path.size() - 1 && $Sprite.get_animation() != "chaining" && $Sprite.get_animation() != "shield_punch":
				#print(true)
				if (nav_path[j].x - nav_path[j+1].x) >= 0:
						#print(false)
						$RayCastHorizontal_1.set_cast_to(Vector2(-19,0))
						$RayCastHorizontal_2.set_cast_to(Vector2(-19,0))
						$RayCastHorizontal_3.set_cast_to(Vector2(-3,0))
						$RayCastHorizontal_4.set_cast_to(Vector2(-19,0))
						$RayCastHorizontal_For_Heroe.set_cast_to(Vector2(-192,0))
						$RayCastVertical.set_position(Vector2(-11,1))
						if !stop_machine:
							translate(Vector2(-1,0) * speed)
							get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
							animate("run")
						$Sprite.flip_h = true
				if (nav_path[j].x - nav_path[j+1].x) <= -0:
						#print(false)
						$RayCastHorizontal_1.set_cast_to(Vector2(19,0))
						$RayCastHorizontal_2.set_cast_to(Vector2(19,0))
						$RayCastHorizontal_3.set_cast_to(Vector2(3,0))
						$RayCastHorizontal_4.set_cast_to(Vector2(19,0))
						$RayCastHorizontal_For_Heroe.set_cast_to(Vector2(192,0))
						$RayCastVertical.set_position(Vector2(11,1))
						if !stop_machine:
							translate(Vector2(1,0) * speed)
							get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
							animate("run")
						$Sprite.flip_h = false

			if j < nav_path.size() - 1:
				if ((self.global_position.x - nav_path[j+1].x) < stop_distance_to_point && (self.global_position.x - nav_path[j+1].x) > -stop_distance_to_point) && j < nav_path.size() - 1:
					j += 1
		
				

	velocity.y += delta * 970 * scale_gravity
	velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)

func start_jump_enemy():
	if is_on_floor():
		velocity.y = -JUMP_POWER 


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

func _on_Sprite_animation_finished():
	if $Sprite.get_animation() == "chaining":
		#chaining_ready = false
		animate("idle")
		speed = 2.5

		
func _on_VisibilityNotifier2D_screen_exited():
	if get_parent().has_method("First_Scene") && GLOBAL.first_cat_scene:
		queue_free()


func _on_NavigationAgent2D_path_changed():
	#$NavigationAgent2D.set_target_location(get_parent().get_node("Heroe").global_position)
	#$NavigationAgent2D.get_final_location()
	pass
	j = 0


func _on_Timer_For_Updaiting_Way_timeout():
	if get_parent().has_node("Heroe"):
		#if get_parent().current_target != Vector2(0,0):
		if !manual_navigation:
			#print(true)
			#print(get_parent().current_target)
			$NavigationAgent2D.set_target_location(get_parent().current_target)
			$NavigationAgent2D.get_final_location()
			nav_path = $NavigationAgent2D.get_nav_path()
			#print(nav_path)
			#get_parent().get_node("Line2D2").points = $NavigationAgent2D.get_nav_path()
			j = 0


func _on_Area_For_Starting_Fight_body_entered(body):
	if body.has_method("start_jump_heroe"):
		if !body.in_invisibility:
			GLOBAL.enemy_for_fight = name_character
			GLOBAL.position_heroe_before_fight = get_parent().get_node("Heroe").global_position
			#GLOBAL.scene("Max_level_Fight_Scene")





func _on_Timer_Chaining_timeout():
	chaining_ready = true


func _on_Timer_Of_Stun_timeout():
	pass # Replace with function body.


func _on_Timer_Stop_Machine_timeout():
	pass # Replace with function body.


func _on_Timer_For_Going_Back_timeout():
	pass # Replace with function body.
