extends CharacterBody2D

const SPEED = 1500
const MAX_OBTAINABLE_HEALTH = 400.0
enum STATES {IDLE=0, DEAD, DAMAGED, ATTACKING, CHARGING}
var num = 0
var nu = 0

@export var data = {
	"max_health" : 60.0, #20 hp per heart, 5 per fraction
	"health" : 45.0, # min 60 max 400
	"max_money" : 9999,
	"money" : 0,
	"state" : STATES.IDLE,
	"secondaries" : [],
}

var inertia = Vector2()
var look_direction = Vector2.DOWN
var attack_dir = look_direction
var animation_lock = 0.0
var damage_lock = 0.0
var charge_time = 2.5
var charge_start = 0.0

#var slash_scene = preload("res://entities/Attacks/slash.tscn")
#var damage_shader = preload("res://assests/shaders/take_damage.tres")
#var attack_sound = preload("res://assests/sounds/slash.wav")
#var coin_sound = preload("res://assests/sounds/pcoin.wav")
#var heart_sound = preload("res://assests/sounds/pheart.wav")
#var death_sound = preload("res://assests/sounds/pdeath.wav")
#var hurt_sound = preload("res://assests/sounds/phurt.wav")
#var hit_sound = preload("res://assests/sounds/phit.wav")

@onready var p_HUD = get_tree().get_first_node_in_group("HUD")
@onready var aud = $AudioStreamPlayer2D

func get_direction_name():
	return ["right", "down", "left", "up"][
		int(round(look_direction.angle() * 2 / PI))%4
	]

func attack():
	data.state = STATES.ATTACKING
	var dire = get_direction_name()
	if dire == "left" :
		$AnimatedSprite2D.flip_h = 0
	$AnimatedSprite2D.play("swipe_" + dire)
	attack_dir = look_direction
	#var slash = slash_scene.instantiate()
	#slash.position = attack_dir * 20.0
	#slash.rotation = Vector2().angle_to_point(-attack_dir)
	#add_child(slash)
	#aud.stream = attack_sound
	aud.play()
	animation_lock = 0.2

func charged_attack():
	data.state = STATES.ATTACKING
	$AnimatedSprite2D.play("swipe_charge")
	attack_dir = -look_direction
	damage_lock = 0.3
	for i in range(18):
		var angle = attack_dir.angle() + (i-4) * PI/4
		var dir = Vector2(cos(angle), sin(angle))
		#for l in range(50):
			#var ns = slash_scene.instantiate()
			#dir = Vector2(cos(l*5), sin(l*5))/2
			#ns.position = dir * (10 + l)*2
			#ns.rotation = Vector2().angle_to_point(-dir)/2
			#ns.damage *= l
			#add_child(ns)
		#aud.stream = hit_sound
		#aud.play()
		await get_tree().create_timer(0.03).timeout
	animation_lock = 0.2
	await $AnimatedSprite2D.animation_finished
	data.state = STATES.IDLE

signal health_depleted

func take_damage(damage):
	if damage_lock == 0.0 and data.state != STATES.DEAD:
		data.health -= damage
		data.state = STATES.DAMAGED
		damage_lock = 0.5
		animation_lock = damage * 0.005
		#$AnimatedSprite2D.material = damage_shader.duplicate()
		$AnimatedSprite2D.material.set_shader_parameter("intensity", 0.5)
		if data.health > 0:
			#aud.stream = hurt_sound
			#aud.play()
			pass
		else:
			data.state = STATES.DEAD
			#aud.stream = death_sound
			#aud.play()
			#self.rotation = PI/2
			#for lcv in range(90):
				#self.rotate(PI/2 - ((90-lcv)/180))
			await get_tree().create_timer(0.5).timeout
			health_depleted.emit()
			
	
	pass


#func _ready() -> void:
	#self.global_position += Fpjglobal.get_cords()
	#if Fpjglobal.data != {}:
		#self.data = Fpjglobal.get_data()
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

func pickup_container():
	data.max_health = clamp(data.max_health + 20.0, 0, MAX_OBTAINABLE_HEALTH)
	data.health += data.max_health
	data.health = clamp(data.health, 0, data.max_health)
	p_HUD.draw_hearts()

func _physics_process(delta: float) -> void:
	animation_lock = max(animation_lock - delta, 0.0)
	damage_lock = max(damage_lock-delta, 0.0)
	
	if animation_lock == 0 and data.state != STATES.DEAD:
		if data.state != STATES.DAMAGED and max(damage_lock-delta, 0.0):
			$AnimatedSprite2D.material = null;
		
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
		#update_animation(direction)
		move_and_slide()
		inertia = inertia.move_toward(Vector2.ZERO, delta*1000.0)
		
	
	if data.state != STATES.DEAD:
		if Input.is_action_just_pressed("ui_accept"):
			charged_attack()
			charge_start = 0.0
			data.state = STATES.CHARGING
		
		charge_start += delta
		#if (charge_start >= charge_time && data.state == STATES.CHARGING):
			#aud.stream = attack_sound
			#aud.pitch_scale *= 1.1
			#aud.play()
		if Input.is_action_just_released("ui_accept"):
			for entity in get_tree().get_nodes_in_group("Interactable"):
				if entity.in_range(self):
					entity.interact(self)
					data.state = STATES.IDLE
					return
			if charge_start >= charge_time and data.state == STATES.CHARGING:
				aud.pitch_scale = 1
				charged_attack()
				
			else:
				data.state = STATES.IDLE
	if Input.is_action_just_pressed("ui_cancel"):
		$Camera2D/pause_menu.show()
		get_tree().paused = true
	if Input.is_action_just_pressed("bullet"):
		#var d = true
		charged_attack()
		#while (d) :
			#charged_attack()
			#await get_tree().create_timer(0.5).timeout
			#if Input.is_action_just_pressed("bullet"):
				#d = false
	if data.state == STATES.DEAD:
		num += 1
		#beyblade for real
		if num <= 9000:
			self.rotate(PI/2 - ((PI*(90-num))/180))
		#if num <= 45:
			#self.rotate(PI/180 * 2)
	pass

#func update_animation(direction):
	#if data.state == STATES.IDLE:
		#var aname = "idle_"
		#if direction.length() > 0:
			#aname = "walk_"
		#if look_direction.x != 0: 
			#aname += "side"
			#$AnimatedSprite2D.flip_h = look_direction.x < 0
		#elif look_direction.y < 0:
			#aname += "up"
		##else:
			##aname += "down"
		#elif look_direction.y > 0:
			#aname += "down"
		#$AnimatedSprite2D.animation = aname
		#$AnimatedSprite2D.play()
		##beyblade for real
		#nu += 1
		##self.rotate(PI/2 - ((PI*(90-nu))/180))
		#self.rotate(3.0 + nu/18000)
	#pass
