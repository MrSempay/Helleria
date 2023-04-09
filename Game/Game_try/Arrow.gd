extends Area2D

var velocity = Vector2()
var vector = 0


func _ready():
	if get_parent().get_node("Icon").is_flipped_h():
		vector = -1
		$Sprite.flip_h = true
	else: 
		vector = 1
		$Sprite.flip_h = false


func _physics_process(delta):

	velocity.x = SPELLS_PARAMETERS.speed_arrow_Heroe * delta * vector
	translate(velocity)


func _on_Arrow_body_entered(body):
	if body.has_method("handle_hit") && body.has_method("enemy"):
		body.handle_hit(SPELLS_PARAMETERS.damage_bow_Heroe)
		queue_free()
	if !body.has_method("ally"):
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
