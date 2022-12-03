extends Button




func _ready():
	match GLOBAL.stone:
		1:
			set_text("Sheld")
		2:
			set_text("Hedgehod")
