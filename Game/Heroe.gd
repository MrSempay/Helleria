extends KinematicBody2D


onready var joystick = get_node("../Joystick/TouchScreenButton")
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


var Arrow = load("res://Game/Arrow.gd")
var velocity = Vector2()
var sheld_position
var bow_position
var JUMP_POWER = 700
var Button = load("res://Game/Button_attack.gd")
var texture = preload("res://Icedeath.jpg")
var Button1 = Button.new()
var speed = 150
var armor = 1

var picture_sheld = preload("res://pngwing.com (13).png")
var picture_bow = preload("res://Bow.png")
var picture_word = preload("res://pngwing.com (13).png")
var picture_stone_sword = preload("res://Attack.png")

var array_arrows = []
var arrow = Arrow.new()
var defense = 1
var beat_in_heroe = false


func ally():
	pass


func handle_hit(damage, damage_save = 0):
	if !weapon.beat_in_sheld && beat_in_heroe:
		damage = damage_save
	beat_in_heroe = true
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
	#if GLOBAL.counter_of_second_button == 1:
	timer_of_spell.connect("timeout", self, "_Timer_Of_Spell")
	timer_of_spell.set_autostart(true)
	

func _physics_process(delta):
	move_and_slide(GLOBAL.move_vector_1 * speed)
	velocity.y += delta * FOR_ANY_UNITES.GRAVITY * 2
	velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)

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


func start_jump():
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
	$Icon.flip_h = move_vector.x < 0
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
	
