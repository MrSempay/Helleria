extends Button




func _ready():
	match GLOBAL.stone:
		1:
			set_text("Body Seal")
		2:
			set_text("Bow")
