extends Node2D

#@export var contents: Dictionary = {}
#@export var enem = false
#var OPEN_STATE = false
#var regex = RegEx.new()

func in_range(player) -> bool:
	return $StaticBody2D/Area2D.overlaps_body(player)

func _physics_process(_delta: float):
	var brightness = 0.25
	var b = false
	if Fpjglobal.glow:
		set_visible(true)
		if brightness == 0.25:
			b = false
		elif brightness == 0.35:
			b = true
		if b == true:
			for num in range(10):
				brightness -= 0.01
				await get_tree().create_timer(0.2).timeout
				print(b)
				print(brightness)
		elif b != true:
			for num in range(10):
				brightness += 0.01
				await get_tree().create_timer(0.2).timeout
				print(b)
				print(brightness)
		
		
		$Glow.modulate.a = brightness
	else:
		set_visible(false)
	
	
#func interact(player):
	#if not OPEN_STATE:
		#open_chest(player)

#func open_chest(player):
	#OPEN_STATE = true
	#$Sprite2D.frame = 1
	#if enem:
		#for num in range(3):
			#var en = enemy.instantiate()
			#en.global_position = self.global_position + Vector2(0,1)
			#get_tree().current_scene.add_child(en)
	#for item in contents.keys():
		#drop_item(item, contents[item], player)
		#await get_tree().create_timer(0.5).timeout
	#contents = {}
#
#func bounce_towards_player(item, player):
	#var direction = (player.global_position - global_position).normalized()
	#var BOUNCE_DISTANCE = 50
	#var bounce_path = direction * BOUNCE_DISTANCE + \
					#Vector2(randf_range(-10.0, 10.0), randf_range(-10.0, 10.0))
	#var tween = get_tree().create_tween()
	#tween.set_trans(Tween.TRANS_BOUNCE)
	#tween.set_ease(Tween.EASE_OUT)
	#tween.tween_property(item, "global_position", item.global_position + bounce_path, 0.5)
	#tween.play()
	#await tween.finished
#
#func drop_item(item_name, value, player):
	#var scene_name = "res://enitities/items/%s.tscn" %  regex.sub(item_name, "")
	#var item_scene = load(scene_name)
	#var item = item_scene.instantiate()
	#
	#item.bounce = false
	#if value != 1: item.value = value
	#item.global_position = self.global_position
	#get_tree().current_scene.add_child(item)
	#bounce_towards_player(item, player)
#
#
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#regex.compile("[0-9]")
	#pass
