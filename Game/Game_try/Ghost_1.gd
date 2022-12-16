extends KinematicBody2D


onready var anim_1 = get_node("CollisionPolygon2D/AnimationPlayer")

var scale_gravity = 2
var velocity = Vector2()
var name_character = "Ghost"


func _ready():
	pass 



func _physics_process(delta):
	velocity.x = 0
	translate(GLOBAL.move_vector_1_ghost * 2.5)
	#velocity.y += delta * 970 * 2
	velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
	
	if GLOBAL.move_vector_1_ghost.x != 0:
		animate("run")
	if GLOBAL.move_vector_1_ghost.x == 0:
		animate("idle")
	if GLOBAL.move_vector_1_ghost.x > 0:
		$Sprite.flip_h = false
	elif GLOBAL.move_vector_1_ghost.x < 0:
		$Sprite.flip_h = true
		
		
	
func animate(art):
	$Sprite.play(art)


func _on_Area2D_body_entered(body):
	if body.has_method("start_jump_heroe"):
		body.get_node("Camera_Of_Heroe")._set_current(true)
		queue_free()
