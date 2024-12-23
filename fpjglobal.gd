extends Node

var glow = false
var stairsOpen = false
var firstframe = 1
var player = "Player_Boy"

var interacts = ["Shelf", "Sign1"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta: float) -> void:
	
	if glow:
		get_tree().get_current_scene().get_node(get_node("y-sort").get_node("Player_Boy").get("entity")).set_visible(true)
		if firstframe == 1:
			glowpulse()
			firstframe = 0
	else:
		get_tree().get_current_scene().get_node(get_current_scene().get_node("y-sort").get_node("Player_Boy").get("entity")).set_visible(false)
		firstframe = 1

func glowpulse():
	var brightness = 0.15
	while Fpjglobal.glow:
		for num in range(10):
			brightness -= 0.01
			await get_tree().create_timer(0.08).timeout
			get_tree().get_current_scene().get_node("y-sort").get_node("Player_Boy").get("entity").get_child(2).modulate.a = brightness
		for num in range(10):
			brightness += 0.01
			await get_tree().create_timer(0.08).timeout
			get_tree().get_current_scene().get_node("y-sort").get_node("Player_Boy").get("entity").get_child(2).modulate.a = brightness

			
	pass
