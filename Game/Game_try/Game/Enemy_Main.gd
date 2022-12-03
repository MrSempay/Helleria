extends KinematicBody2D


onready var anim = $AnimationPlayer
onready var anim_2 = $AnimationPlayer2
onready var dialoge = $Control1
onready var dialoge_time = $Timer_Of_Dialoge
onready var dialoge_phrase = get_node("Control1/TextureRect/RichTextLabel")
#onready var next = get_node("../Heroe/Sprite/Next")
onready var weapon_enemy = $Weapon_Enemy


var speed = 400
var angular_speed = PI
var velocity_1 = Vector2()
var first = true
var second = true
var anim_2_finished = false
var animation_start = false


func Suka():
	var variable1 = false
	var variable2 = false



func _ready():
	pass


func _physics_process(delta):
	if GLOBAL.heroe_uploaded:
		var heroe = get_parent().get_node("Heroe")
		var heroe_icon = get_parent().get_node("Heroe/Icon")
		var next = get_parent().get_node("Heroe/Sprite/Next")
	"""
	rotation += angular_speed * delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
	"""
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1

	rotation += angular_speed * direction * delta

	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed

	position += velocity * delta
	if !anim.is_playing():
		velocity_1.y += delta * FOR_ANY_UNITES.GRAVITY
		velocity_1 = move_and_slide(velocity_1, FOR_ANY_UNITES.FLOOR)
	"""
	if !anim.is_playing() && GLOBAL.counter_of_phrase == 1:
		dialoge.visible = visible
		first = false 
	"""
	if animation_start:
		if anim_2.current_animation_position > 0.39 && GLOBAL.life_heroe == true:
			animation_start = false
			weapon_enemy.attack()
		#print(anim_2.current_animation_position)
		
		

func handle_hit(damage):
	#health -= damage
	$HP_Enemy_1.value -= damage
	if $HP_Enemy_1.value > 0:
		print("Enemy was hit! Health of enemy: ", $HP_Enemy_1.value)
	else:
		print("Enemy was destroyed")
		GLOBAL.life_first_enemy = false
		queue_free()


func _on_Timer_timeout():
	$value_of_HP.text = str($HP_Enemy_1.value)
	$HP_Enemy_1.value += 1


func _on_Next_pressed():
	if GLOBAL.counter_of_phrase%2 == 0:
		dialoge.visible = not visible
	else: 
		dialoge.visible = visible
		match GLOBAL.counter_of_phrase:
			3: 
				dialoge_phrase.set_text("If you not give me money, I will fight you!")
			5: 
				dialoge_phrase.set_text("No, I'm going to destroy you! But if you give me your money, I let you go")
			7: 
				if GLOBAL.variable_1:
					dialoge_phrase.set_text("That's good! Come to me and give me money")
				if GLOBAL.variable_2:
					dialoge_phrase.set_text("Oh... I will make you crying...")
			9: 
				if GLOBAL.variable_1:
					dialoge_phrase.set_text("Good decision, good, you saved your life!")
				if GLOBAL.variable_2:
					dialoge_phrase.set_text("Ahahahaha!!! O maeva mou shindeiru...")
					anim_2.play("Animation_Of_Attack")
					animation_start = true



func _on_AnimationPlayer_animation_finished(anim_name):
	dialoge.visible = visible


func _on_VisibilityNotifier2D_screen_exited():
	var next = get_parent().get_node("Heroe/Sprite/Next")
	next.visible = not visible
	next.set_disabled(true)
	pass

func _on_VisibilityNotifier2D_screen_entered():
	var next = get_parent().get_node("Heroe/Sprite/Next")
	next.visible = visible
	next.set_disabled(false)
	pass
