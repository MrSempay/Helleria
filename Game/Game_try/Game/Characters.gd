extends KinematicBody2D

var health
var ally = null
var heroe = null
var speed = 2.5
var velocity = Vector2()
var name_character
var trigger_of_ally = false
var file = File.new()
var JUMP_POWER = 500
var regeneration_in_second = 1
var stun = false
var nav_path = [Vector2()]
var target_points_for_manual_navigation = []
var should_be_triggered_after_manual_navigation = false
var area_from_which_manual_navigation_was_started
var manual_navigation = false
var current_target
var armor_ordinary = 0
var armor_left = 0
var armor_right = 0
var amount_squall_attacks
var vampirism = 0
var delay_handle_area = 0
var damage_increase = 0
var vector_push
var summary_health_or_mana_for_chain = []
var preparing_for_pushing_finished = false
var stop_pushing = false
var spells_ready = {
	"handle_attack_ready": true,
	"squall_attack_ready": true,
	"jumping_to_point_ready": true,
	"stone_wall_ready": true,
	"push_ready": true,
	"armor_ready": true
	}
var chains_ready = {
	"damage_block_chain_ready": true,
	"damage_increase_chain_ready": true,
	"cure_chain_ready": true
}
var array_for_dropping_consumption_health_animations = []

var stone_wall = preload("res://Game/Tile_setsTools_for_level/Tools_for_level/Stone_Wall.tscn")
var chaining = preload("res://Game/Spells/Chaining.tscn")
var statusbar = preload("res://Game/Spells/BarDuration.tscn")
var wave = preload("res://Game/Spells/Wave.tscn")
var drop_of_consumption_health = preload("res://Game/Spells/Drop_For_Consumption_Helath.tscn")
onready var area_of_dialoge_camera = get_parent().get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")

var amount_status_bars = []
var array_of_slowdowns = []


var scale_speed_moving = 1
var stop_machine = false
var dialoge_window = preload("res://Game/Dialoge_Window.tscn")
var i = 0
var c = 0
var j = 0
var scale_gravity = 2
var dfg = 1
var stop_distance_to_point = 1.5
var special_physics_process_controlling = false

var moving_state
var number_of_moving

var position_attack_area_x


func handle_hit(damage, attacking_object = null):
	#health -= damage
	if attacking_object != null:
		var sum_armor
		if attacking_object.global_position.x < self.global_position.x:
			sum_armor = armor_left + armor_ordinary
		else:
			sum_armor = armor_right + armor_ordinary
		if sum_armor > 1:
			sum_armor = 1
		$HP_Enemy_1.value -= damage * (1 - sum_armor) * (1 + attacking_object.damage_increase)
		$value_of_HP.text = str($HP_Enemy_1.value)
	else:
		$HP_Enemy_1.value -= damage * (1 - armor_ordinary)
		$value_of_HP.text = str($HP_Enemy_1.value)

	if $HP_Enemy_1.value <= 0:
		self.queue_free()

func mana_using(manacost):
	$Mana_Enemy_1.value -= manacost
	$value_of_Mana.text = str($Mana_Enemy_1.value)


func enemy():
	pass
	
	
func _ready():
	
	#print(GLOBAL.intersecting_vectors(GLOBAL.get_segments_from_CollisionShape_or_collisionPolygon($Area_For_Wall_Detecting), [[Vector2(196,21), Vector2(210,22)]]))
	name_character = self.get_name()
	health = SPELLS_PARAMETERS.characters[name_character]["health"]
	$HP_Enemy_1.max_value = SPELLS_PARAMETERS.characters[name_character]["health"]
	$HP_Enemy_1.value = SPELLS_PARAMETERS.characters[name_character]["health"]
	$value_of_HP.text = str($HP_Enemy_1.value)
	
	$Mana_Enemy_1.max_value = SPELLS_PARAMETERS.characters[name_character]["mana"]
	$Mana_Enemy_1.value = SPELLS_PARAMETERS.characters[name_character]["mana"]
	$value_of_Mana.text = str($Mana_Enemy_1.value)
	
	for i in range($Timers.get_children().size()):
			$Timers.get_children()[i].connect("timeout", self, "_on_" + $Timers.get_children()[i].get_name() + "_timeout")
	$Trigger_Area.connect("body_entered", self, "_on_Trigger_Area_body_entered")
	$VisibilityNotifier2D.connect("screen_exited", self, "_on_VisibilityNotifier2D_screen_exited")
	$NavigationAgent2D.connect("path_changed", self, "_on_NavigationAgent2D_path_changed")
	$Area_For_Starting_Fight.connect("body_entered", self, "_on_Area_For_Starting_Fight_body_entered")
	if has_node("Handle_Attack"):
		position_attack_area_x = $Handle_Attack.position.x
		$Handle_Attack.connect("body_entered", self, "_on_Handle_Attack_body_entered")
	$Sprite.connect("animation_finished", self, "_on_Sprite_animation_finished")

func _physics_process(delta):
	#print(chains_ready["damage_block_chain_ready"])
	health = $HP_Enemy_1.value
	#print(str(self.get_global_position()) + " HER ")
	#print(get_parent().triggered_enemies[name])
	#print(get_parent().triggered_enemies[name_character])

	if nav_path.size() > 0:
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
	#print(self.global_position)
	#print(current_target)
	#print(manual_navigation)
	#print(trigger_of_ally)
	#print($RayCastVertical_3.get_collider() )
	#print(nav_path)
	#print($Sprite.get_animation())
	#print(nav_path)
	#print(speed)
	#print(self.global_position.x)
	

	
	if !$Handle_Attack/CollisionShape2D.is_disabled():
		if delay_handle_area == 1:
			$Handle_Attack/CollisionShape2D.set_disabled(true)
			delay_handle_area = 0
		else:
			delay_handle_area = 1
	
	velocity.x = 0
	if get_parent().has_node("Heroe"):
		if get_parent().has_node("NavigationPolygonInstance") &&  dfg == 1:
			dfg = 2
	
	if get_parent().has_node("Heroe") && heroe == null:
		heroe = get_parent().get_node("Heroe")
		ally = get_parent().get_node("Ally")

	if !manual_navigation && heroe != null && is_instance_valid(heroe):
		current_target = heroe.global_position
		
	
	if !stun && !special_physics_process_controlling:
		#print(heroe.global_position.x)
		if get_parent().has_node("Heroe"):
			if((self.global_position.x) - get_parent().get_node("Heroe").global_position.x) > 0:
				$Handle_Attack.set_position(Vector2(-position_attack_area_x, -6))
				$Sprite.flip_h = true
			else:
				$Handle_Attack.set_position(Vector2(position_attack_area_x, -6))
				$Sprite.flip_h = false
		#var heroe = get_parent().get_node("Heroe")
		if get_parent().get_name() != "root":
			if get_parent().triggered_enemies[name_character] == true:       # This paragraph implemented for moving AI in "not-fight scenes". Here created algoritm for finding the shortest ways to heroe, alrotimes for jumping			
				#print(nav_path)
				#print(current_target)
				#print(name_character)
				#print("SHIT")
				if j < nav_path.size() - 1:
					#print(true)
					if $RayCastHorizontal_For_Heroe.get_collider() && !$RayCastVertical_2.get_collider():
						#print(false)
						if !$RayCastHorizontal_For_Heroe.get_collider().has_method("start_jump_heroe"):
							if ($RayCastHorizontal_1.get_collider() or $RayCastHorizontal_2.get_collider() or $RayCastHorizontal_4.get_collider()) && nav_path[j].y > nav_path[j+1].y:
								start_jump_enemy()
					elif ($RayCastHorizontal_1.get_collider() or $RayCastHorizontal_2.get_collider() or $RayCastHorizontal_4.get_collider()) && !$RayCastVertical_2.get_collider() && nav_path[j].y > nav_path[j+1].y:
								start_jump_enemy()
					if $RayCastVertical.get_collider():
						#print(nav_path)
						#print( "Collider " + str($RayCastVertical.get_collider().global_position.y) )
						#print( "path " + str(nav_path[1].y))
						if $RayCastVertical.get_collider().has_node("Area_To_Jump"):
							if nav_path.size() == 2:
								if GLOBAL.intersecting_vectors(GLOBAL.get_segments_from_CollisionShape_or_collisionPolygon($RayCastVertical.get_collider().get_node("Area_To_Jump")), [[nav_path[0], nav_path[1]]]):
									print("Ibo1")
									start_jump_enemy()
							else:
								if GLOBAL.intersecting_vectors(GLOBAL.get_segments_from_CollisionShape_or_collisionPolygon($RayCastVertical.get_collider().get_node("Area_To_Jump")), [[nav_path[0], nav_path[1]], [nav_path[1], nav_path[2]]]):
									print("Ibo2")
									start_jump_enemy()
						if nav_path.size() == 2:
							if !GLOBAL.intersecting_vectors(GLOBAL.get_segments_from_CollisionShape_or_collisionPolygon($RayCastVertical.get_collider()), [[nav_path[0], nav_path[1]]]):
								print("Ibo3")
								start_jump_enemy()
						else:
							if !GLOBAL.intersecting_vectors(GLOBAL.get_segments_from_CollisionShape_or_collisionPolygon($RayCastVertical.get_collider()), [[nav_path[0], nav_path[1]], [nav_path[1], nav_path[2]]]):
								#print(nav_path)
								print("Ibo4")
								start_jump_enemy()
					if $RayCastHorizontal_3.get_collider():
						start_jump_enemy()
				if $RayCastHorizontal_For_Heroe.get_collider() && !$RayCastVertical_2.get_collider():
					if $RayCastHorizontal_For_Heroe.get_collider().has_method("start_jump_heroe"):
						stop_machine = false
				#print(j < nav_path.size() - 1)
				#print(current_target)
				#print(get_parent().triggered_enemies[name_character])
				#print(nav_path)
				#print(nav_path)
				if j < nav_path.size() - 1 && ($Sprite.get_animation() == "idle" or $Sprite.get_animation() == "jump" or $Sprite.get_animation() == "run" or $Sprite.get_animation() == "jumping_to_point" or $Sprite.get_animation() == "preparing_jumping_to_point") && $Handle_Attack/CollisionShape2D.is_disabled():
					#print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
					if (nav_path[j].x - nav_path[j+1].x) >= 0:
						
						$RayCastHorizontal_1.set_cast_to(Vector2(-19,0))
						$RayCastHorizontal_2.set_cast_to(Vector2(-19,0))
						$RayCastHorizontal_3.set_cast_to(Vector2(-4,0))
						$RayCastHorizontal_4.set_cast_to(Vector2(-19,0))
						$RayCastHorizontal_For_Heroe.set_cast_to(Vector2(-192,0))
						$RayCastVertical.set_position(Vector2(-11,1))
						if !stop_machine:
							move_and_collide(Vector2(-1,0) * speed * scale_speed_moving)
							get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
							if $Sprite.get_animation() != "jumping_to_point" && $Sprite.get_animation() != "preparing_jumping_to_point":
								animate("run")
						$Sprite.flip_h = true
					if (nav_path[j].x - nav_path[j+1].x) <= -0:
						$RayCastHorizontal_1.set_cast_to(Vector2(19,0))
						$RayCastHorizontal_2.set_cast_to(Vector2(19,0))
						$RayCastHorizontal_3.set_cast_to(Vector2(4,0))
						$RayCastHorizontal_4.set_cast_to(Vector2(19,0))
						$RayCastHorizontal_For_Heroe.set_cast_to(Vector2(192,0))
						$RayCastVertical.set_position(Vector2(11,1))
						if !stop_machine:
							move_and_collide(Vector2(1,0) * speed * scale_speed_moving)
							get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
							if $Sprite.get_animation() != "jumping_to_point" && $Sprite.get_animation() != "preparing_jumping_to_point":
								animate("run")
						$Sprite.flip_h = false

				if j < nav_path.size() - 1:
					if ((self.global_position.x - nav_path[j+1].x) < stop_distance_to_point && (self.global_position.x - nav_path[j+1].x) > -stop_distance_to_point) && j < nav_path.size() - 1:
						j += 1
	if !$RayCastVertical_3.get_collider():
		velocity.y += delta * 970 * scale_gravity
		velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
		#translate(velocity)
		#velocity.y = 0
	else:
			
		#print("Еблявая хуета")
		if $Sprite.get_animation() == "jumping_to_point":
			manual_navigation = false
			speed = 2.5
			animate("idle")
			update_way()
		
func start_jump_enemy():
	if (is_on_floor() or $RayCastVertical_3.get_collider()) && $Sprite.get_animation()[0] != "A":
		velocity.y = -JUMP_POWER
		velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)


func _on_Timer_Of_HP_timeout():
	$value_of_HP.text = str($HP_Enemy_1.value)
	$HP_Enemy_1.value += regeneration_in_second

	
func _on_Timer_Of_Mana_timeout():
	$value_of_Mana.text = str($Mana_Enemy_1.value)
	$Mana_Enemy_1.value += 1


func _on_Trigger_Area_body_entered(body):
	if body.has_method("ally"):
		#trigger_of_ally = true
		get_parent().triggered_enemies[name_character] = true
		if !get_parent().has_method("Fight_Scene"):
			manual_navigation = false

""" --------------- HANDLE ATTACK --------------- """

func _on_Handle_Attack_body_entered(body):
	if body.has_method("handle_hit") && body.has_method("start_jump_heroe"):
		if $Sprite.get_animation().substr(0, 2) == "A_":
			if SPELLS_PARAMETERS.characters[name_character]["handle_attack"].has("handle_attack_damage"):
				body.handle_hit(SPELLS_PARAMETERS.characters[name_character]["handle_attack"]["handle_attack_damage"], self)
			if SPELLS_PARAMETERS.characters[name_character]["handle_attack"].has("handle_attack_stun"):
				body.stun(SPELLS_PARAMETERS.characters[name_character]["handle_attack"]["handle_attack_stun"])
			if SPELLS_PARAMETERS.characters[name_character]["handle_attack"].has("handle_attack_thrust"):
				body.thrust(self, SPELLS_PARAMETERS.characters[name_character]["handle_attack"]["handle_attack_thrust"])

func handle_attack():
	if (($Handle_Attack.global_position.x) - heroe.global_position.x < $Handle_Attack/CollisionShape2D.shape.extents.x * 0.8) && (($Handle_Attack.global_position.x) - heroe.global_position.x > -$Handle_Attack/CollisionShape2D.shape.extents.x * 0.8) && $RayCastVertical_3.get_collider() && ((self.get_position().y - heroe.get_position().y < 30) && (self.get_position().y - heroe.get_position().y > -30)) && $Mana_Enemy_1.value >= SPELLS_PARAMETERS.characters[name_character]["handle_attack"]["handle_attack_manacost"] && spells_ready["handle_attack_ready"]: 
		if $Sprite.get_animation()[0] != "A":
			manual_navigation = false
			var amount_animations_of_handle_attack = 0
			for i in range ($Sprite.get_sprite_frames().get_animation_names().size()):
				if $Sprite.get_sprite_frames().get_animation_names()[i].substr(2, $Sprite.get_sprite_frames().get_animation_names()[i].length() - 3) == "handle_attack":
					amount_animations_of_handle_attack += 1
			$Sprite.flip_h = self.global_position.x > heroe.global_position.x
			speed = 0
			creating_timer_for_calldown("handle_attack")
			spells_ready["handle_attack_ready"] = false
			if amount_animations_of_handle_attack > 0:
				var rand_sword = RandomNumberGenerator.new()
				rand_sword.randomize()
				animate("A_handle_attack" + str(rand_sword.randi_range(1, amount_animations_of_handle_attack)))
			else:
				animate("A_handle_attack")
			#if SPELLS_PARAMETERS.characters[name_character][$Sprite.get_animation().substr(2, $Sprite.get_animation().length())].has($Sprite.get_animation().substr(2, $Sprite.get_animation().length()) + "_thrust"):
			#	thrust(self, SPELLS_PARAMETERS.characters[name_character]["handle_attack"]["handle_attack_thrust"])
	
""" --------------------------------------------- """


""" --------------- SQUALL ATTACK --------------- """

func squall_attack(amount_attacks):
	#for i in range ($Sprite.frames.get_animation_names().size()):
	if (($Handle_Attack.global_position.x) - heroe.global_position.x < $Handle_Attack/CollisionShape2D.shape.extents.x * 0.8) && (($Handle_Attack.global_position.x) - heroe.global_position.x > -$Handle_Attack/CollisionShape2D.shape.extents.x * 0.8) && $RayCastVertical_3.get_collider() && ((self.get_position().y - heroe.get_position().y < 50) && (self.get_position().y - heroe.get_position().y > -50)) && $Mana_Enemy_1.value >= SPELLS_PARAMETERS.characters[name_character]["squall_attack"]["squall_attack_manacost"] && spells_ready["squall_attack_ready"]: 
		if $Sprite.get_animation()[0] != "A":
			manual_navigation = false
			if((self.global_position.x) - heroe.global_position.x) > 0:
				$Sprite.flip_h = true
			else:
				$Sprite.flip_h = false
			speed = 0
			creating_timer_for_calldown("squall_attack")
			mana_using(SPELLS_PARAMETERS.characters[name_character]["squall_attack"]["squall_attack_manacost"])
			spells_ready["squall_attack_ready"] = false
			amount_squall_attacks = amount_attacks
			animate("A_squall_attack")
			#print(SPELLS_PARAMETERS.characters[name_character][$Sprite.get_animation().substr(2, $Sprite.get_animation().length())].has($Sprite.get_animation().substr(2, $Sprite.get_animation().length()) + "_thrust"))
			


""" --------------------------------------------- """


""" --------------- JUMPING TO POINT --------------- """

func jumping_to_point(point_to_jump, zone_of_casting):
		if ((((self.global_position.x - heroe.global_position.x) < zone_of_casting) && ((self.global_position.x - heroe.global_position.x) > 23)) or (((self.global_position.x - heroe.global_position.x) > -zone_of_casting) && ((self.global_position.x - heroe.global_position.x) < -23))) && $RayCastVertical_3.get_collider() && ((self.get_position().y - heroe.get_position().y < 50) && (self.get_position().y - heroe.get_position().y > -50)) && $Mana_Enemy_1.value >= SPELLS_PARAMETERS.characters[name_character]["jumping_to_point"]["jumping_to_point_manacost"] && spells_ready["jumping_to_point_ready"]:
			j = 0
			velocity.y = -JUMP_POWER 
			manual_navigation = true
			animate("preparing_jumping_to_point")
			$NavigationAgent2D.set_target_location(point_to_jump)
			$NavigationAgent2D.get_final_location()
			creating_timer_for_calldown("jumping_to_point")
			nav_path = $NavigationAgent2D.get_nav_path()
			spells_ready["jumping_to_point_ready"] = false
			speed = abs(self.global_position.x - point_to_jump.x)/100 * 4
			scale_gravity = 2
			velocity.y += 0.016 * 970 * scale_gravity
			velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
			mana_using(SPELLS_PARAMETERS.characters[name_character]["jumping_to_point"]["jumping_to_point_manacost"])

	
""" --------------------------------------------- """


""" --------------- DAMAGE BLOCK CHAIN --------------- """

func chain(type_of_chain, targets_for_cast, zone_of_casting = null):
	if chains_ready[type_of_chain + "_chain_ready"] && targets_for_cast != []:
		for j in range(targets_for_cast.size() - 1):
			if targets_for_cast[j] == null:
				targets_for_cast.remove(j)
				j -= 1
		if zone_of_casting == null or ((((self.global_position.x - heroe.global_position.x) < zone_of_casting) && ((self.global_position.x - heroe.global_position.x) > 53)) or (((self.global_position.x - heroe.global_position.x) > -zone_of_casting) && ((self.global_position.x - heroe.global_position.x) < -53))) && $RayCastVertical_3.get_collider() && ((self.get_position().y - heroe.get_position().y < 50) && (self.get_position().y - heroe.get_position().y > -50)) && $Mana_Enemy_1.value >= SPELLS_PARAMETERS.characters[name_character][type_of_chain + "_chain"][type_of_chain + "_chain_manacost"] && chains_ready[type_of_chain + "_chain_ready"]:
			var timer_for_calldown = Timer.new()
			timer_for_calldown.set_wait_time(SPELLS_PARAMETERS.characters[name_character][type_of_chain + "_chain"][type_of_chain + "_chain_calldown"] + SPELLS_PARAMETERS.characters[name_character][type_of_chain + "_chain"][type_of_chain + "_chain_duration"])
			timer_for_calldown.connect("timeout", self, "_on_Chain_timeout", [timer_for_calldown, type_of_chain])
			timer_for_calldown.one_shot = true
			self.add_child(timer_for_calldown)
			timer_for_calldown.start()
			var index_of_required_target = 0
			var statusbar1 = statusbar.instance()
			var drop_of_consumption_health1 = drop_of_consumption_health.instance()
			match type_of_chain:
				"damage_block":
					if targets_for_cast.size() != 1:
						for j in range(targets_for_cast.size() - 1):
							if targets_for_cast[j].health > targets_for_cast[j+1].health:
								index_of_required_target = j + 1
					else:
						index_of_required_target = 0
					drop_for_consumption_helath(targets_for_cast[index_of_required_target], drop_of_consumption_health1, Color(0.0, 6.0, 0.0))
					targets_for_cast[index_of_required_target].armor_ordinary = SPELLS_PARAMETERS.characters[name_character]["damage_block_chain"]["damage_block_chain_fraction_absorbed_damage"]
				"damage_increase":
					if targets_for_cast.size() != 1:
						for j in range(targets_for_cast.size() - 1):
							if targets_for_cast[j].health < targets_for_cast[j+1].health:
								index_of_required_target = j + 1
					else:
						index_of_required_target = 0
					drop_for_consumption_helath(targets_for_cast[index_of_required_target], drop_of_consumption_health1)
					targets_for_cast[index_of_required_target].damage_increase = SPELLS_PARAMETERS.characters[name_character]["damage_increase_chain"]["damage_increase_chain_increase"]
				"cure":
					if targets_for_cast.size() != 1:
						for j in range(targets_for_cast.size() - 1):
							if targets_for_cast[j].health > targets_for_cast[j+1].health:
								index_of_required_target = j + 1
					else:
						index_of_required_target = 0
					drop_for_consumption_helath(targets_for_cast[index_of_required_target], drop_of_consumption_health1)
					targets_for_cast[index_of_required_target].regeneration_in_second = SPELLS_PARAMETERS.characters[name_character]["cure_chain"]["cure_chain_regeneration_in_second"]
			chains_ready[type_of_chain + "_chain_ready"] = false
			statusbar1.i = SPELLS_PARAMETERS.characters[name_character][type_of_chain + "_chain"][type_of_chain + "_chain_duration"]
			targets_for_cast[index_of_required_target].get_node("For_Status_Bars").add_child(statusbar1)
			if targets_for_cast[index_of_required_target] != self:
				var statusbar2 = statusbar.instance()
				statusbar2.i = SPELLS_PARAMETERS.characters[name_character][type_of_chain + "_chain"][type_of_chain + "_chain_duration"]
				self.get_node("For_Status_Bars").add_child(statusbar2)
			summary_health_or_mana_for_chain.append(0)
			var timer_for_consumption_mana_or_health_per_tick = Timer.new()
			timer_for_consumption_mana_or_health_per_tick.set_wait_time(0.2)
			timer_for_consumption_mana_or_health_per_tick.connect("timeout", self, "_on_timer_for_consumption_mana_or_health_timeout", [timer_for_consumption_mana_or_health_per_tick, type_of_chain, summary_health_or_mana_for_chain.size() - 1, targets_for_cast[index_of_required_target]])
			timer_for_consumption_mana_or_health_per_tick.one_shot = false
			self.add_child(timer_for_consumption_mana_or_health_per_tick)
			timer_for_consumption_mana_or_health_per_tick.start()

func _on_timer_for_consumption_mana_or_health_timeout(timer, type_of_chain, index_of_summary, target_to_cast):
	match type_of_chain:
		"damage_block":
			summary_health_or_mana_for_chain[index_of_summary] += SPELLS_PARAMETERS.characters[name_character]["damage_block_chain"]["damage_block_chain_health_in_second"] * 0.2
			if summary_health_or_mana_for_chain[index_of_summary] < SPELLS_PARAMETERS.characters[name_character]["damage_block_chain"]["damage_block_chain_duration"] * SPELLS_PARAMETERS.characters[name_character]["damage_block_chain"]["damage_block_chain_health_in_second"]:
				$HP_Enemy_1.value = $HP_Enemy_1.value - (SPELLS_PARAMETERS.characters[name_character]["damage_block_chain"]["damage_block_chain_health_in_second"] * 0.2)
				$value_of_HP.text = str($HP_Enemy_1.value)
			else:
				if target_to_cast.armor_ordinary - SPELLS_PARAMETERS.characters[name_character]["damage_block_chain"]["damage_block_chain_fraction_absorbed_damage"] >= 0:
					target_to_cast.armor_ordinary -= SPELLS_PARAMETERS.characters[name_character]["damage_block_chain"]["damage_block_chain_fraction_absorbed_damage"]
				else:
					target_to_cast.armor_ordinary = 0
				timer.queue_free()
		"damage_increase":
			summary_health_or_mana_for_chain[index_of_summary] += SPELLS_PARAMETERS.characters[name_character]["damage_block_chain"]["damage_block_chain_health_in_second"] * 0.2
			if summary_health_or_mana_for_chain[index_of_summary] < SPELLS_PARAMETERS.characters[name_character]["damage_block_chain"]["damage_block_chain_duration"] * SPELLS_PARAMETERS.characters[name_character]["damage_block_chain"]["damage_block_chain_health_in_second"]:
				$HP_Enemy_1.value = $HP_Enemy_1.value - (SPELLS_PARAMETERS.characters[name_character]["damage_block_chain"]["damage_block_chain_health_in_second"] * 0.2)
				$value_of_HP.text = str($HP_Enemy_1.value)
			else:
				target_to_cast.damage_increase -= SPELLS_PARAMETERS.characters[name_character]["damage_increase_chain"]["damage_increase_chain_increase"]
				timer.queue_free()
		"cure":
			summary_health_or_mana_for_chain[index_of_summary] += SPELLS_PARAMETERS.characters[name_character]["cure_chain"]["cure_chain_mana_in_second"] * 0.2
			if summary_health_or_mana_for_chain[index_of_summary] < SPELLS_PARAMETERS.characters[name_character]["cure_chain"]["cure_chain_duration"] * SPELLS_PARAMETERS.characters[name_character]["damage_block_chain"]["damage_block_chain_health_in_second"]:
				$Mana_Enemy_1.value = $Mana_Enemy_1.value - (SPELLS_PARAMETERS.characters[name_character]["cure_chain"]["cure_chain_mana_in_second"] * 0.2)
				$value_of_Mana.text = str($Mana_Enemy_1.value)
			else:
				target_to_cast.regeneration_in_second = 1
				timer.queue_free()

func _on_Chain_timeout(timer, type_of_chain):
	chains_ready[type_of_chain + "_chain_ready"] = true
	timer.queue_free()

func drop_for_consumption_helath(target, drop, color = null):
	target.array_for_dropping_consumption_health_animations.append(drop)
	if color != null:
		drop.get_node("AnimatedSprite").modulate = color
	if !target.has_node("Drop_For_Consumption_Helath"):
		target.add_child(drop)

""" --------------------------------------------- """


""" --------------- STONE WALL --------------- """

func stone_wall(position_of_wall, should_be_disappearence_after_time = true, parent_node = get_parent()):
	if spells_ready["stone_wall_ready"]:
		mana_using(SPELLS_PARAMETERS.characters[name_character]["stone_wall"]["stone_wall_manacost"])
		var stone_wall1 = stone_wall.instance()
		stone_wall1.name = "Stone_Wall" + str(self.global_position.x + parent_node.global_position.x)
		parent_node.add_child(stone_wall1)
		stone_wall1.set_global_position(position_of_wall)
		stone_wall1.get_node("AnimatedSprite").play("wall_growing")
		if parent_node.get_name() == "PositionsWalls":
			stone_wall1.get_node("AnimatedSprite").flip_h = (position_of_wall.x < parent_node.get_parent().global_position.x)
		if SPELLS_PARAMETERS.characters[name_character]["stone_wall"]["stone_wall_calldown"] > 0:
			creating_timer_for_calldown("jumping_to_point")
			spells_ready["stone_wall_ready"] = false
		if should_be_disappearence_after_time:
			var timer_for_disappearence_wall = Timer.new()
			timer_for_disappearence_wall.set_wait_time(SPELLS_PARAMETERS.characters[name_character]["stone_wall"]["time_to_disappearance_wall"])
			timer_for_disappearence_wall.connect("timeout", self, "_on_timer_for_disappearance_wall_timeout", [stone_wall1, timer_for_disappearence_wall])
			timer_for_disappearence_wall.one_shot = true
			self.add_child(timer_for_disappearence_wall)
			timer_for_disappearence_wall.start()
		

func _on_timer_for_disappearance_wall_timeout(stone_wall1, timer):
	stone_wall1.get_node("AnimatedSprite").play("wall_destruction")
	timer.queue_free()

""" --------------------------------------------- """


""" ------------------- PUSH ------------------- """

func push():
	#print("ibo")
	#print(speed)
	if spells_ready["push_ready"] == true:
		if $Mana_Enemy_1.value >= (SPELLS_PARAMETERS.characters[name_character]["push"]["push_manacost"] + SPELLS_PARAMETERS.characters[name_character]["armor"]["armor_manacost"]) && $Sprite.get_animation() != "A_push" && $Sprite.get_animation() != "A_push_preparing" && armor_ordinary == 1:
			$Sprite.flip_h = self.global_position > get_parent().get_node("Heroe").global_position
			animate("A_armor")
		if $Sprite.get_animation() != "A_push" && $Sprite.get_animation() != "A_armor" && $Mana_Enemy_1.value >= SPELLS_PARAMETERS.characters[name_character]["push"]["push_manacost"]:
			animate("A_push_preparing")
			$Sprite.flip_h = self.global_position > get_parent().get_node("Heroe").global_position
		if preparing_for_pushing_finished:
			special_physics_process_controlling = true
			animate("A_push")
			if !stop_pushing:
				translate(vector_push * SPELLS_PARAMETERS.characters[name_character]["push"]["push_speed"]) 
			else:
				special_physics_process_controlling = false
				spells_ready["push_ready"] = false
				get_node("Area_Pushing").set_monitoring(false)
				preparing_for_pushing_finished = false
				animate("idle")
	
func _on_Area_Pushing_body_entered(body):
	stop_pushing = true
	if body.has_method("start_jump_heroe"):
		body.handle_hit(SPELLS_PARAMETERS.characters[name_character]["push"]["damage_push"], self)
		body.stun(SPELLS_PARAMETERS.characters[name_character]["push"]["duration_push"])

func _on_timer_for_armor_duration_timeout(timer):
	if armor_ordinary - SPELLS_PARAMETERS.characters[name_character]["armor"]["fraction_absorbed_damage_armor_Adalard"] >= 0:
		armor_ordinary -= SPELLS_PARAMETERS.characters[name_character]["armor"]["fraction_absorbed_damage_armor_Adalard"]
	else: 
		armor_ordinary = 0
		
""" --------------------------------------------- """

func creating_timer_for_calldown(spell):
	var timer_for_calldown = Timer.new()
	timer_for_calldown.set_wait_time(SPELLS_PARAMETERS.characters[name_character][spell][spell + "_calldown"])
	timer_for_calldown.connect("timeout", self, "_on_timer_for_calldown_spells_timeout", [spell, timer_for_calldown])
	timer_for_calldown.one_shot = true
	self.add_child(timer_for_calldown)
	timer_for_calldown.start()

func _on_timer_for_calldown_spells_timeout(spell, timer):
	spells_ready[spell + "_ready"] = true
	timer.queue_free()

var t = 0
func _on_Sprite_animation_finished(by_stune = false):
	if !by_stune:
		if $Sprite.get_animation()[0] == "A":
			#print($Sprite.get_animation().split("_"))
			if $Sprite.get_animation().split("_")[1] == "handle":
				spells_ready["handle_attack_ready"] = true
				animate("idle")
				speed = 2.5
				mana_using(SPELLS_PARAMETERS.characters[name_character]["handle_attack"]["handle_attack_manacost"])
				$Handle_Attack/CollisionShape2D.set_disabled(false)
		match $Sprite.get_animation():
			"A_squall_attack":
				$Handle_Attack/CollisionShape2D.set_disabled(false)
				if amount_squall_attacks > t:
					$Sprite.set_frame(0)
					t += 1
				else:
					speed = 2.5
					t = 0
					animate("idle")
			"A_preparing_jumping_to_point":
				animate("jumping_to_point")
			"A_push_preparing":
				preparing_for_pushing_finished = true
				stop_pushing = false
				get_node("Area_Pushing").set_monitoring(true)
				mana_using(SPELLS_PARAMETERS.characters[name_character]["push"]["push_manacost"])
				creating_timer_for_calldown("push")
				match self.global_position < get_parent().get_node("Heroe").global_position:
					true: vector_push = Vector2(1,0)
					false: vector_push = Vector2(-1,0)
			"A_push":
				speed = 2.5
			"A_armor":
				armor_ordinary = SPELLS_PARAMETERS.characters[name_character]["armor"]["fraction_absorbed_damage_armor_Adalard"]
				mana_using(SPELLS_PARAMETERS.characters[name_character]["armor"]["manacost_armor_Adalard"])
				animate("A_push_preparing")
				speed = 2.5
				var timer_for_duration_armor = Timer.new()
				timer_for_duration_armor.set_wait_time(SPELLS_PARAMETERS.characters[name_character]["armor"]["armo_duration"])
				timer_for_duration_armor.connect("timeout", self, "_on_timer_for_armor_duration_timeout", [timer_for_duration_armor])
				timer_for_duration_armor.one_shot = true
				self.add_child(timer_for_duration_armor)
				timer_for_duration_armor.start()
	else:
		if $Sprite.get_animation()[0] == "A":
			if $Sprite.get_animation().split("_")[1] == "handle":
				spells_ready["handle_attack_ready"] = true
				animate("idle")
				speed = 2.5
		match $Sprite.get_animation():
			"A_squall_attack":
				t = 0
				animate("idle")
			"A_preparing_jumping_to_point":
				animate("idle")
			"A_push_preparing":
				special_physics_process_controlling = false
				creating_timer_for_calldown("push")
				animate("idle")
			"A_push":
				special_physics_process_controlling = false
				spells_ready["push_ready"] = false
				animate("idle")
				speed = 2.5
			"A_armor":
				animate("idle")
				speed = 2.5
	



func animate(art):
	$Sprite.play(art)

func _on_VisibilityNotifier2D_screen_exited():
	if get_parent().has_method("First_Scene") && GLOBAL.first_cat_scene:
		print("wqpijedapwidj")
		queue_free()


func _on_NavigationAgent2D_path_changed():
	#$NavigationAgent2D.set_target_location(get_parent().get_node("Heroe").global_position)
	#$NavigationAgent2D.get_final_location()
	pass
	j = 0


func _on_Timer_For_Updaiting_Way_timeout():
	update_way()
			
			
			
func update_way():
	if current_target != null:
		$NavigationAgent2D.set_target_location(current_target)
		$NavigationAgent2D.get_final_location()
		nav_path = $NavigationAgent2D.get_nav_path()
		j = 0


func _on_Area_For_Starting_Fight_body_entered(body):
	if body.has_method("start_jump_heroe") && !get_parent().has_node("Fight_Scene"):
		if !body.in_invisibility:
			GLOBAL.enemy_for_fight = name_character
			GLOBAL.position_heroe_before_fight = get_parent().get_node("Heroe").global_position
			GLOBAL.scene(LOCATIONS_PARAMETERS.locations[get_parent().get_name()]["enemies_fight_scenes"][name_character])

func stun(duration):
	_on_Sprite_animation_finished(true)
	var statusbar1 = statusbar.instance()
	if stun == true:
		if duration > $Timers/Timer_Of_Stun.time_left:
			stun = true
			statusbar1.i = duration
			$Timers/Timer_Of_Stun.set_wait_time(duration)
			$Timers/Timer_Of_Stun.start()
	else:
		statusbar1.i = duration
		get_node("For_Status_Bars").add_child(statusbar1)
		stun = true
		$Timers/Timer_Of_Stun.set_wait_time(duration)
		$Timers/Timer_Of_Stun.start()
	
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
	timer.connect("timeout", self, "_on_timer_slowdown_timeout", [scale_speed, timer])
	timer.start()
	
	
func _on_timer_slowdown_timeout(scale_speed, timer):
	if scale_speed_moving + scale_speed < 1:
		scale_speed_moving += scale_speed
	else:
		scale_speed_moving = 1
	timer.queue_free()
	
func _on_Timer_Of_Stun_timeout():
	stun = false


func _on_Timer_For_Stop_Machine_timeout():
	stop_machine = false
	speed = 2.5


func _on_Timer_For_Going_Back_timeout():
	pass # Replace with function body.
	
func thrust(body, shift):
	translate(Vector2(-1,0) * shift * abs(self.global_position.x - body.global_position.x))


