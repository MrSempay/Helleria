extends KinematicBody2D


var speed = 140
var velocity = Vector2()
var name_enemy = "Aglea"
var trigger_of_ally = false
var dialoge_window = preload("res://Game/Dialoge_Window.tscn")
var JUMP_POWER = 500

var array_first_dialoge_flags = [1,2,3,5,7,9,10,11,13,15]
var i = 0

var file = File.new()

var point_of_position_string
var point_of_position_string_x
var point_of_position_string_x_saved = -10000
var point_of_position_string_y
var point_of_position_string_y_saved



onready var heroe = get_parent().get_node("Heroe")
onready var ally = get_parent().get_node("Ally")
onready var area_of_dialoge_camera = get_parent().get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")

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


func _ready():
	file.open("res://Navigations/Aglea/navigationA1D.txt", File.READ)



func _physics_process(delta):
	
	if file.is_open() && !get_parent().has_node("Heroe"):
		if file.get_position() < file.get_len():
			
			animate("run")
			point_of_position_string = file.get_line().split(",",true,1)
			point_of_position_string_x = ((point_of_position_string[0].split("(",false,1)))
			point_of_position_string_y = ((point_of_position_string[1].split(")",true,1)))
			if point_of_position_string_x_saved < float(point_of_position_string_x[0]):
				$Sprite.flip_h = false
			else:
				$Sprite.flip_h = true
			self.set_global_position(Vector2(float(point_of_position_string_x[0]),float(point_of_position_string_y[0])))
			point_of_position_string_x_saved = float(point_of_position_string_x[0])
		elif file.is_open():
			file.close()
			animate("idle")
			GLOBAL.first_dialoge_started = true
	
	
	if i != (array_first_dialoge_flags.size() - 1):
		if area_of_dialoge_camera.input_touch == array_first_dialoge_flags[i] && area_of_dialoge_camera.was_pressed:
			var dialoge_window_1 = dialoge_window.instance()
			print(array_first_dialoge_flags[i])
			dialoge_window_1.position = $Dialoge_Window_Position.position + Vector2(0,-20)
			if array_first_dialoge_flags[i] - array_first_dialoge_flags[i - 1] == 1 && self.has_node("Dialoge_Window"):
				print(area_of_dialoge_camera.input_touch)
				$Dialoge_Window.choosing_text("Aglea", area_of_dialoge_camera.input_touch)
				area_of_dialoge_camera.was_pressed = false
			else:
				add_child(dialoge_window_1)
				dialoge_window_1.choosing_text("Aglea", area_of_dialoge_camera.input_touch)
				area_of_dialoge_camera.was_pressed = false
			if i != (array_first_dialoge_flags.size() - 1):
				i += 1
	
				
	if (area_of_dialoge_camera.input_touch != array_first_dialoge_flags[i]) && area_of_dialoge_camera.was_pressed && self.has_node("Dialoge_Window"):
		print("deleted")
		$Dialoge_Window.queue_free()

	if get_parent().has_node("Heroe"):
		if trigger_of_ally:
		
			if abs((self.global_position.x - 0) - ally.global_position.x) < abs((self.global_position.x) - heroe.global_position.x):
				$Sprite.flip_h = true
			
			if ((self.global_position.x) - heroe.global_position.x < 35) && ((self.global_position.x) - heroe.global_position.x > -35):
				$Sprite.flip_h = (self.global_position.x) - heroe.global_position.x > 0
				speed = 0
				animate("idle")
			else:
				$Sprite.flip_h = (self.global_position.x) - heroe.global_position.x > 0
				speed = 140
				animate("run")
			if ((self.global_position.x) - heroe.global_position.x < 0):
				velocity.x = speed * delta
				translate(velocity)
			if (self.global_position.x) - heroe.global_position.x > 0:
				velocity.x = speed * delta
				translate(-velocity)
			
	velocity.y += delta * FOR_ANY_UNITES.GRAVITY * 2
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
	if get_parent().has_node("Heroe"):
		var heroe = get_parent().get_node("Heroe")
		var ally = get_parent().get_node("Ally")
		if abs((self.global_position.x - 0) - ally.global_position.x) > abs((self.global_position.x) - heroe.global_position.x):
			$Sprite.flip_h = false
		elif abs((self.global_position.x - 0) - ally.global_position.x) < abs((self.global_position.x) - heroe.global_position.x):
			$Sprite.flip_h = true
	$Sprite.play(art)

