extends KinematicBody2D

var health
var ally
var heroe
var speed = 2.5
var velocity = Vector2()
var name_character = "Sed"
var trigger_of_ally = false
var file = File.new()
var JUMP_POWER = 500
var regeneration_in_second = 1
var stun = false
var nav_path = [Vector2()]
var should_be_triggered_after_manual_navigation = false
var area_from_which_manual_navigation_was_started
var target_points_for_manual_navigation = []
var manual_navigation = false
var current_target
var vampirism = 0
var damage_increase = 0
var array_for_dropping_consumption_health_animations = []
var chaining = preload("res://Game/Spells/Chaining.tscn")
var statusbar = preload("res://Game/Spells/BarDuration.tscn")
var drop_of_consumption_health = preload("res://Game/Spells/Drop_For_Consumption_Helath.tscn")
onready var area_of_dialoge_camera = get_parent().get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")

var amount_status_bars = []
var array_of_slowdowns = []
var chaining_casted = false
var shield_punch_ready = true
var shield_punch_finished = false
var armor_ordinary = 0
var armor_left = 0
var armor_right = 0

var scale_speed_moving = 1
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

var chaining_ready = true


func handle_hit(damage, attacking_character, attacking_object = null):
	var what_attacks = attacking_character
	if attacking_object != null:
		what_attacks = attacking_object
	var sum_armor
	if what_attacks.global_position.x < self.global_position.x:
		sum_armor = armor_left + armor_ordinary
	else:
		sum_armor = armor_right + armor_ordinary
	if sum_armor > 1:
		sum_armor = 1
	$health_Enemy_1.value -= damage * (1 - sum_armor) * (1 + attacking_character.damage_increase)
	$value_of_health.text = str($health_Enemy_1.value)
	if attacking_character.vampirism != 0:
		attacking_character.get_node("health_Enemy_1").value += damage * (1 - sum_armor) * attacking_character.vampirism


	if $health_Enemy_1.value > 0:
		print(name_character + " was hit! Health of enemy: ", $health_Enemy_1.value)
	else:
		print(name_character + " was destroyed")
		queue_free()


func mana_using(manacost):
	$mana_Enemy_1.value -= manacost
	$value_of_mana.text = str($mana_Enemy_1.value)


func enemy():
	pass


func _ready():
	health = SPELLS_PARAMETERS.characters[name_character]["health"]


func _physics_process(delta):
	health = $health_Enemy_1.value
	#print(self.get_global_position())
	#if j < nav_path.size() - 1:
	#	if (nav_path[j].x - nav_path[j+1].x) >= 0:
	#		$RayCastHorizontal_For_Heroe.set_cast_to(Vector2(-192,0))
	#	if (nav_path[j].x - nav_path[j+1].x) <= -0:
	#		$RayCastHorizontal_For_Heroe.set_cast_to(Vector2(192,0))
	#print($RayCastHorizontal_For_Heroe.get_cast_to())
	if manual_navigation && (self.global_position.x - nav_path[nav_path.size() - 1].x < 20 && self.global_position.x - nav_path[nav_path.size() - 1].x > -20 && self.global_position.y - nav_path[nav_path.size() - 1].y < 20 && self.global_position.y - nav_path[nav_path.size() - 1].y > -20) && $Sprite.get_animation() == "run":
		if target_points_for_manual_navigation != []:
			current_target = target_points_for_manual_navigation[0]
			update_way()
			target_points_for_manual_navigation.remove(0)
		else:
			manual_navigation = false
			speed = 2.5
			animate("idle")
			get_parent().triggered_enemies[name] = should_be_triggered_after_manual_navigation
			if get_parent().has_method("already_finished_manual_navigation_which_started_from_area_entering") && area_from_which_manual_navigation_was_started != null:
				get_parent().already_finished_manual_navigation_which_started_from_area_entering(self.name_character, area_from_which_manual_navigation_was_started)
	#print("ibo")
	#print($Sprite.get_animation())
	if $Sprite.get_animation() == "idle_shield":
		if $Sprite.flip_h == true:
			armor_left = SPELLS_PARAMETERS.fraction_absorbed_damage_armor_Sed
			armor_right = 0
		else:
			armor_left = 0
			armor_right = SPELLS_PARAMETERS.fraction_absorbed_damage_armor_Sed
	else:
		armor_left = 0
		armor_right = 0
	
	if !$RayCastVertical_3.get_collider():
		$Timer_For_Updaiting_Way.set_wait_time(0.1)
	else:
		$Timer_For_Updaiting_Way.set_wait_time(0.3)

	velocity.x = 0
	$Shield_Punch/CollisionShape2D.set_disabled(true)


			
	if heroe == null:
		if get_parent().has_node("Heroe"):
			heroe = get_parent().get_node("Heroe")
			ally = get_parent().get_node("Ally")
		if get_parent().has_node("NavigationPolygonInstance") &&  dfg == 1:
			dfg = 2
	elif !manual_navigation:
		if get_parent().has_node("Heroe"):
			current_target = heroe.global_position
	
		
	if get_parent().has_node("Heroe") && !stun:
		if((self.global_position.x) - get_parent().get_node("Heroe").global_position.x) > 0:
			$Shield_Punch.set_position(Vector2(-18,-6))
			$Sprite.flip_h = true
		else:
			$Shield_Punch.set_position(Vector2(18,-6))
			$Sprite.flip_h = false
		var heroe = get_parent().get_node("Heroe")
		if get_parent().triggered_enemies[name_character] == true or get_parent().get_node("Heroe").in_invisibility && get_parent().has_method("Fight_Scene") && get_parent().Sed_was_triggered:       # This paragraph implemented for moving AI in "not-fight scenes". Here created algoritm for finding the shortest ways to heroe, alrotimes for jumping
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
			#print($RayCastHorizontal_For_Heroe.get_collider())
			#print(get_parent().get_node("Heroe/RayCastForFloor").get_collider())
			#print($mana_Enemy_1.value >= SPELLS_PARAMETERS.manacost_chaining_Sed)
			#print($Sprite.get_animation() == "idle")
			if $RayCastHorizontal_For_Heroe.get_collider() && get_parent().get_node("Heroe/RayCastForFloor").get_collider() && $mana_Enemy_1.value >= SPELLS_PARAMETERS.manacost_chaining_Sed && $Sprite.get_animation() == "idle":
				if ((((self.global_position.x - heroe.global_position.x) < 800) && ((self.global_position.x - heroe.global_position.x) > 53)) or (((self.global_position.x - heroe.global_position.x) > -800) && ((self.global_position.x - heroe.global_position.x) < -53))) && chaining_ready && $RayCastVertical_3.get_collider() && $RayCastHorizontal_For_Heroe.get_collider().has_method("start_jump_heroe"):
						if((self.global_position.x) - heroe.global_position.x) > 0:
							$Sprite.flip_h = true
						else:
							$Sprite.flip_h = false
						mana_using(SPELLS_PARAMETERS.manacost_chaining_Sed)
						$Timer_Chaining.set_wait_time(SPELLS_PARAMETERS.calldown_chaining_Sed)
						$Timer_Chaining.start()
						speed = 0
						chaining_ready = false
						animate("chaining")
						get_parent().get_node("Heroe").stun(SPELLS_PARAMETERS.chaining_stun_duration_Sed) 
						get_parent().get_node("Heroe").slowdown(SPELLS_PARAMETERS.chaining_slowdown_Sed, SPELLS_PARAMETERS.chaining_slowdown_duration_Sed)
						chaining_casted = true
						get_parent().get_node("Heroe").cant_jump = true
						var chaining_1 = chaining.instance()
						chaining_1.position = heroe.global_position - Vector2(0, -25)
						get_node("..").add_child(chaining_1)
			if ((self.global_position.x) - heroe.global_position.x < 38) && (self.global_position.x - heroe.global_position.x > -38) && $RayCastVertical_3.get_collider() && ((self.get_position().y - heroe.get_position().y < 50) && (self.get_position().y - heroe.get_position().y > -50)) && $mana_Enemy_1.value >= SPELLS_PARAMETERS.manacost_shield_punch_Sed && shield_punch_ready: 
					if $Sprite.get_animation() == "idle_shield":
						if((self.global_position.x) - heroe.global_position.x) > 0:
							$Sprite.flip_h = true
						else:
							$Sprite.flip_h = false
						speed = 0
						$Timer_Shield_Punch.set_wait_time(SPELLS_PARAMETERS.calldown_shield_punch_Sed)
						$Timer_Shield_Punch.start()
						shield_punch_ready = false
						animate("shield_punch")
								
			if $RayCastHorizontal_For_Heroe.get_collider() && !$RayCastVertical_2.get_collider():
				if $RayCastHorizontal_For_Heroe.get_collider().has_method("start_jump_heroe"):
					stop_machine = false
			if j < nav_path.size() - 1 && $Sprite.get_animation() != "chaining" && $Sprite.get_animation() != "shield_punch" && $Sprite.get_animation() != "stance_shield" && $Sprite.get_animation() != "idle_shield":
				if (nav_path[j].x - nav_path[j+1].x) >= 0:
						$RayCastHorizontal_1.set_cast_to(Vector2(-19,0))
						$RayCastHorizontal_2.set_cast_to(Vector2(-19,0))
						$RayCastHorizontal_3.set_cast_to(Vector2(-3,0))
						$RayCastHorizontal_4.set_cast_to(Vector2(-19,0))
						$RayCastHorizontal_For_Heroe.set_cast_to(Vector2(-192,0))
						$RayCastVertical.set_position(Vector2(-11,1))
						if !stop_machine && chaining_casted:
							translate(Vector2(-1,0) * speed * scale_speed_moving)
							get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
							animate("run")
						$Sprite.flip_h = true
				if (nav_path[j].x - nav_path[j+1].x) <= -0:
						$RayCastHorizontal_1.set_cast_to(Vector2(19,0))
						$RayCastHorizontal_2.set_cast_to(Vector2(19,0))
						$RayCastHorizontal_3.set_cast_to(Vector2(3,0))
						$RayCastHorizontal_4.set_cast_to(Vector2(19,0))
						$RayCastHorizontal_For_Heroe.set_cast_to(Vector2(192,0))
						$RayCastVertical.set_position(Vector2(11,1))
						if !stop_machine && chaining_casted:
							translate(Vector2(1,0) * speed * scale_speed_moving)
							get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
							animate("run")
						$Sprite.flip_h = false

			if j < nav_path.size() - 1:
				if ((self.global_position.x - nav_path[j+1].x) < stop_distance_to_point && (self.global_position.x - nav_path[j+1].x) > -stop_distance_to_point) && j < nav_path.size() - 1:
					j += 1
		
		if shield_punch_finished:
			$Shield_Punch/CollisionShape2D.set_disabled(false)
			shield_punch_finished = false
			
	if !$RayCastVertical_3.get_collider():
		velocity.y += delta * 970 * scale_gravity
		velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)

func start_jump_enemy():
	if is_on_floor():
		velocity.y = -JUMP_POWER 


func _on_Timer_Of_HP_timeout():
	$value_of_health.text = str($health_Enemy_1.value)
	$health_Enemy_1.value += regeneration_in_second

	
func _on_Timer_Of_Mana_timeout():
	$value_of_mana.text = str($mana_Enemy_1.value)
	$mana_Enemy_1.value += 1


func _on_Trigger_Area_body_entered(body):
	if body.has_method("ally"):
		get_parent().triggered_enemies["Her"] = true
		get_parent().triggered_enemies["Jeison"] = true
		get_parent().triggered_enemies[name_character] = true
		trigger_of_ally = true
		manual_navigation = false

		
		
func animate(art):
	$Sprite.play(art)

func _on_Sprite_animation_finished():
	if $Sprite.get_animation() == "stance_shield":
		animate("idle_shield")
		speed = 0
	if $Sprite.get_animation() == "shield_punch":
		animate("idle_shield")
		speed = 0
		shield_punch_finished = true
		mana_using(SPELLS_PARAMETERS.manacost_shield_punch_Sed)
		$Shield_Punch/CollisionShape2D.set_disabled(false)
	if $Sprite.get_animation() == "chaining":
		animate("stance_shield")
		speed = 0

		
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
			$NavigationAgent2D.set_target_location(current_target)
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


func update_way():
	$NavigationAgent2D.set_target_location(current_target)
	$NavigationAgent2D.get_final_location()
	nav_path = $NavigationAgent2D.get_nav_path()
	j = 0


func _on_Timer_Chaining_timeout():
	chaining_ready = true

func stun(duration):
	var statusbar1 = statusbar.instance()
	if stun == true:
		if duration > $Timer_Of_Stun.time_left:
			stun = true
			statusbar1.i = duration
			$Timer_Of_Stun.set_wait_time(duration)
			$Timer_Of_Stun.start()
	else:
		statusbar1.i = duration
		get_node("For_Status_Bars").add_child(statusbar1)
		stun = true
		$Timer_Of_Stun.set_wait_time(duration)
		$Timer_Of_Stun.start()
	
func slowdown(scale_speed, duration):
	var statusbar1 = statusbar.instance()
	statusbar1.i = duration
	get_node("For_Status_Bars").add_child(statusbar1)
	if scale_speed_moving > scale_speed:
		scale_speed_moving -= scale_speed
	else:
		scale_speed_moving = 0
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = duration
	timer.connect("timeout", self, "_on_timer_timeout", [scale_speed, timer])
	timer.start()
	
	
func _on_timer_timeout(scale_speed, timer):
	if scale_speed_moving + scale_speed < 1:
		scale_speed_moving += scale_speed
	else:
		scale_speed_moving = 1
	timer.queue_free()
	

func _on_Timer_Of_Stun_timeout():
	stun = false


func _on_Timer_Stop_Machine_timeout():
	pass # Replace with function body.


func _on_Timer_For_Going_Back_timeout():
	pass # Replace with function body.


func _on_Shield_Punch_body_entered(body):
	if body.has_method("handle_hit") && body.has_method("start_jump_heroe"):
		body.handle_hit(SPELLS_PARAMETERS.damage_shield_punch_Sed, self)


func _on_Timer_Shield_Punch_timeout():
	shield_punch_ready = true
	


