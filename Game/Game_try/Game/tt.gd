extends KinematicBody2D

var grav = 1940
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if self.is_on_floor():
		grav = 0
		velocity.y += delta * grav
		velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
	else:
		velocity.y += delta * 20 * 2
		velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
