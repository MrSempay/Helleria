extends KinematicBody2D


onready var anim_1 = get_node("CollisionPolygon2D/AnimationPlayer")
onready var weapon = $Weapon
onready var joystick_new = $CanvasLayer
onready var dialoge = $Control2
onready var next = get_node("Sprite/Next")
onready var dialoge_phrase = get_node("Control2/TextureRect/RichTextLabel")
onready var variable = get_node("Sprite/Control")
onready var variable_1 = get_node("Sprite/Control/Button")
onready var variable_2 = get_node("Sprite/Control/Button2")
onready var enemy = get_node("../Enemy_Main")
onready var button_first = get_node("../Sprite/Button_First")
onready var button_second = get_node("../Sprite/Button_Second")
onready var button_third = get_node("../Sprite/Button_Third")
onready var timer_of_spell = $Timer_Of_Spell
onready var picture_weapon = get_node("Weapon/Sword")
onready var count_of_arrow = get_node("Weapon/value_of_HP/Arrow_Amount")
onready var stone_position = get_node("Weapon/Position2D/")
onready var area_of_dialoge_camera = get_parent().get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")



var scale_gravity = 2
var Arrow = load("res://Game/Arrow.gd")
var velocity = Vector2()
var sheld_position
var bow_position
var JUMP_POWER = 500
var Button = load("res://Game/Button_attack.gd")
var texture = preload("res://Icedeath.jpg")
var Button1 = Button.new()
var speed = 2
var armor = 1
var name_character = "Heroe"

var picture_sheld = preload("res://pngwing.com (13).png")
var picture_bow = preload("res://Bow.png")
var picture_word = preload("res://pngwing.com (13).png")
var picture_stone_sword = preload("res://Attack.png")

var array_arrows = []
var arrow = Arrow.new()
var defense = 1
var beat_in_heroe = false

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
	beat_in_heroe = true
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
	
	if get_parent().has_method("Temple_lvl"):
		$Camera_Of_Heroe._set_current(false)
	
	file.open("res://Navigations/Heroe/navigationH1D.txt", File.READ)
	#file.open("res://Navigations/Jeison/navigation1.txt", File.WRITE)
	
	timer_of_spell.connect("timeout", self, "_Timer_Of_Spell")
	timer_of_spell.set_autostart(true)

func _physics_process(delta):
	
	if get_parent().has_method("First_Scene"):
		if get_parent().first_cat_scene:
			if self.get_global_position().x > 2225:
				$Icon.flip_h = true
				translate(Vector2(-1,0) * speed)
				get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")
				animate("injured")
			elif self.get_global_position().x < 2225:
				animate("door_opening")
				if $Icon.get_frame() == 4:
					get_parent().get_node("Door").play("door")
				if $Icon.get_frame() > 6:
					translate(Vector2(-1, 0) * 0.283)

	if GLOBAL.heroe_dialoge_started:
		dialoge(array_dialoge_flags, number_of_dialoge)

	
	if moving_state:
		navigation(number_of_moving)
	
	
	velocity.x = 0
	translate(GLOBAL.move_vector_1 * 2.5)
	velocity.y += delta * 970 * 2
	velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
	if !file.is_open() && !get_parent().has_method("First_Scene"):
		if GLOBAL.move_vector_1.x != 0:
			animate("run")
		if GLOBAL.move_vector_1.x == 0:
			animate("idle")
		if GLOBAL.move_vector_1.x > 0:
			$Icon.flip_h = false
			get_node("CollisionPolygon2D/AnimationPlayer").play("щгп_п")
		elif GLOBAL.move_vector_1.x < 0:
			$Icon.flip_h = true
			get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")


	#point_of_position = self.get_global_position()
	#mass_of_positions.append(point_of_position)
	#file.store_line(str(mass_of_positions[i]))
	#i = i + 1
	match GLOBAL.spell_of_button:
			"body_seal": 
				pass
				
			"sheld":
				if GLOBAL.vector_of_moving > 0:
						sheld_position = Vector2(30, -170)
						picture_weapon.set_position(sheld_position)
						picture_weapon.set_rotation_degrees(0)
						picture_weapon.set_texture(picture_sheld)
				elif GLOBAL.vector_of_moving < 0:
						sheld_position = Vector2(-250, -170)
						picture_weapon.set_position(sheld_position)
						picture_weapon.set_rotation_degrees(0)
						picture_weapon.set_texture(picture_sheld)
			"bow":
					if GLOBAL.vector_of_moving > 0:
						bow_position = Vector2(0, 0)
						picture_weapon.set_position(bow_position)
						picture_weapon.set_rotation_degrees(-140)
						picture_weapon.set_texture(picture_bow)
						picture_weapon.set_visible(true)
					elif GLOBAL.vector_of_moving < 0:
						bow_position = Vector2(-170, -170)
						picture_weapon.set_rotation_degrees(40)
						picture_weapon.set_position(bow_position)
						picture_weapon.set_texture(picture_bow)
						picture_weapon.set_visible(true)


func start_jump_heroe():
	if is_on_floor():
		velocity.y = -JUMP_POWER 


func _on_Next_pressed():
	GLOBAL.counter_of_phrase += 1
	if GLOBAL.life_first_enemy:
		if GLOBAL.counter_of_phrase%2 == 0:
			dialoge.visible = visible
		else:
			dialoge.visible = not visible
		match GLOBAL.counter_of_phrase:
			4:
				 dialoge_phrase.set_text("Ha-ha... Are you kidding me?")
			6: 
				variable_1.set_disabled(false)
				variable_2.set_disabled(false)
				variable.set_visible(true)
				dialoge_phrase.set_text("")
				next.set_disabled(true)
			8: 
				if GLOBAL.variable_1:
					dialoge_phrase.set_text("I will give you all that I have! Don't beat me please!")
				if GLOBAL.variable_2:
					dialoge_phrase.set_text("What have you said? Come to me, I will make you mine slave!")
	else:
		GLOBAL.counter_of_phrase = 10
	if GLOBAL.counter_of_phrase == 10:
		next.set_disabled(true)
		next.visible = false
		dialoge.queue_free()
		
		
func _on_Button_pressed():
	dialoge_phrase.set_text("I will give you money... :(")
	next.set_disabled(false)
	GLOBAL.variable_1 = true
	variable.queue_free()


func _on_Button2_pressed():
	dialoge_phrase.set_text("You are so weak... Right now I will just break your face.")
	next.set_disabled(false)
	GLOBAL.variable_2 = true
	variable.queue_free()
	

func _on_Button_First_pressed():
	GLOBAL.counter_of_first_button += 1
	match GLOBAL.stone:
		1:
			GLOBAL.counter_of_bow += 1
			GLOBAL.spell_of_button = "bow"
			weapon.visible = visible
			defense = 1
			if GLOBAL.counter_of_first_button > 0:
					GLOBAL.counter_of_third_button = 0
		2:
			GLOBAL.spell_of_button = "stone_sword"


func _on_Button_Second_pressed():
	GLOBAL.counter_of_second_button += 1
	match GLOBAL.stone:
		1:
			GLOBAL.spell_of_button = "body_seal"
			if GLOBAL.counter_of_second_button%2 != 0:
				speed = 190
				JUMP_POWER = 900
				armor = 1.5
				
			else:
				armor = 1
				speed = 150
				JUMP_POWER = 700
		2:
			GLOBAL.spell_of_button = "stone"
			GLOBAL.counter_of_stone += 1
		

func _on_Button_Third_pressed():
	GLOBAL.counter_of_third_button += 1
	match GLOBAL.stone:
		1:
			GLOBAL.spell_of_button = "sheld"
			if GLOBAL.counter_of_third_button%2 != 0:
				weapon.visible = visible
				#defense = 0
				array_arrows.resize(10)
				GLOBAL.counter_of_first_button = 0
				picture_weapon.set_visible(true)
				#for i in range(10):
				#	array_arrows[int(i)] = arrow
				#	print(array_arrows[int(i)].number)
					#print(array_arrows[int(i)])
			else:
				picture_weapon.set_visible(false)
				#defense = 1
		2:
			GLOBAL.spell_of_button = "hedgehod"
			GLOBAL.counter_of_hedgehod += 1

	
func _on_Timer_Of_Spell_timeout():
	GLOBAL.time_out_of_body_seal = true



func _on_CanvasLayer_use_move_vector(move_vector):
	"""$Icon.flip_h = move_vector.x < 0"""
	var stone_position_1 = Vector2()
	if move_vector.x < 0:
		stone_position_1 = Vector2(-221, -68)
		stone_position.set_position(stone_position_1)
		GLOBAL.vector_of_moving = -1
	else:
		stone_position_1 = Vector2(-60, -68)
		stone_position.set_position(stone_position_1)
		GLOBAL.vector_of_moving = 1


func _on_Timer_Of_HP_timeout():
	$value_of_HP.text = str($HP_Heroe.value)
	$HP_Heroe.value += 1


func _on_Timer_Of_Mana_timeout():
	$value_of_Mana.text = str($Mana_Heroe.value)
	$Mana_Heroe.value += 1
	
	
	
	
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
			area_of_dialoge_camera.was_pressed_1 = false
			area_of_dialoge_camera.input_touch += 1
			if i != (array_dialoge_flags.size() - 1):
					i += 1
		
		if i != (array_dialoge_flags.size() - 1):
			if area_of_dialoge_camera.input_touch == array_dialoge_flags[i] && area_of_dialoge_camera.was_pressed_1:
				var dialoge_window_1 = dialoge_window.instance()
				dialoge_window_1.position = $Dialoge_Window_Position.position
				if array_dialoge_flags[i] - array_dialoge_flags[i - 1] == 1 && self.has_node("Dialoge_Window"):
					$Dialoge_Window.choosing_text(name_character, area_of_dialoge_camera.input_touch, number_of_dialoge)
					area_of_dialoge_camera.was_pressed_1 = false
				else:
					add_child(dialoge_window_1)
					dialoge_window_1.choosing_text(name_character, area_of_dialoge_camera.input_touch, number_of_dialoge)
					area_of_dialoge_camera.was_pressed_1 = false
				if i != (array_dialoge_flags.size() - 1):
					i += 1
					
		if (area_of_dialoge_camera.input_touch != array_dialoge_flags[i]) && area_of_dialoge_camera.was_pressed_1 && self.has_node("Dialoge_Window"):
			if i == (array_dialoge_flags.size() - 1):
				match number_of_dialoge:
					1:
						#get_parent().get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera/CollisionShape2D").set_disabled(true)
						GLOBAL.heroe_dialoge_finished = true
						GLOBAL.heroe_dialoge_started = false
						get_node("Camera_Of_Heroe")._set_current(true)
			$Dialoge_Window.queue_free()
	
	
	
func _on_Icon_animation_finished():
	if $Icon.get_animation() == "door_opening":
		if get_parent().has_method("First_Scene"):
			if get_parent().first_cat_scene:
				get_parent().first_cat_scene = false
		self.queue_free()
