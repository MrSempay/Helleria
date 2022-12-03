extends Label



func _ready():
	match GLOBAL.stone:
		1:
			text = str(GLOBAL.arrow_amount)
	
