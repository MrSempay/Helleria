extends KinematicBody2D


var speed = 140
var velocity = Vector2()
var name_enemy = "Enemy 3"
var trigger_of_ally = false
var stone = preload("res://Game/Stone_Enemy.tscn")
var hedgehod = preload("res://Game/Hedgehod+.tscn")
var stone_ready = true
var hedgehod_ready = true
var stone_sword_ready = true
var stone_finished = false
var stone_sword_finished = false
var hedgehod_finished = false
var sprite_position = Vector2(67,0)
var damage_stone_sword = 10


onready var stone_position = get_node("Weapon/Stone_Position/")
onready var timer_of_stone = get_node("Timer_Stone")
onready var timer_of_stone_sword = get_node("Timer_Stone_Sword")
onready var timer_of_hedgehod = get_node("Timer_Hedgehod")
onready var collision_of_stone_sword = get_node("Stone_Sword/CollisionShape2D")


func _ready():
	pass


func handle_hit(damage):
	#health -= damage
	$HP_Enemy_1.value -= damage
	$value_of_HP.text = str($HP_Enemy_1.value)
	if $HP_Enemy_1.value > 0:
		print(name_enemy + " was hit! Health of enemy: ", $HP_Enemy_1.value)
	else:
		print(name_enemy + " was destroyed")
		GLOBAL.life_first_enemy = false
		queue_free()


func mana_using(manacost):
	$Mana_Enemy_1.value -= manacost
	$value_of_Mana.text = str($Mana_Enemy_1.value)


func _physics_process(delta):
	
	var heroe = get_parent().get_node("Heroe")
	var ally = get_parent().get_node("Ally")
	
	collision_of_stone_sword.set_disabled(true)
	print($Sprite.get_animation())
	if(self.global_position.x - heroe.global_position.x) > 0:
		$Stone_Sword.set_position(Vector2(-33,-6))
	else:
		$Stone_Sword.set_position(Vector2(33,-6))
		
	#$CollisionShape2D.set_position(Vector2(0,0))
	if trigger_of_ally:
	
		"""if abs((self.global_position.x - 0) - ally.global_position.x) < abs((self.global_position.x) - heroe.global_position.x):
			$Sprite.flip_h = true
			if $Sprite.get_animation() == "stone":
				$Sprite.set_position(sprite_position)"""
		
		if ((self.global_position.x) - heroe.global_position.x < 55) && ((self.global_position.x) - heroe.global_position.x > -55) && $Sprite.get_animation() != "stone" && $Sprite.get_animation() != "stoneSword" && $Sprite.get_animation() != "hedgehod":
			if((self.global_position.x) - heroe.global_position.x) > 0:
				$Sprite.flip_h = true
			else:
				$Sprite.flip_h = false
			#animate("idle")
		elif $Sprite.get_animation() == "idle":# && $Sprite.get_animation() != "stoneSword" && $Sprite.get_animation() != "hedgehod":
			speed = 140
			if((self.global_position.x) - heroe.global_position.x) > 0:
				$Sprite.flip_h = true
			else:
				$Sprite.flip_h = false
			animate("run")
			$Sprite.set_position(Vector2(0,0))
		if ((self.global_position.x) - heroe.global_position.x < 52) && (self.global_position.x - heroe.global_position.x > -52):
				if ($Sprite.get_animation() == "idle" or $Sprite.get_animation() == "run") && stone_sword_ready:
					if((self.global_position.x) - heroe.global_position.x) > 0:
						$Sprite.flip_h = true
						$Sprite.set_position(Vector2(-23,-13))
					else:
						$Sprite.flip_h = false
						$Sprite.set_position(Vector2(23,-13))
					speed = 0
					timer_of_stone_sword.start()
					stone_sword_ready = false
					animate("stoneSword")
				if stone_sword_finished == true:
					collision_of_stone_sword.set_disabled(false)
					if((self.global_position.x) - heroe.global_position.x) > 0:
						$Sprite.flip_h = true
					else:
						$Sprite.flip_h = false
					animate("idle")
					$Sprite.set_position(Vector2(0,0))
					stone_sword_finished = false

		if ((((self.global_position.x - heroe.global_position.x) < 800) && ((self.global_position.x - heroe.global_position.x) > 53)) or (((self.global_position.x - heroe.global_position.x) > -800) && ((self.global_position.x - heroe.global_position.x) < -53))):
				if ($Sprite.get_animation() == "idle" or $Sprite.get_animation() == "run") && stone_ready:
					sprite_position = Vector2(67,0)
					if((self.global_position.x) - heroe.global_position.x) > 0:
						$Sprite.flip_h = true
						$Stone_Position.set_position(Vector2(-34,-2))
						$Sprite.set_position(-sprite_position)
					else:
						$Sprite.flip_h = false
						$Stone_Position.set_position(Vector2(34,-2))
						$Sprite.set_position(sprite_position)
					timer_of_stone.start()
					speed = 0
					stone_ready = false
					animate("stone")
				if stone_finished == true:
					var stone_1 = stone.instance()
					stone_1.position = $Stone_Position.position
					add_child(stone_1)
					sprite_position = Vector2(0,0)
					$Sprite.set_position(sprite_position)
					if((self.global_position.x) - heroe.global_position.x) > 0:
						$Sprite.flip_h = true
					else:
						$Sprite.flip_h = false
					animate("idle")
					stone_finished = false
		#print($Sprite.get_animation())
		if ((((self.global_position.x - heroe.global_position.x) < 800) && ((self.global_position.x - heroe.global_position.x) > 53)) or (((self.global_position.x - heroe.global_position.x) > -800) && ((self.global_position.x - heroe.global_position.x) < -53))):
				if ($Sprite.get_animation() == "idle" or $Sprite.get_animation() == "run") && hedgehod_ready:
					if((self.global_position.x) - heroe.global_position.x) > 0:
						$Sprite.flip_h = true
					else:
						$Sprite.flip_h = false
					timer_of_hedgehod.start()
					speed = 0
					hedgehod_ready = false
					animate("hedgehod")
					var hedgehod_1 = hedgehod.instance()
					hedgehod_1.position = heroe.global_position - Vector2(1577, 1495)#heroe.get_position() - Vector2(0,-80))
					add_child(hedgehod_1)
				if hedgehod_finished == true:
					if((self.global_position.x) - heroe.global_position.x) > 0:
						$Sprite.flip_h = true
					else:
						$Sprite.flip_h = false
					animate("idle")
					stone_finished = false
		
		if ((self.global_position.x) - heroe.global_position.x < 0):
			velocity.y = 0
			velocity.x = speed * delta
			translate(velocity)
		if (self.global_position.x) - heroe.global_position.x > 0:
			velocity.y = 0
			velocity.x = speed * delta
			translate(-velocity)
	else:
		$Sprite.set_position(Vector2(0,0))
		animate("idle")
		
	#$CollisionShape2D.set_position(Vector2(0,0))
	velocity.y += delta * 970 * 2
	velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)


func _on_Timer_Of_HP_timeout():
	$value_of_HP.text = str($HP_Enemy_1.value)
	$HP_Enemy_1.value += 1

	
func _on_Timer_Of_Mana_timeout():
	$value_of_Mana.text = str($Mana_Enemy_1.value)
	$Mana_Enemy_1.value += 1


func _on_Trigger_Area_body_entered(body):
	if body.has_method("ally"):
		trigger_of_ally = true
		
		
func animate(art):
	var heroe = get_parent().get_node("Heroe")
	var ally = get_parent().get_node("Ally")
	"""
	if abs((self.global_position.x - 0) - ally.global_position.x) > abs((self.global_position.x) - heroe.global_position.x):
		$Sprite.flip_h = false
	elif abs((self.global_position.x - 0) - ally.global_position.x) < abs((self.global_position.x) - heroe.global_position.x):
		$Sprite.flip_h = true
	"""
	$Sprite.play(art)


func _on_Sprite_animation_finished():
	if $Sprite.get_animation() == "stone":
		stone_finished = true
		animate("idle")
		$Sprite.set_position(Vector2(0,0))
	if $Sprite.get_animation() == "stoneSword":
		stone_sword_finished = true
		animate("idle")
		$Sprite.set_position(Vector2(0,0))
	if $Sprite.get_animation() == "hedgehod":
		hedgehod_finished = true
		animate("idle")
		$Sprite.set_position(Vector2(0,0))


func _on_Stone_Sword_body_entered(body: Node2D):
	if body.has_method("handle_hit") && body.has_method("start_jump"):
		body.handle_hit(damage_stone_sword)

func _on_Timer_Stone_timeout():
	stone_ready = true


func _on_Timer_Stone_Sword_timeout():
	stone_sword_ready = true



func _on_Timer_Hedgehod_timeout():
	hedgehod_ready = true
