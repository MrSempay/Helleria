extends KinematicBody2D



var scale_gravity = 2
var velocity = Vector2()
var name_character = "Ghost"
var animation_finished = false

func _ready():
	pass 



func _physics_process(delta):

	if !$Sprite.get_animation() == "moves_in":
		velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
		velocity.x = 0
		translate(GLOBAL.move_vector_1_ghost * 1.5)
		if GLOBAL.move_vector_1_ghost.x != 0:
			animate("run")
		if GLOBAL.move_vector_1_ghost.x == 0:
			animate("idle")
		if GLOBAL.move_vector_1_ghost.x > 0:
			$Sprite.flip_h = false
		elif GLOBAL.move_vector_1_ghost.x < 0:
			$Sprite.flip_h = true
			
	if animation_finished:
		get_parent().get_node("Camera_For_Speaking")._set_current(true)
		get_parent().get_node("Imaginary_Heroe/Sprite").set_visible(true)
		GLOBAL.heroe_dialoge_started = true
		GLOBAL.imaginary_heroe_dialoge_started = true
		queue_free()
		
	
func animate(art):
	$Sprite.play(art)


func _on_Area2D_body_entered(body):
	if body.has_method("start_jump_heroe"):
		if get_parent().get_node("Heroe").get_global_position().x - self.get_global_position().x < 0:
			$Sprite.flip_h = true
		elif get_parent().get_node("Heroe").get_global_position().x - self.get_global_position().x > 0:
			$Sprite.flip_h = false
		$Sprite.play("moves_in")

func _on_Sprite_animation_finished():
	if $Sprite.get_animation() == "moves_in":
		animation_finished = true

