extends Node2D

class_name IBO
#var stone_wall_of_Garsia
#func _physics_process(delta):
#	$KinematicBody2D.translate(Vector2(0,1))

func say_hello():
	print("Hello!")

static func ibo():
	print("a")
	print("b")
func foo():
	return("bar")
var d = "assd"
const namm = "res://Game/Characters/Heroe.tscn"
func _ready():
	var sum = 0
	#var splited_initial = "3970; 3990; 4010; 4005; 3995; 3965; 4005; 4015; 4005; 4000; 3965; 3970; 4015; 4035; 3975; 3985; 3985; 4000; 4010; 4005; 4000; 4000; 4010; 3995; 3990; 3995; 4000; 3980; 3970; 4040; 4015; 4005; 4005; 4015; 3990; 3995; 4000; 3965; 4040; 4005".split(";")
	#var splited_initial = "1.1 1.5 2.1 2.8 3.7 4.6".split(" ")
	var splited_initial = "12 9 7.5 6.8 5.1 4.3".split(" ")
	for i in range(splited_initial.size()):
		sum += float(splited_initial[i])
	print(sum/splited_initial.size())
	print(splited_initial.size())
	var q = 0
	for i in range(splited_initial.size()):
		q += pow((float(splited_initial[i]) - sum/splited_initial.size()), 2)
	q = sqrt(q/(splited_initial.size() - 1))
	print(q)
	
	set("d", 15)
	#print(self.get_property_list())
	#var her = load(namm)
	#get_tree().change_scene_to(her)
	#her.instance().modulate = Color(0.3, 0.3, 0.3, 0)
	
	#get_tree().get_current_scene().free()
	#print(get_tree().get_current_scene().get_name())
	#self.modulate.a = 1
	#var ibo = self.get("modulate")[3]
	#print(ibo)
	#var property_name = "a"
	#var property_value = str2var("Vector2(0, 0)")


	#var a = funcref($Ibo, "foo")
	#print(a) # Prints bar



	#var nodil = Node2D.new()
	#nodil.name = "Ibo"
	#self.add_child(nodil)
	#self.get_node("Ibo").queue_free()
	#yield(get_tree(), "idle_frame")
	#print(nodil)
	#print(self.get_node("Ibo"))

	#$Area2D.connect("body_entered", self, "_on_Area2D_body_entered", [1, 2])
	#print(get_segments_from_CollisionShape_or_collisionPolygon($Area2D))
	#print($Area2D/CollisionShape2D.shape.extents.x)
	#print(Vector2(0, 50).cross(Vector2(50,-20)))
	#print(intersecting_vectors(get_segments_from_CollisionShape_or_collisionPolygon($Area2D2), [[Vector2(196,21), Vector2(210,22)]]))


func get_segments_from_CollisionShape_or_collisionPolygon(area):
	var array_of_segments = []
	var shape = area.get_children()[0]
	var shape_classname = shape.get_class()
	var array_points = []
	match shape_classname:
		"CollisionPolygon2D":
			for i in range(shape.polygon.size()):
				if i == shape.polygon.size() - 1:
					array_of_segments.append([shape.polygon[i] + area.global_position, shape.polygon[0] + area.global_position])
					return array_of_segments
				array_of_segments.append([shape.polygon[i] + area.global_position, shape.polygon[i + 1] + area.global_position])
		"CollisionShape2D":
			array_points.append(Vector2(area.global_position.x - shape.shape.extents.x, area.global_position.y - shape.shape.extents.y))
			array_points.append(Vector2(area.global_position.x + shape.shape.extents.x, area.global_position.y - shape.shape.extents.y))
			array_points.append(Vector2(area.global_position.x + shape.shape.extents.x, area.global_position.y + shape.shape.extents.y))
			array_points.append(Vector2(area.global_position.x - shape.shape.extents.x, area.global_position.y + shape.shape.extents.y))
			for i in range(array_points.size()):
				if i == array_points.size() - 1:
					array_of_segments.append([array_points[i], array_points[0]])
					return array_of_segments
				array_of_segments.append([array_points[i], array_points[i + 1]])

		




func intersecting_vectors(mass_segment1, mass_segment2):

	#X_AB(t) = mass_points1[i][0].x + t * (mass_points1[i][1].x - mass_points1[i][0].x)
	#C.y + s * (D.y - C.y) = A.y + t * (B.y - A.y)
	#C.x + s * (D.x - C.x) = A.x + t * (B.x - A.x)          s * (D.x - C.x) - (s * coefficient_at_s + absolute_term_at_s) * (B.x - A.x) = A.x - C.x
	#(C.y + s * (D.y - C.y) - A.y)/(B.y - A.y) = t			s * (D.x - C.x) - s * coefficient_at_s * (B.x - A.x) = A.x - C.x - absolute_term_at_s * (B.x - A.x)
	#(A.x + t * (B.x - A.x) - C.x)/(D.x - C.x) = s			s = (A.x - C.x - absolute_term_at_s * (B.x - A.x))/((D.x - C.x) - coefficient_at_s * (B.x - A.x))
	var t
	var s	
	var A = Vector2.ZERO
	var B = Vector2.ZERO
	var C = Vector2.ZERO
	var D = Vector2.ZERO
	# правильные: var t = ((C.x - A.x) * (D.y - C.y) - (C.y - A.y) * (D.x - C.x)) / ((B.x - A.x) * (D.y - C.y) - (B.y - A.y) * (D.x - C.x))
	# правильные: var s = (A.x + t * (B.x - A.x) - C.x)/(D.x - C.x)
	var is_intersection = false
	for i in range(mass_segment1.size()):
		#print((B.x - A.x))
		#print((D.x - C.x))
		A.x = mass_segment1[i][0].x
		A.y = mass_segment1[i][0].y
		B.x = mass_segment1[i][1].x
		B.y = mass_segment1[i][1].y
		for j in range(mass_segment2.size()):
			C.x = mass_segment2[j][0].x
			C.y = mass_segment2[j][0].y
			D.x = mass_segment2[j][1].x
			D.y = mass_segment2[j][1].y
			if ((B.x - A.x) * (D.y - C.y) == (B.y - A.y) * (D.x - C.x)):
				pass
			else:
				#print(((B.x - A.x) * (D.y - C.y) - (B.y - A.y) * (D.x - C.x)))
				#print(((mass_segment1[i][1].x - mass_segment1[i][0].x) * (mass_segment2[i][1].x - mass_segment2[i][0].x) - (mass_segment1[j][1].y - mass_segment1[j][0].y) * (mass_segment2[j][1].y - mass_segment2[j][0].y)))
				t = ((C.x - A.x) * (D.y - C.y) - (C.y - A.y) * (D.x - C.x)) / ((B.x - A.x) * (D.y - C.y) - (B.y - A.y) * (D.x - C.x))
				s = (A.x + t * (B.x - A.x) - C.x)/(D.x - C.x)
				if s >= 0 && s <= 1 && t >= 0 && t <= 1:
					return true	
	#var coefficient_at_s = (D.x - C.x)/(B.y - A.y)
	#var absolute_term_at_s = (C.y - A.y)/(B.y - A.y)
	#var ibo = (A.x - C.x - absolute_term_at_s * (B.x - A.x))/((D.x - C.x) - coefficient_at_s * (B.x - A.x))
	#C.x + s * (D.x - C.x) = A.x + (C.y + s * (D.y - C.y) - A.y)/(B.y - A.y) * (B.x - A.x)
	#var s = (A.x - C.x + (C.y - A.y)/(B.y - A.y) * (B.x - A.x)) / ((D.x - C.x) - (D.y - C.y)/(B.y - A.y) * (B.x - A.x))
	#var ibo = (C.x + s * (D.x - C.x) - A.x)/(B.x - A.x)
	#var t = ((C.y - A.y) * (D.x - C.x) + (A.x - C.x) * (D.y - C.y)) / ((B.x - A.x) * (D.y - C.y) - (B.y - A.y) * (D.x - C.x))
	#print(ibo)
	return false



func _on_Area2D_body_entered(tody = null, mda = 5, k = 11):
	print(tody)
	print(mda)
	print(k)
	
