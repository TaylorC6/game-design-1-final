extends Node2D

var glowsign = false
var firstframe = 1
var play
var first = true

func in_range(player) -> bool:
	return $Area2D.overlaps_body(player)

func _physics_process(_delta: float):
	#Fpjglobal.process(_delta)
	for player in get_tree().get_nodes_in_group("Player") :
		if first && in_range(player):
			first = false
			play = player
			glowsign = true
		if play == player:
			if in_range(player):
				glowsign = true
			else:
				glowsign = false
	if glowsign:
		set_visible(true)
		if firstframe == 1:
			glowpulse()
			firstframe = 0
	else:
		set_visible(false)
		firstframe = 1


func glowpulse():
	var brightness = 0.15
	while glowsign:
		for num in range(10):
			brightness -= 0.01
			await get_tree().create_timer(0.08).timeout
			get_node("Glow").modulate.a = brightness
			#print(brightness)
		for num in range(10):
			brightness += 0.01
			await get_tree().create_timer(0.08).timeout
			get_node("Glow").modulate.a = brightness
			#print(brightness)
