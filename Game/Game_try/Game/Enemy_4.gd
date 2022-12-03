extends KinematicBody2D


var speed = 140
var velocity = Vector2()
var name_enemy = "Enemy 4"
var trigger_of_ally = false


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
	if trigger_of_ally:
	
		if abs((self.global_position.x - 0) - ally.global_position.x) < abs((self.global_position.x) - heroe.global_position.x):
			$Sprite.flip_h = true
			print(true)
		
		
		
		if ((self.global_position.x) - heroe.global_position.x < 125) && ((self.global_position.x) - heroe.global_position.x > -135):
			speed = 0
		else:
			speed = 140
		if ((self.global_position.x) - heroe.global_position.x < 0):
			velocity.y = 0
			velocity.x = speed * delta
			translate(velocity)
		if (self.global_position.x) - heroe.global_position.x > 0:
			velocity.y = 0
			velocity.x = speed * delta
			translate(-velocity)

	velocity.y += delta * FOR_ANY_UNITES.GRAVITY * 2
	velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
	$Sprite.flip_h = (self.global_position.x) - heroe.global_position.x > 0



func _on_Timer_Of_HP_timeout():
	$value_of_HP.text = str($HP_Enemy_1.value)
	$HP_Enemy_1.value += 1

	
func _on_Timer_Of_Mana_timeout():
	$value_of_Mana.text = str($Mana_Enemy_1.value)
	$Mana_Enemy_1.value += 1


func _on_Trigger_Area_body_entered(body):
	if body.has_method("ally"):
		trigger_of_ally = true
