extends Node2D

enum CharacterSelect { char_1, char_2, char_3 }

var max_time = 1.0
var time_left = 0.0
var can_switch = false

var currentCharacter = CharacterSelect.char_1

func _process(delta):
	if time_left > 0.0:
		time_left -= delta
		print(time_left)
	elif time_left <= 0.0 and can_switch == false:
		can_switch = true
	
	if Input.is_action_just_pressed("switch") && can_switch == true:
		switch_to_character(CharacterSelect.char_1)

func switch_to_character(current_character: CharacterSelect) -> void:
	currentCharacter = current_character
	
	match currentCharacter:
		CharacterSelect.char_1:
			char_1_data()
		CharacterSelect.char_2:
			char_2_data()
		CharacterSelect.char_3:
			char_3_data()

func char_1_data():
	reset_char_switch_delay()
func char_2_data():
	reset_char_switch_delay()
func char_3_data():
	reset_char_switch_delay()

func reset_char_switch_delay():
	time_left = max_time
	can_switch = false
