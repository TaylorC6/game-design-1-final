extends CharacterBody2D

const SPEED = 100.0
const MAXIMUM_OBTAINABLE_HEALTH = 400.0
enum  STATES { IDLE=0, DEAD, DAMAGED, ATTACKING, CHARGING }

@export var data = {
	"max_health": 100.0,  # 20hp per heart, 5 per fraction
	"health": 100.0,      # Min 60 Max 400
	"money": 0,
	"state": STATES.IDLE,
	"secondaries": [],
	}

var inertia = Vector2()
var look_direction = Vector2.DOWN  # Vector2(0,1)
var attack_direction = look_direction
var animation_lock = 0.0  # Lock player while playing attack animation
var damage_lock = 0.0
var charge_time = 1.25
var charge_duration = 0.0
var attack_wait = 0.0
var nogear = true
var noweapons = true
var pine_scene = preload("res://pineapple.tscn")
var test = "test1"
@onready var player_boy: CharacterBody2D = $"."
@onready var gear_shelf: TileMapLayer = $"../Interactables/GearShelf"
@onready var sign1: TileMapLayer = $"../../Interactables/sign1"


#@onready var glow_range: Area2D = $"../Interactables/GearShelf/Area2D"
#@onready var gear_shelf: TileMapLayer = $"../Interactables/GearShelf"
#@onready var glow_range2: Area2D = $"../Interactables/range2"


#var slash_scene  = preload("res://enitities/attacks/slash.tscn")
#var damage_shader = preload("res://assets/shaders/take_damage.tres")
#var attack_sound = preload("res://Sounds/slash.wav")
#var coin_sound = preload("res://Sounds/coin.wav")
#var heart_sound = preload("res://Sounds/heal.wav")
#var death_sound = preload("res://Sounds/enemy_death.wav")
#var hurt_sound = preload("res://Sounds/hit.wav")
#var charge_sound = preload("res://Sounds/powerUp.wav")
#
#@onready var aud_player = $AudioStreamPlayer2D
#@onready var p_HUD = get_tree().get_first_node_in_group("HUD")
#
func get_direction_name():
	return ["right", "down", "left", "up"][
		int(round(look_direction.angle() * 2 / PI)) % 4
	]

func attack():
	data.state = STATES.ATTACKING
	var dir_name = get_direction_name()
	if dir_name == "left":
		$AnimatedSprite2D.flip_h = 0
	$AnimatedSprite2D.play("swipe_" + dir_name)
	attack_direction = look_direction
	var pi = pine_scene.instantiate()
	pi.global_position = self.global_position + attack_direction * 50
	pi.rotation = Vector2().angle_to_point(-attack_direction)
	self.get_parent().add_child(pi)
	self.get_parent().add_child(pi)
	self.get_parent().add_child(pi)
	#var slash = slash_scene.instantiate()
	#slash.position = attack_direction * 20.0
	#slash.rotation = Vector2().angle_to_point(-attack_direction)
	#add_child(slash)
	#aud_player.stream = attack_sound
	#aud_player.play()
	animation_lock = 0.2
	
func charged_attack():
	data.state = STATES.ATTACKING
	$AnimatedSprite2D.play("swipe_charge")
	#aud_player.stream = charge_sound
	#aud_player.play()
	attack_direction = -look_direction
	damage_lock = 0.3
	for i in range(9):
		# Offset by (i-4) * 45 degrees; [-4,4]
		var angle = attack_direction.angle() + (i-4) * PI/4
		var dir   = Vector2(cos(angle), sin(angle))
		#var slash = slash_scene.instantiate()
		#slash.position = dir * 20
		#slash.rotation = Vector2().angle_to_point(-dir)
		#slash.damage  *= 1.5
		#add_child(slash)
		await get_tree().create_timer(0.03).timeout
	animation_lock = 0.2
	await $AnimatedSprite2D.animation_finished
	data.state = STATES.IDLE

#func _ready() -> void:
	#p_HUD.show()

func pickup_health(value):
	data.health += value
	data.health = clamp(data.health, 0, data.max_health)
	#aud_player.stream = heart_sound
	#aud_player.play()


func pickup_heart(value):
	data.health += value
	data.max_health += value
	#p_HUD.draw_hearts()
	data.health = clamp(data.health, 0, data.max_health)
	#aud_player.stream = heart_sound
	#aud_player.play()

func pickup_money(value):
	data.money += value
	#aud_player.stream = coin_sound
	#aud_player.play()

signal health_depleted

func take_damage(dmg):
	if damage_lock == 0.0 and data.state != STATES.DEAD:
		data.health -= dmg
		data.state = STATES.DAMAGED
		damage_lock = 0.5
		animation_lock = dmg * 0.005
		#$AnimatedSprite2D.material = damage_shader.duplicate()
		$AnimatedSprite2D.material.set_shader_parameter("intensity", 0.5)
		if data.health > 0:
			#aud_player.stream = hurt_sound #take damage func
			#aud_player.play()
			pass
		else:
			data.state = STATES.DEAD
			#aud_player.stream = death_sound
			#aud_player.play()
			for i in range(15):
					var angle = PI/180 * 6
					self.rotate(angle)
					await get_tree().create_timer(0.01).timeout
			await get_tree().create_timer(0.5).timeout
			health_depleted.emit()
	pass
#func glow_area(use_area: Area2D, player: CollisionShape2D):
	#return use_area.overlaps_body(player)
func in_range(player) -> bool:
	return get_tree().get_current_scene().get_node("y-sort").get_node("Interactables").get_node(test).get_node("Area2D").overlaps_body(player)
	#return get_tree().get_current_scene().get_node(test).get_node("StaticBody2D").get_node("Area2D").overlaps_body(player)
	#get_tree().get_current_scene().get_node("StaticBody2D").get_node("Area2D").overlaps_body(player)
#var glow_ranges = {glow_range: gear_shelf, "glow_range2": "sign1"}

func _physics_process(delta: float) -> void:
	for t in get_tree().get_nodes_in_group("Glows"):
		test = str(t)
<<<<<<< HEAD
		#print(test)
=======
>>>>>>> 47f3899d21d20fd5bf412304f95664a3caa97782
		if player_boy.in_range(self):
			t.material = Fpjglobal.glow_shader.duplicate()
			#t.material.set_shader_parameter("intensity", 0.5)
			#t.material.set_shader_parameter()
<<<<<<< HEAD
			#print(t)
=======
>>>>>>> 47f3899d21d20fd5bf412304f95664a3caa97782
			#if t == get_tree().get_current_scene().get_node("test1"):
				
			#if t == get_tree().get_current_scene().get_node("test2"):
				
		else:
			t.material = Material.new()
	#$AnimatedSprite2D.material = damage_shader.duplicate()
	#$AnimatedSprite2D.material.set_shader_parameter("intensity", 0.5)
	#for areas in get_tree().get_nodes_in_group("Glows"):
		##var result = Fpjglobal.glow_area(entity)
		#if areas.in_range(self):
			#glow_ranges[areas].material = Fpjglobal.glow_shader.duplicate()
	

<<<<<<< HEAD

=======
>>>>>>> 47f3899d21d20fd5bf412304f95664a3caa97782
	#if Input.is_action_just_pressed("ui_interact"):
		#for entity in get_tree().get_nodes_in_group("Interactables"):
				#if player_boy.in_range(self):
					#noweapons = false
					#Fpjglobal.stairsOpen = true
				
<<<<<<< HEAD

	if Input.is_action_just_pressed("ui_interact"):
		for entity in get_tree().get_nodes_in_group("Interactables"):
				if player_boy.in_range(self):
					if entity == gear_shelf:
						noweapons = false
						Fpjglobal.stairsOpen = true
					if entity == sign1:
						Fpjglobal.message_box_visible = true
						Fpjglobal.message = Fpjglobal.player_names["Boy"]
					else:
						Fpjglobal.message_box_visible = false

=======
	if Input.is_action_just_pressed("ui_interact"):
		for entity in get_tree().get_nodes_in_group("Interactables"):
				if player_boy.in_range(self):
					noweapons = false
					Fpjglobal.stairsOpen = true
>>>>>>> 47f3899d21d20fd5bf412304f95664a3caa97782

	if animation_lock == 0.0 and data.state != STATES.DEAD:
		if data.state == STATES.DAMAGED and max(damage_lock-delta, 0.0):
			$AnimatedSprite2D.material = null;
		if data.state != STATES.CHARGING:
			data.state = STATES.IDLE

	var direction = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)
	if direction.length() > 0:
		look_direction = direction
		# Scale to 1 to prevent speed boost from diagonals
		direction = direction.normalized()
		velocity  = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		velocity += inertia
	update_animation(direction)
	move_and_slide()
	inertia = inertia.move_toward(Vector2.ZERO, delta * 1000.0)
	if data.state != STATES.DEAD:
		if Input.is_action_just_pressed("ui_accept") && attack_wait <= 0.0:
			attack()
			attack_wait = 5.0
			charge_duration = 0.0
			data.state = STATES.CHARGING
		
		charge_duration += delta
		if Input.is_action_just_released("ui_accept"):
			if charge_duration >= charge_time and \
			   data.state == STATES.CHARGING:
				charged_attack()
			else:
				data.state = STATES.IDLE
			
	if Input.is_action_just_pressed("ui_cancel"):
		$Camera2D/pause_menu.show()
		get_tree().paused = true
	pass
	#
	attack_wait -= delta
		#if Input.is_action_just_pressed("ui_interact"):
			#pass
		#if Input.is_action_just_pressed("ui_ability"):
			#pass
		
	#TODO: if Input.is_action_just_pressed("ui_interact"):
		# if looking at gear item/clothes:
			# gear = false
	#if Input.is_action_just_pressed("ui_interact"):
<<<<<<< HEAD
=======
		#print(self.in_range_interactables(shelf, self))
>>>>>>> 47f3899d21d20fd5bf412304f95664a3caa97782
		#if self.in_range_interactables(shelf, self):
			#print("hi")
			#noweapons = false
			#Fpjglobal.stairsOpen = true


func update_animation(direction):
	if data.state == STATES.IDLE:
		var a_name = "idle_"
		if direction.length() > 0:
			a_name = "walk_"
		if look_direction.x < 0:
			a_name += "left"
		elif look_direction.x > 0:
			a_name += "right"
		elif look_direction.y < 0:
			a_name += "up"
		elif look_direction.y > 0:
			a_name += "down"
 
		var _wak = a_name.substr(0, 5)
		
		if nogear == false:
			a_name += "_nogear"
		elif noweapons == false:
			a_name += "_noweapons"
		elif noweapons == false and nogear == false:
			a_name = a_name
		else:
			a_name += "_nogear"

		$AnimatedSprite2D.animation = a_name
		$AnimatedSprite2D.play()
		

	pass


func in_range_interactables(inter, player):
	for i in get_tree().get_nodes_in_group("Interactables"):
		for it in i.get_children():
			print("hill")
			if it.get_class() == "Area2D":
				print("hi")
				print(i)
				var t = inter.instantiate()
				print(t)
				if it.overlaps_body(self) && i == inter:
					print("no")
					return true
		#if i == inter && i.get_children().find(CollisionShape2D):
			#return true
	return false
