extends Node

var glow = false
var stairsOpen = false
var firstframe = 1
var player = "Player_Boy"
var e = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta: float) -> void:
	
	#get_tree().get_nodes_in_group("Interactables"):
	
	#if glow:
		##get_tree().get_current_scene().get_node("y-sort").get_node("Player_Boy").get("entity").set_visible(true)
		#for entity in get_tree().get_nodes_in_group("Interactables"):
			#print("hi")
			#if entity.in_range(self):
				#print("hi2")
				#entity.set_visible(true)
				#e = entity
				#print(entity)
		#if firstframe == 1:
			#print("hi3")
			#glowpulse()
			#firstframe = 0
	#else:
		#for entity in get_tree().get_nodes_in_group("Interactables"):
			#if entity.in_range(self):
				#entity.set_visible(false)
				#e = entity
#
		#firstframe = 1
#
#func glowpulse():
	#var brightness = 0.15
	#while Fpjglobal.glow:
		#for num in range(10):
			#brightness -= 0.01
			#await get_tree().create_timer(0.08).timeout
			#if e == "sign1" or e == "shelf":
				#get_tree().get_current_scene().get_node(e).child_node(2).modulate.a = brightness
			##get_tree().get_current_scene().get_node("y-sort").get_node("Player_Boy").get("entity").get_child(2).modulate.a = brightness
		#for num in range(10):
			#brightness += 0.01
			#await get_tree().create_timer(0.08).timeout
			#if e == "sign1" or e == "shelf":
				#get_tree().get_current_scene().get_node(e).child_node(2).modulate.a = brightness
			##get_tree().get_current_scene().get_node("y-sort").get_node("Player_Boy").get("entity").get_child(2).modulate.a = brightness

			
	pass
