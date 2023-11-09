extends Area2D


var damage_arrow = 5
var SPEED = 500
var velocity = Vector2()
var vector = 0


func _ready():
	vector = GLOBAL.vector_of_moving


func _physics_process(delta):
	if GLOBAL.vector_of_moving >= 0:
		velocity.x = SPEED * delta * vector
		translate(velocity)
	else:
		velocity.x = SPEED * delta * vector
		translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Arrow_body_entered(body: Node) -> void:
	if body.has_method("handle_hit") && !body.has_method("start_jump"):
		body.handle_hit(damage_arrow, get_parent().get_node("Heroe"), self)
	if !body.has_method("start_jump"):
		queue_free()
	pass
