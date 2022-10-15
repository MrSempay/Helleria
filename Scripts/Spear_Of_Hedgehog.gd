extends Area2D


var stop_moving = false
var SPEED = 500
var velocity = Vector2()


func _physics_process(delta):
	if !stop_moving:
		velocity.y = SPEED * delta
		velocity.x = SPEED * delta
		translate(-velocity)




func _on_Area2D_area_exited(area: Area2D):
	stop_moving = true




func _on_Area2D_body_entered(body: Node):
		if body.has_method("handle_hit") && !body.has_method("start_jump"):
			body.handle_hit(get_parent().damage_hedgehod)
