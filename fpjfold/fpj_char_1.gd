extends CharacterBody2D

const SPEED = 100.0

enum STATES {IDLE=0, DEAD, DAMAGED, ATTACKING, CHARGING}

@export var data = {
	"max_health" : 100.0, #20 hp per heart, 5 per fraction
	"health" : 100.0, # min 60 max 400
	"max_sp" : 100.0,
	"sp" : 100.0,
	"max_money" : 9999,
	"money" : 0,
	"state" : STATES.IDLE,
	"damage" : 10,
}

var inertia = Vector2()
var look_direction = Vector2.DOWN
var attack_dir = look_direction
var animation_lock = 0.0
var damage_lock = 0.0
var charge_time = 2.5
var charge_start = 0.0


#var slash_scene = preload("res://entities/Attacks/slash.tscn")

@onready var p_HUD = get_tree().get_first_node_in_group("HUD")

func get_direction_name():
	return ["side", "down", "left", "up"][
		int(round(look_direction.angle() * 2 / PI))%4
	]

#func _ready() -> void:
	#if Fpjglob.data != {}:
		#self.data = Fpjglob.data
	#else:
		#Fpjglob.data = self.data
	#p_HUD.show()
	#p_HUD.draw_hearts()
	#setup_money(data.money)

func pickup_health(value):
	#aud.stream = heart_sound
	#aud.play()
	data.health += value
	data.health = clamp(data.health, 0, data.max_health)
	

func pickup_money(value):
	#aud.stream = coin_sound
	#aud.play()
	if value >= 1:
		data.money += value
		data.money = clamp(data.money, 0, data.max_money)
	p_HUD.add_money(data.money)

func setup_money(value):
	p_HUD.add_money(data.money)

func attack():
	data.state = STATES.ATTACKING
	var dire = get_direction_name()
	if dire == "left" :
		$AnimatedSprite2D.flip_h = true
		dire = "side"
		$AnimatedSprite2D.play("attack_" + dire)
	else:
		$AnimatedSprite2D.play("attack_" + dire)
	attack_dir = look_direction
	#var attack = slash_scene.instantiate()
	#attack.position = attack_dir * 20.0
	#attack.rotation = Vector2().angle_to_point(-attack_dir)
	#add_child(attack)
	animation_lock = 0.2

func charged_attack():
	data.state = STATES.ATTACKING
	var dire = get_direction_name()
	var angle = 0.0
	if dire == "left" :
		$AnimatedSprite2D.flip_h = true
		dire = "side"
		$AnimatedSprite2D.play("attack_charge_" + dire)
		angle = attack_dir.angle() + (4-4) * PI/4
	else:
		$AnimatedSprite2D.play("attack_charge_" + dire)
		angle = attack_dir.angle() + (4-4) * PI/4
	#attack_dir = -look_direction
	#damage_lock = 0.3
	#for i in range(9):
	
	var dir = Vector2(cos(angle), sin(angle))
	##var ns = slash_scene.instantiate()
	#ns.position = dir * 20
	#ns.rotation = Vector2().angle_to_point(-dir)
	#ns.damage *= 1.5
	#add_child(ns)
	#await get_tree().create_timer(0.03).timeout
	#animation_lock = 0.2
	
	await $AnimatedSprite2D.animation_finished
	data.state = STATES.IDLE

signal health_depleted

func take_damage(damage):
	if damage_lock == 0.0:
		data.health -= damage_lock
		data.state = STATES.DAMAGED
		damage_lock = 0.5
		animation_lock = damage * 0.005
		
		if data.health > 0:
			#TODO play death sound
			pass
		else:
			data.state = STATES.DEAD
			#TODO play death anim and sound
			await get_tree().create_timer(0.5).timeout
			health_depleted.emit()
	
	pass

func _physics_process(delta: float) -> void:
	animation_lock = max(animation_lock - delta, 0.0)
	damage_lock = max(damage_lock-delta, 0.0)
	
	if animation_lock == 0 and data.state != STATES.DEAD:
		if data.state != STATES.CHARGING:
			data.state = STATES.IDLE
		
		var direction = Vector2(
			Input.get_axis("ui_left", "ui_right"), 
			Input.get_axis("ui_up", "ui_down")
		)
		if direction.length() > 0:
			look_direction = direction
			#Scale to 1 to prevent speed boost
			direction = direction.normalized()
			self.velocity = direction*SPEED
		else:
			velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		velocity += inertia
		update_animation(direction)
		move_and_slide()
		inertia = inertia.move_toward(Vector2.ZERO, delta*1000.0)
		
	
	if data.state != STATES.DEAD:
		if Input.is_action_just_pressed("ui_accept"):
			attack()
			charge_start = 0.0
			data.state = STATES.CHARGING
		
		charge_start += delta
		if Input.is_action_just_released("ui_accept"):
			if charge_start >= charge_time and data.state == STATES.CHARGING:
				charged_attack()
			else:
				data.state = STATES.IDLE
	if Input.is_action_just_pressed("ui_cancel"):
		$Camera2D/pause_menu.show()
		get_tree().paused = true
	pass

func update_animation(direction):
	if data.state == STATES.IDLE:
		var aname = "idle_"
		if direction.length() > 0:
			aname = "walk_"
		if look_direction.x != 0: 
			aname += "side"
			$AnimatedSprite2D.flip_h = look_direction.x < 0
		elif look_direction.y < 0:
			aname += "up"
		#else:
			#aname += "down"
		elif look_direction.y > 0:
			aname += "down"
		$AnimatedSprite2D.animation = aname
		$AnimatedSprite2D.play()
	pass
