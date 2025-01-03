extends CanvasLayer

@onready var messagebox_visible = false
var firstframe = 1
var strings = ["Grab your gear to prepare for the challenges ahead!", "Randy do be kinda sus!"]

func _ready() -> void:
	set_visible(false)

func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_interact"):
		messagebox_visible = not messagebox_visible
	if messagebox_visible == true:
		set_visible(true)
		if firstframe == 1:
			firstframe = 0
			message_make(strings[0])
	else:
		set_visible(false)
		$Label.text = ""
		firstframe = 1


	pass

func message_make(sentence):
	
	var printy = ""
	var textspeed = 0.005
	var change = 0
	var letter = 0

	for i in range(len(sentence)):
		printy += (sentence[i])
		$Label.text = "" + str(printy)
		change = (0.025 / (len(sentence) / 2.0))
		letter += 1
		if letter >= len(sentence) / 2.0:
			textspeed += change
		await get_tree().create_timer(textspeed).timeout
		print(textspeed)
