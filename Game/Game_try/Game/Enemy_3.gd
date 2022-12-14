extends KinematicBody2D


var speed = 2
var velocity = Vector2()
var name_character = "Belotur"
var trigger_of_ally = false
var stone = preload("res://Game/Spells/Stone_Enemy.tscn")
var hedgehod = preload("res://Game/Spells/Hedgehod+.tscn")
var stone_ready = true
var hedgehod_ready = true
var stone_sword_ready = true
var stone_finished = false
var stone_sword_finished = false
var hedgehod_finished = false
var sprite_position = Vector2(67,0)
var damage_stone_sword = 10
var JUMP_POWER = 500


onready var collision_of_jumping_area = get_node("Area_Of_Jumping/CollisionShape2D")
onready var timer_of_stone = get_node("Timer_Stone")
onready var timer_of_stone_sword = get_node("Timer_Stone_Sword")
onready var timer_of_hedgehod = get_node("Timer_Hedgehod")
onready var collision_of_stone_sword = get_node("Stone_Sword/CollisionShape2D")
onready var area_of_dialoge_camera = get_parent().get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")

var dialoge_window = preload("res://Game/Dialoge_Window.tscn")
var array_dialoge_flags = []
var i = 0
var number_of_dialoge
var scale_gravity = 2

var file = File.new()
var point_of_position_string
var point_of_position_string_x
var point_of_position_string_x_saved = -10000
var point_of_position_string_y
var point_of_position_string_y_saved
var moving_state
var number_of_moving

func _ready():
	pass


func enemy():
	pass


func handle_hit(damage):
	#health -= damage
	$HP_Enemy_1.value -= damage
	$value_of_HP.text = str($HP_Enemy_1.value)
	if $HP_Enemy_1.value > 0:
		print(name_character + " was hit! Health of enemy: ", $HP_Enemy_1.value)
	else:
		print(name_character + " was destroyed")
		GLOBAL.life_first_enemy = false
		queue_free()


func mana_using(manacost):
	$Mana_Enemy_1.value -= manacost
	$value_of_Mana.text = str($Mana_Enemy_1.value)

#test_move()
func _physics_process(delta):
	velocity.x = 0


	if is_on_floor():
		collision_of_jumping_area.set_disabled(false)
	else:
		collision_of_jumping_area.set_disabled(true)
	
	if moving_state:
		navigation(number_of_moving)
	
	if GLOBAL.belotur_dialoge_started && !GLOBAL.belotur_dialoge_finished:
		dialoge(array_dialoge_flags, number_of_dialoge)
	if GLOBAL.belotur_dialoge_finished && GLOBAL.first_cat_scene:
		if get_parent().has_method("First_Scene"):
				translate(Vector2(1,0) * 2)
				get_node("CollisionPolygon2D/AnimationPlayer").play("??????")
				animate("run")
				$Sprite.flip_h = true
	
	velocity.y += delta * 970 * scale_gravity
	velocity = move_and_slide(velocity, FOR_ANY_UNITES.FLOOR)
	
	
	collision_of_stone_sword.set_disabled(true)

	if get_parent().has_node("Heroe"):
		var heroe = get_parent().get_node("Heroe")
		var ally = get_parent().get_node("Ally")
		if trigger_of_ally:
			if(self.global_position.x - heroe.global_position.x) > 0:
				$Stone_Sword.set_position(Vector2(-33,-6))
				$Stone_Position.set_position(Vector2(-34,-2))
			else:
				$Stone_Sword.set_position(Vector2(33,-6))
				$Stone_Position.set_position(Vector2(34,-2))
			
			if ((self.global_position.x) - heroe.global_position.x < 0) && $Sprite.get_animation() == "run":
				translate(Vector2(1,0) * speed)
				get_node("CollisionPolygon2D/AnimationPlayer").play("??????")

			if ((self.global_position.x) - heroe.global_position.x > 0) && $Sprite.get_animation() == "run":
				translate(Vector2(-1,0) * speed)
				get_node("CollisionPolygon2D/AnimationPlayer").play("??????")
			
			if (((self.global_position.x) - heroe.global_position.x > 55) or ((self.global_position.x) - heroe.global_position.x < -55) or !((self.get_position().y - heroe.get_position().y < 20) && (self.get_position().y - heroe.get_position().y > -20))) && $Sprite.get_animation() != "stone" && $Sprite.get_animation() != "stoneSword" && $Sprite.get_animation() != "hedgehod":
				if((self.global_position.x) - heroe.global_position.x) > 0:
					get_node("CollisionPolygon2D/AnimationPlayer").play("??????")
					$Sprite.flip_h = true
				else:
					get_node("CollisionPolygon2D/AnimationPlayer").play("??????")
					$Sprite.flip_h = false
				speed = 2
				animate("run")
			if get_parent().has_method("Fight_Scene"):
				if ((self.global_position.x) - heroe.global_position.x < 52) && (self.global_position.x - heroe.global_position.x > -52) && is_on_floor() && ((self.get_position().y - heroe.get_position().y < 20) && (self.get_position().y - heroe.get_position().y > -20)):
					if((self.global_position.x) - heroe.global_position.x) > 0:
						$Sprite.flip_h = true
					else:
						$Sprite.flip_h = false
					speed = 0
					timer_of_stone_sword.start()
					stone_sword_ready = false
					animate("stoneSword")
				if stone_sword_finished:
					collision_of_stone_sword.set_disabled(false)
					stone_sword_finished = false
					
				if ((((self.global_position.x - heroe.global_position.x) < 800) && ((self.global_position.x - heroe.global_position.x) > 53)) or (((self.global_position.x - heroe.global_position.x) > -800) && ((self.global_position.x - heroe.global_position.x) < -53))) && stone_ready && is_on_floor() && ((self.get_position().y - heroe.get_position().y < 20) && (self.get_position().y - heroe.get_position().y > -20)):
					if $Sprite.get_animation() != "stoneSword" && $Sprite.get_animation() != "hedgehod":
						if((self.global_position.x) - heroe.global_position.x) > 0:
							$Sprite.flip_h = true
						else:
							$Sprite.flip_h = false
						timer_of_stone.start()
						speed = 0
						stone_ready = false
						animate("stone")
						var stone_1 = stone.instance()
						stone_1.position = $Stone_Position.global_position
						get_node("..").add_child(stone_1)
						stone_finished = true
							
				if ((((self.global_position.x - heroe.global_position.x) < 800) && ((self.global_position.x - heroe.global_position.x) > 53)) or (((self.global_position.x - heroe.global_position.x) > -800) && ((self.global_position.x - heroe.global_position.x) < -53))) && hedgehod_ready && is_on_floor():
					if $Sprite.get_animation() != "stoneSword" && $Sprite.get_animation() != "stone":
						if((self.global_position.x) - heroe.global_position.x) > 0:
							$Sprite.flip_h = true
						else:
							$Sprite.flip_h = false
						timer_of_hedgehod.start()
						speed = 0
						hedgehod_ready = false
						animate("hedgehod")
						var hedgehod_1 = hedgehod.instance()
						hedgehod_1.position = heroe.global_position - Vector2(0, -25)
						get_node("..").add_child(hedgehod_1)
			
		else:
			pass


func start_jump_enemy():
	if is_on_floor():
		velocity.y = -JUMP_POWER 
		collision_of_jumping_area.set_disabled(true)
		

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
	$Sprite.play(art)


func _on_Sprite_animation_finished():
	if $Sprite.get_animation() == "stone":
		animate("idle")
	if $Sprite.get_animation() == "stoneSword":
		stone_sword_finished = true
		animate("idle")
	if $Sprite.get_animation() == "hedgehod":
		hedgehod_finished = true
		animate("idle")


func _on_Stone_Sword_body_entered(body: Node2D):
	if body.has_method("handle_hit") && body.has_method("start_jump_heroe"):
		body.handle_hit(damage_stone_sword)

func _on_Timer_Stone_timeout():
	stone_ready = true


func _on_Timer_Stone_Sword_timeout():
	stone_sword_ready = true



func _on_Timer_Hedgehod_timeout():
	hedgehod_ready = true


func _on_Area_Of_Jumping_body_entered(body):
	var heroe = get_parent().get_node("Heroe")
	if body.has_method("for_jumping") && ((self.global_position.x - body.get_global_position().x > 0 && self.global_position.x - heroe.get_global_position().x > 0) or (self.global_position.x - body.get_global_position().x < 0 && self.global_position.x - heroe.get_global_position().x < 0)) && self.global_position.y - heroe.get_global_position().y > 20:
		start_jump_enemy()


func navigation(number_of_moving):
	
	if !file.is_open() && moving_state:
		file.open("res://Navigations/" + name_character + "/navigation" + str(number_of_moving) + ".txt", File.READ)
	
	if file.is_open():
		if file.get_position() < file.get_len():
			point_of_position_string = file.get_line().split(",",true,1)
			point_of_position_string_x = ((point_of_position_string[0].split("(",false,1)))
			point_of_position_string_y = ((point_of_position_string[1].split(")",true,1)))
			scale_gravity = 0
			if point_of_position_string_x_saved != float(point_of_position_string_x[0]):
				if point_of_position_string_x_saved < float(point_of_position_string_x[0]):
					$Sprite.flip_h = false
				else:
					$Sprite.flip_h = true
				animate("run")
			else:
				animate("idle")
				
			self.set_global_position(Vector2(float(point_of_position_string_x[0]),float(point_of_position_string_y[0]) + 9))
			point_of_position_string_x_saved = float(point_of_position_string_x[0])
		elif file.is_open():
			moving_state = false
			file.close()
			animate("idle")
			scale_gravity = 2
			match number_of_moving:
				1: pass


func dialoge(array_dialoge_flags, number_of_dialoge):
	if array_dialoge_flags.size() != 0:
		if i != (array_dialoge_flags.size() - 1):
			if area_of_dialoge_camera.input_touch == array_dialoge_flags[i] && area_of_dialoge_camera.was_pressed:
				var dialoge_window_1 = dialoge_window.instance()
				dialoge_window_1.position = $Dialoge_Window_Position.position
				if array_dialoge_flags[i] - array_dialoge_flags[i - 1] == 1 && self.has_node("Dialoge_Window"):
					$Dialoge_Window.choosing_text(name_character, area_of_dialoge_camera.input_touch, number_of_dialoge)
					area_of_dialoge_camera.was_pressed = false
				else:
					add_child(dialoge_window_1)
					dialoge_window_1.choosing_text(name_character, area_of_dialoge_camera.input_touch, number_of_dialoge)
					area_of_dialoge_camera.was_pressed = false
				if i != (array_dialoge_flags.size() - 1):
					i += 1
		
		if (area_of_dialoge_camera.input_touch != array_dialoge_flags[i]) && area_of_dialoge_camera.was_pressed && self.has_node("Dialoge_Window"):
			$Dialoge_Window.queue_free()
			if i == (array_dialoge_flags.size() - 1):
				pass






func _on_VisibilityNotifier2D_screen_exited():
	if get_parent().has_method("First_Scene") && GLOBAL.first_cat_scene:
		queue_free()
