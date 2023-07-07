extends KinematicBody2D

var name_character = "Heroe"

onready var anim_1 = get_node("CollisionPolygon2D/AnimationPlayer")
onready var joystick_new = $CanvasLayer
#onready var area_of_dialoge_camera = get_parent().get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")

var statusbar = preload("res://Game/Spells/BarDuration.tscn")
var array_of_slowdowns = []
var stun = false
var manacost_stone_sword = 10
var manacost_arrow = 10
var manacost_column = 35
var amount_arrows = 5
var damage_stone_sword = 10
var scale_gravity = 2
var arrow = preload("res://Game/Spells/Arrow.tscn")
var column = preload("res://Game/Spells/Column.tscn")
var velocity = Vector2()
var JUMP_POWER = 500
var Button = load("res://Game/Button_attack.gd")
var texture = preload("res://Icedeath.jpg")
var Button1 = Button.new()
var speed = 2.5
var scale_speed_moving = 0
var armor = 1
var defense = 1
var counter_of_stone_sword = 0
var saving_current_animation_of_stone_sword
var in_invisibility = false
var amount_status_bars = []

var file = File.new()
var mass_of_positions = []
var point_of_position = Vector2()

var dialoge_window = preload("res://Game/Dialoge_Window.tscn")
var array_dialoge_flags = []
var i = 0
var number_of_dialoge

var point_of_position_string
var point_of_position_string_x
var point_of_position_string_x_saved = -10000
var point_of_position_string_y
var point_of_position_string_y_saved
var moving_state
var number_of_moving

func ally():
	pass


func handle_hit(damage, damage_save = 0):
	print(damage)
	$HP_Heroe.value -= damage * armor * defense
	$value_of_HP.text = str($HP_Heroe.value)
	if $HP_Heroe.value > 0:
		print("You were hit! Your health: ", $HP_Heroe.value)
	else:
		GLOBAL.life_heroe = false
		print("You died")
		queue_free()
		
		
func mana_using(manacost):
	$Mana_Heroe.value -= manacost
	$value_of_Mana.text = str($Mana_Heroe.value)
	

func _ready():
	$HP_Heroe.max_value = SPELLS_PARAMETERS.HP_Heroe
	$HP_Heroe.value = SPELLS_PARAMETERS.HP_Heroe
	$value_of_HP.text = str($HP_Heroe.value)
	
	$Mana_Heroe.max_value = SPELLS_PARAMETERS.mana_Heroe
	$Mana_Heroe.value = SPELLS_PARAMETERS.mana_Heroe
	$value_of_Mana.text = str($Mana_Heroe.value)
	
	
	get_node("Buttons_Of_Heroe/Button_Second/RichTextLabel").set_text(str(amount_arrows))
	GLOBAL.move_vector_1 = Vector2(0, 0)
	if get_parent().has_method("Temple_lvl") && get_parent().has_node("Ghost"):
		$Camera_Of_Heroe._set_current(false)
	
	file.open("res://Navigations/Heroe/navigationH1D.txt", File.READ)
	#file.open("res://Navigations/Jeison/navigation1.txt", File.WRITE)
	
	#timer_of_spell.connect("timeout", self, "_Timer_Of_Spell")
	#timer_of_spell.set_autostart(true)


func _physics_process(delta):

	match $Icon.get_animation():
		"idle":
			#$RayCastForFloor.set_enabled(true)
			speed = 2.5
			$Icon.set_speed_scale(1)
		"run":
			#$RayCastForFloor.set_enabled(true)
			$Icon.set_speed_scale(1)
		"bow":
			$Icon.set_speed_scale(SPELLS_PARAMETERS.scale_animation_speed_bow_Heroe)
		"stone_sword":
			$Icon.set_speed_scale(SPELLS_PARAMETERS.scale_animation_speed_swrod_Heroe)
		"stone_sword_1":
			$Icon.set_speed_scale(SPELLS_PARAMETERS.scale_animation_speed_swrod_Heroe)
		"stone_sword_2":
			$Icon.set_speed_scale(SPELLS_PARAMETERS.scale_animation_speed_swrod_Heroe)
		"column":
			$Icon.set_speed_scale(SPELLS_PARAMETERS.scale_animation_speed_column_Heroe)
		"jump":
			$Icon.set_speed_scale(1)
		"injured":
			$Icon.set_speed_scale(1)
		"door_opening":
			$Icon.set_speed_scale(1)
			

	if $RayCastForFloor.get_collider() && $Icon.get_animation() == "jump" or stun:
		$Icon.play("idle")


	if Input.is_action_pressed("jump") && !get_parent().has_node("Ghost") && !in_invisibility && !stun or $Jumping_Button.jumping == true:
		start_jump_heroe()
	
	
	get_node("Stone_Sword/CollisionShape2D").set_disabled(true)
	
	
	if get_parent().has_method("First_Scene"):
		if GLOBAL.first_cat_scene:
			if self.get_global_position().x > 2228:
				$Icon.flip_h = true
				translate(Vector2(-1,0) * speed * scale_speed_moving)
				get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
				animate("injured")
			elif self.get_global_position().x < 2228:
				animate("door_opening")
				if $Icon.get_frame() == 4:
					get_parent().get_node("Door").play("door")
				if $Icon.get_frame() > 6:
					translate(Vector2(-1, 0) * 0.283)

	match $Icon.get_animation():
		"stone_sword":
			speed = 0
			if $Icon.get_frame() == 14:
				get_node("Stone_Sword/CollisionShape2D").set_disabled(false)
		"stone_sword_1":
			speed = 0
			if $Icon.get_frame() == 14:
				get_node("Stone_Sword/CollisionShape2D").set_disabled(false)
		"stone_sword_2":
			speed = 0
			if $Icon.get_frame() == 6:
				get_node("Stone_Sword/CollisionShape2D").set_disabled(false)
		"bow":
			speed = 0
			if $Icon.get_frame() == 17 && !self.has_node("Arrow"):
				var arrow_1 = arrow.instance()
				arrow_1.position = $Position_Arrow.position
				add_child(arrow_1)
		"сolumn":
			speed = 0
			if $Icon.get_frame() == 6:
				$Icon.play("idle")

	if GLOBAL.heroe_dialoge_started:
		dialoge(array_dialoge_flags, number_of_dialoge)

	
	if moving_state:
		navigation(number_of_moving)
	
	
	velocity.x = 0
	velocity.y += delta * 970 * 2
	velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
	#if ($Icon.get_animation() == "idle" or $Icon.get_animation() == "run") && !in_invisibility:
	if !file.is_open() && !GLOBAL.first_cat_scene && ($Icon.get_animation() == "idle" or $Icon.get_animation() == "run" or $Icon.get_animation() == "jump") && !in_invisibility && !stun:
		translate(GLOBAL.move_vector_1 * speed)
		if GLOBAL.move_vector_1.x != 0:
			if $Icon.get_animation() != "jump":
				animate("run")
		if GLOBAL.move_vector_1.x == 0:
			if $Icon.get_animation() != "jump":
				animate("idle")
		if GLOBAL.move_vector_1.x > 0:
			$Stone_Sword.set_position(Vector2(26, 3))
			$Position_Arrow.set_position(Vector2(22, 4))
			$Ray_Cast_Column.set_cast_to(Vector2(274, 0))
			$Ray_Cast_Random_Spell.set_position(Vector2(133, -181))
			$Icon.flip_h = false
			if get_parent().has_node("Door"):
				if !get_parent().get_node("Door").get_animation() == "idle_heroe":
					get_node("CollisionPolygon2D/AnimationPlayer").play("щгп_п")
					pass
		elif GLOBAL.move_vector_1.x < 0:
			$Stone_Sword.set_position(Vector2(-26, 3))
			$Position_Arrow.set_position(Vector2(-22, 4))
			$Ray_Cast_Column.set_cast_to(Vector2(-274, 0))
			$Ray_Cast_Random_Spell.set_position(Vector2(-133, -181))
			$Icon.flip_h = true
			if get_parent().has_node("Door"):
				if !get_parent().get_node("Door").get_animation() == "idle_heroe":
					get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
					pass


	#point_of_position = self.get_global_position()
	#mass_of_positions.append(point_of_position)
	#file.store_line(str(mass_of_positions[i]))
	#i = i + 1

func start_jump_heroe():
	if is_on_floor():
		velocity.y = -JUMP_POWER 
		$Icon.play("jump")



func _on_CanvasLayer_use_move_vector(move_vector):
	pass


func _on_Timer_Of_HP_timeout():
	$value_of_HP.text = str($HP_Heroe.value)
	$HP_Heroe.value += 1


func _on_Timer_Of_Mana_timeout():
	$value_of_Mana.text = str($Mana_Heroe.value)
	$Mana_Heroe.value += 2
	
	
	
	
func get_position_x():
	return int(self.get_position().x)
	
	
func animate(art):
	$Icon.play(art)
	
	
	
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
					$Icon.flip_h = false
				else:
					$Icon.flip_h = true
				match number_of_moving:
					1: pass
	
				
			self.set_global_position(Vector2(float(point_of_position_string_x[0]),float(point_of_position_string_y[0]) + 3))
			point_of_position_string_x_saved = float(point_of_position_string_x[0])
		elif file.is_open():
			moving_state = false
			file.close()
			animate("idle")
			scale_gravity = 2
			match number_of_moving:
				1: queue_free()
			match number_of_dialoge:
				1: pass
				

func dialoge(array_dialoge_flags, number_of_dialoge):
	var area_of_dialoge_camera = get_parent().get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")
	#print(array_dialoge_flags[i])
	#print(area_of_dialoge_camera.input_touch)
	if array_dialoge_flags.size() != 0:
		if $Icon.is_flipped_h():
			$Dialoge_Window_Position.set_position(Vector2(-10,-42))
		else:
			$Dialoge_Window_Position.set_position(Vector2(10,-42))
			
		if array_dialoge_flags[i] == 1:
			var dialoge_window_1 = dialoge_window.instance()
			dialoge_window_1.position = $Dialoge_Window_Position.position
			add_child(dialoge_window_1)
			$Dialoge_Window.choosing_text(name_character, 1, number_of_dialoge)
			area_of_dialoge_camera.was_pressed_4 = false
			area_of_dialoge_camera.input_touch += 1
			if i != (array_dialoge_flags.size() - 1):
					i += 1
					
		if i != (array_dialoge_flags.size() - 1):
			if area_of_dialoge_camera.input_touch == array_dialoge_flags[i] && area_of_dialoge_camera.was_pressed_4:
				var dialoge_window_1 = dialoge_window.instance()
				dialoge_window_1.position = $Dialoge_Window_Position.position
				if array_dialoge_flags[i] - array_dialoge_flags[i - 1] == 1 && self.has_node("Dialoge_Window"):
					$Dialoge_Window.choosing_text(name_character, area_of_dialoge_camera.input_touch, number_of_dialoge)
					area_of_dialoge_camera.was_pressed_4 = false
				else:
					add_child(dialoge_window_1)
					dialoge_window_1.choosing_text(name_character, area_of_dialoge_camera.input_touch, number_of_dialoge)
					area_of_dialoge_camera.was_pressed_4 = false
				if i != (array_dialoge_flags.size() - 1):
					i += 1
					
		if (area_of_dialoge_camera.input_touch != array_dialoge_flags[i]) && area_of_dialoge_camera.was_pressed_4 && self.has_node("Dialoge_Window"):
			if i == (array_dialoge_flags.size() - 1):
				match number_of_dialoge:
					1:
						GLOBAL.heroe_dialoge_finished = true
						GLOBAL.heroe_dialoge_started = false
						get_node("Camera_Of_Heroe")._set_current(true)
			$Dialoge_Window.queue_free()
	
	
	
func _on_Icon_animation_finished():
	match $Icon.get_animation():
		"door_opening":
			if get_parent().has_method("First_Scene"):
				if GLOBAL.first_cat_scene:
					pass
			self.queue_free()
		"stone_sword":
			get_node("Buttons_Of_Heroe/Button_First").set_disabled(false)
			$Icon.play("idle")
			get_node("Buttons_Of_Heroe/Button_First/Timer_Of_First_Animation_Sword").start()
			speed = 2.5
		"stone_sword_1":
			get_node("Buttons_Of_Heroe/Button_First").set_disabled(false)
			$Icon.play("idle")
			speed = 2.5
		"stone_sword_2":
			get_node("Buttons_Of_Heroe/Button_First").set_disabled(false)
			$Icon.play("idle")
			speed = 2.5
		"bow":
			get_node("Buttons_Of_Heroe/Button_First").set_disabled(false)
			$Icon.play("idle")
			speed = 2.5
		"column":
			get_node("Buttons_Of_Heroe/Button_First").set_disabled(false)
			speed = 2.5



func _on_Button_First_pressed():
	if !stun:
		if $RayCastForFloor.get_collider() && $Mana_Heroe.value > SPELLS_PARAMETERS.manacost_stone_sword_Heroe:
			counter_of_stone_sword += 1
			if !$Icon.get_animation() == "stone_sword" && !$Icon.get_animation() == "stone_sword_1" && !$Icon.get_animation() == "stone_sword_2":
				mana_using(SPELLS_PARAMETERS.manacost_stone_sword_Heroe)
				match counter_of_stone_sword:
					1:
						animate("stone_sword")
						get_node("Buttons_Of_Heroe/Button_First").set_disabled(true)
						saving_current_animation_of_stone_sword = 1
					2:
						animate("stone_sword_1")
						get_node("Buttons_Of_Heroe/Button_First").set_disabled(true)
						saving_current_animation_of_stone_sword = 2
					3:
						get_node("Buttons_Of_Heroe/Button_First").set_disabled(true)
						counter_of_stone_sword = 0
						animate("stone_sword_2")


func _on_Button_Second_pressed():
	if !stun:
		if $RayCastForFloor.get_collider() && $Mana_Heroe.value > SPELLS_PARAMETERS.manacost_bow_Heroe:
			if !$Icon.get_animation() == "bow":
				animate("bow")
				if SPELLS_PARAMETERS.amount_arrow_Heroe == 5:
					mana_using(SPELLS_PARAMETERS.manacost_bow_Heroe)
				SPELLS_PARAMETERS.amount_arrow_Heroe -= 1
				get_node("Buttons_Of_Heroe/Button_Second/RichTextLabel").set_text(str(SPELLS_PARAMETERS.amount_arrow_Heroe))
				if SPELLS_PARAMETERS.amount_arrow_Heroe == 0:
					get_node("Buttons_Of_Heroe/Button_Second").set_disabled(true)
					get_node("Buttons_Of_Heroe/Button_Second/Timer_Of_Bow").start()


func _on_Button_Third_pressed():
	get_node("Buttons_Of_Heroe/Button_First").set_disabled(false)
	if !stun:
		if $RayCastForFloor.get_collider() && $Mana_Heroe.value > SPELLS_PARAMETERS.manacost_column_Heroe:
			if $Ray_Cast_Column.get_collider():
				if $Ray_Cast_Column.get_collider().has_method("enemy"):
					$Icon.play("сolumn")
					mana_using(SPELLS_PARAMETERS.manacost_column_Heroe)
					var column_1 = column.instance()
					column_1.global_position = $Ray_Cast_Column.get_collider().global_position - Vector2(0, -16)
					get_parent().add_child(column_1)
					get_node("Buttons_Of_Heroe/Button_Third").set_disabled(true)
					get_node("Buttons_Of_Heroe/Button_Third/Timer_Of_Column").set_wait_time(SPELLS_PARAMETERS.calldown_column_Heroe)
					get_node("Buttons_Of_Heroe/Button_Third/Timer_Of_Column").start()
			if $Ray_Cast_Random_Spell.get_collider() && !get_parent().has_node("Column"):
					$Icon.play("сolumn")
					mana_using(SPELLS_PARAMETERS.manacost_column_Heroe)
					var column_1 = column.instance()
					column_1.position = $Ray_Cast_Random_Spell.get_collision_point()
					get_parent().add_child(column_1)
					get_node("Buttons_Of_Heroe/Button_Third").set_disabled(true)
					get_node("Buttons_Of_Heroe/Button_Third/Timer_Of_Column").start()
	
			
func _on_Stone_Sword_body_entered(body: Node2D):
	if body.has_method("handle_hit") && body.has_method("enemy"):
		body.handle_hit(SPELLS_PARAMETERS.damage_stone_sword_Heroe)


func _on_Timer_Of_Bow_timeout():
	get_node("Buttons_Of_Heroe/Button_Second").set_disabled(false)
	SPELLS_PARAMETERS.amount_arrow_Heroe = 5


func _on_Timer_Of_Column_timeout():
	get_node("Buttons_Of_Heroe/Button_Third").set_disabled(false)


func _on_Timer_Of_First_Animation_Sword_timeout():
	if saving_current_animation_of_stone_sword == counter_of_stone_sword:
		counter_of_stone_sword = 0

func stun(duration):
	if stun == true:
		if duration > $Timer_Of_Stun.time_left:
			$Timer_Of_Stun.start()
			$Timer_Of_Stun.set_wait_time(duration)
	else:
		stun = true
		$Timer_Of_Stun.start()
		$Timer_Of_Stun.set_wait_time(duration)
	
func slowdown(scale_speed, duration):
	var statusbar1 = statusbar.instance()
	get_parent().get_node("For_Status_Bars").add_child(statusbar1)
	statusbar1.i = duration
	if scale_speed_moving > scale_speed:
		scale_speed_moving -= scale_speed
	else:
		scale_speed_moving = 0
	var timer = Timer.new()
	timer.wait_time = duration
	timer.connect("timeout", self, "_on_timer_timeout", scale_speed, timer)
	timer.start
	
	
func _on_timer_timeout(scale_speed, timer):
	if scale_speed_moving + scale_speed < 1:
		scale_speed_moving += scale_speed
	else:
		scale_speed_moving = 1
	timer.queue_free()
	


func _on_Timer_Of_Stun_timeout():
	stun = false


		
