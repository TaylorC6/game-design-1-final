extends CanvasLayer

@onready var messagebox_visible = false
var firstframe = 1
var sent = ""

func _ready() -> void:
	set_visible(false)

func _process(_delta: float) -> void:
	if Fpjglobal.message_box_visible:
		messagebox_visible = true
	else:
		messagebox_visible = false
	if messagebox_visible == true:
		set_visible(true)
		if firstframe == 1:
			firstframe = 0
			message_make(Fpjglobal.message)
	else:
		set_visible(false)
		$Label.text = ""
		firstframe = 1


	pass

func message_make(sentence):
	var textspeed = 0.005
	var change = 0
	var letter = 0

	for i in range(len(sentence)):
		sent += (sentence[i])
		$Label.text = str(sent)
		change = (0.025 / (len(sentence) / 2.0))
		letter += 1
		if letter >= len(sentence) / 2.0:
			textspeed += change
		await get_tree().create_timer(textspeed).timeout
		#print(textspeed)
	sent = ""
