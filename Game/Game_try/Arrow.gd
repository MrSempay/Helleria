extends Area2D

var damage_arrow = 10
var SPEED = 200
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

	velocity.x = SPEED * delta * vector
	translate(velocity)


func _on_Arrow_body_entered(body):
	if body.has_method("handle_hit") && body.has_method("enemy"):
		body.handle_hit(damage_arrow)
		queue_free()
	if !body.has_method("ally"):
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
