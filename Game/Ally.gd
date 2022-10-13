extends KinematicBody2D

var speed = 150
var velocity = Vector2()
var outgo_area = false
var enter_area = false
var name_ally = "Ally"


func ally():
	pass


func handle_hit(damage):
	#health -= damage
	$HP_Ally.value -= damage
	$value_of_HP.text = str($HP_Ally.value)
	if $HP_Ally.value > 0:
		print(name_ally + " was hit! Health of enemy: ", $HP_Ally.value)
	else:
		print(name_ally + " was destroyed")
		queue_free()


func mana_using(manacost):
	$Mana_Ally.value -= manacost
	$value_of_Mana.text = str($Mana_Ally.value)


func _ready():
	var heroe = get_parent().get_node("Heroe")
	var heroe_icon = get_parent().get_node("Heroe/Icon")

func _physics_process(delta):
	var heroe = get_parent().get_node("Heroe")
	var heroe_icon = get_parent().get_node("Heroe/Icon")
	
	if outgo_area && $Sprite.flip_h != heroe_icon.flip_h:
		move_and_slide(GLOBAL.move_vector_1 * speed)

	velocity.y += delta * FOR_ANY_UNITES.GRAVITY * 2
	velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
	$Sprite.flip_h = (self.global_position.x) - heroe.global_position.x < 0


func _on_Timer_Of_HP_timeout():
	$value_of_HP.text = str($HP_Ally.value)
	$HP_Ally.value += 1

	
func _on_Timer_Of_Mana_timeout():
	$value_of_Mana.text = str($Mana_Ally.value)
	$Mana_Ally.value += 1


func _on_Area2D_body_exited(body: Node):
	if body.has_method("start_jump"):
		enter_area = false
		outgo_area = true


func _on_Area2D_body_entered(body: Node):
	if body.has_method("start_jump"):
		enter_area = true
		outgo_area = false


