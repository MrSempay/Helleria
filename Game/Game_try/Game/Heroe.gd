extends KinematicBody2D

var name_character = "Heroe"

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
var armor = 1
var defense = 1


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
	get_node("Buttons_Of_Heroe/Button_Second/RichTextLabel").set_text(str(amount_arrows))
	GLOBAL.move_vector_1 = Vector2(0, 0)
	if get_parent().has_method("Temple_lvl") && get_parent().has_node("Ghost"):
		$Camera_Of_Heroe._set_current(false)
	
	file.open("res://Navigations/Heroe/navigationH1D.txt", File.READ)
	#file.open("res://Navigations/Jeison/navigation1.txt", File.WRITE)
	
	#timer_of_spell.connect("timeout", self, "_Timer_Of_Spell")
	#timer_of_spell.set_autostart(true)


func _physics_process(delta):
	
	if Input.is_action_pressed("jump") && !get_parent().has_node("Ghost"):
		start_jump_heroe()
	
	
	get_node("Stone_Sword/CollisionShape2D").set_disabled(true)
	
	
	if get_parent().has_method("First_Scene"):
		if GLOBAL.first_cat_scene:
			if self.get_global_position().x > 2228:
				$Icon.flip_h = true
				translate(Vector2(-1,0) * speed)
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
	if ($Icon.get_animation() == "idle" or $Icon.get_animation() == "run"):
		speed = 2.5
		translate(GLOBAL.move_vector_1 * speed)
		velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
	if !file.is_open() && !GLOBAL.first_cat_scene && ($Icon.get_animation() == "idle" or $Icon.get_animation() == "run"):
		if GLOBAL.move_vector_1.x != 0:
			animate("run")
		if GLOBAL.move_vector_1.x == 0:
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
		elif GLOBAL.move_vector_1.x < 0:
			$Stone_Sword.set_position(Vector2(-26, 3))
			$Position_Arrow.set_position(Vector2(-22, 4))
			$Ray_Cast_Column.set_cast_to(Vector2(-274, 0))
			$Ray_Cast_Random_Spell.set_position(Vector2(-133, -181))
			$Icon.flip_h = true
			if get_parent().has_node("Door"):
				if !get_parent().get_node("Door").get_animation() == "idle_heroe":
					get_node("CollisionPolygon2D/AnimationPlayer").play("щгп")


	#point_of_position = self.get_global_position()
	#mass_of_positions.append(point_of_position)
	#file.store_line(str(mass_of_positions[i]))
	#i = i + 1

func start_jump_heroe():
	if is_on_floor():
		velocity.y = -JUMP_POWER 



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
	


func _on_CanvasLayer_use_move_vector(move_vector):
	pass


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
			$Icon.play("idle")
		"bow":
			$Icon.play("idle")


func _on_Button_First_pressed():
	if !$Icon.get_animation() == "stone_sword":
		animate("stone_sword")
		mana_using(10)


func _on_Button_Second_pressed():
	if !$Icon.get_animation() == "bow":
		animate("bow")
		if amount_arrows == 5:
			mana_using(10)
		amount_arrows -= 1
		get_node("Buttons_Of_Heroe/Button_Second/RichTextLabel").set_text(str(amount_arrows))
		if amount_arrows == 0:
			get_node("Buttons_Of_Heroe/Button_Second").set_disabled(true)
			get_node("Buttons_Of_Heroe/Button_Second/Timer_Of_Bow").start()


func _on_Button_Third_pressed():
	if $Ray_Cast_Column.get_collider():
		if $Ray_Cast_Column.get_collider().has_method("enemy"):
			$Icon.play("сolumn")
			mana_using(25)
			var column_1 = column.instance()
			column_1.position = $Ray_Cast_Column.get_collider().global_position - Vector2(0, -16)
			get_parent().add_child(column_1)
			get_node("Buttons_Of_Heroe/Button_Third").set_disabled(true)
			get_node("Buttons_Of_Heroe/Button_Third/Timer_Of_Column").start()
	if $Ray_Cast_Random_Spell.get_collider() && !get_parent().has_node("Column"):
			$Icon.play("сolumn")
			mana_using(25)
			var column_1 = column.instance()
			column_1.position = $Ray_Cast_Random_Spell.get_collision_point()
			get_parent().add_child(column_1)
			get_node("Buttons_Of_Heroe/Button_Third").set_disabled(true)
			get_node("Buttons_Of_Heroe/Button_Third/Timer_Of_Column").start()
	
			
func _on_Stone_Sword_body_entered(body: Node2D):
	if body.has_method("handle_hit") && body.has_method("enemy"):
		body.handle_hit(damage_stone_sword)


func _on_Timer_Of_Bow_timeout():
	get_node("Buttons_Of_Heroe/Button_Second").set_disabled(false)
	amount_arrows = 5


func _on_Timer_Of_Column_timeout():
	get_node("Buttons_Of_Heroe/Button_Third").set_disabled(false)
