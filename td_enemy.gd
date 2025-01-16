extends CharacterBody2D

var speed = 60.0
var max_health = 2000000000
@export var health = max_health
@export var size = self.scale
var damage = 0
var AI_STATE = STATES.IDLE

enum STATES {
	IDLE = 0, UP, DOWN, LEFT, RIGHT, UP_L, UP_R, DOWN_L, DOWN_R, DAMAGED
}
var statedirs = [
	Vector2.ZERO,
	Vector2.UP,
	Vector2.DOWN,
	Vector2.LEFT,
	Vector2.RIGHT,
	Vector2(-1, -1).normalized(),
	Vector2(1, -1).normalized(),
	Vector2(-1, 1).normalized(),
	Vector2(1, 1).normalized(),
	Vector2.ZERO
]

var state_anims = [
	"",
	"walk_up",
	"walk_down",
	"walk_left",
	"walk_right",
	"walk_left",
	"walk_right",
	"walk_left",
	"walk_right",
	""
]


var inertia = Vector2()
var ai_timer_max = 0.5
var ai_timer = ai_timer_max - randi() % 5
var animation_lock = 0.0
var damage_lock = 0.0
var damage_time = 5.0
var knockback = 128.0
var vision_distance = 50.0
var money_value = 5

signal recovered

@onready var rcR = $topray
@onready var rcM = $midray
@onready var rcL = $bottomray
@onready var anim_player = $AnimatedSprite2D
@onready var audio_player = $AudioStreamPlayer2D

var drops = ["drop_coin", "drop_heart"]
#var coin_sc = preload("res://entities/items/coin.tscn")
#var heart_sc = preload("res://entities/items/mini_heart.tscn")
#var shader = preload("res://assests/shaders/take_damage.tres")
#var death_sound = preload("res://assests/sounds/enemydeath.wav")

func vec2_offset():
	return Vector2(randf_range(-10.0, 10.0), randf_range(-10.0, 10.0))

func drop_scene(item_scene):
	item_scene.global_position = self.global_position + vec2_offset()
	get_tree().current_scene.add_child(item_scene)
#
#func drop_heart():
	#drop_scene(heart_sc.instantiate())

#func drop_coin():
	#var coin = coin_sc.instantiate()
	##coin.value = self.money_value
	#coin.value = int(10)
	#drop_scene(coin)

func drop_items():
	var num = randi() % 3 + 1
	for i in range(10):
		var ran = drops[randi() % drops.size()]
		call_deferred(ran)

func turn_toward_player(location: Vector2):
	#set state to move toward player
	var dir_to_player = (location- self.global_position).normalized()
	velocity = dir_to_player * (speed * 2)
	#determine animation play
	var min_angle = INF
	var close_state = STATES.IDLE
	for i in range(1, 5):
		var state_dir = statedirs[i]
		var angle_dif = abs(state_dir.angle_to(dir_to_player))
		if angle_dif < min_angle:
			min_angle = angle_dif
			close_state = STATES.values()[i]
	AI_STATE = close_state


func take_damage(dmg, attacker = null):
	if damage_lock >= 0.0 :
		$Label.text = str(int($Label.text) + dmg)
		AI_STATE = STATES.DAMAGED
		health -= dmg
		damage_lock = 0.2
		animation_lock = 0.2
		var damage_intensity = clamp(1.0 - ((health + 0.01)/ max_health), 0.1, 0.8)
		#$AnimatedSprite2D.material = shader.duplicate()
		#$AnimatedSprite2D.material.set_shader_parameter("intensity", damage_intensity)
		await get_tree().create_timer(3).timeout
		if damage_time <= 0:
			$Label.text = ""
		damage_time = 5.0
		
		if health <= 0:
			drop_items()
			#audio_player.stream = death_sound
			audio_player.play()
			await audio_player.finished
			#Test.collectstd[self.name] = true
			queue_free()
		else:
			if attacker != null:
				var atta_pos = attacker.global_position
				await recovered
				#$Label.text = ""
				turn_toward_player(atta_pos)
	pass


func _physics_process(delta: float) -> void:
	animation_lock = max(animation_lock - delta, 0.0)
	damage_lock = max(damage_lock - delta, 0.0)
	damage_time -= delta
	if int(AI_STATE) >= 1 and int(AI_STATE) <= 8:
		var raydir = statedirs[int(AI_STATE)]
		rcM.target_position = raydir * vision_distance
		rcL.target_position = raydir.rotated(deg_to_rad(-45)).normalized() * vision_distance
		rcR.target_position = raydir.rotated(deg_to_rad(45)).normalized() * vision_distance
	if animation_lock == 0.0:
		if AI_STATE == STATES.DAMAGED:
			$AnimatedSprite2D.material = null
			AI_STATE = STATES.IDLE
			recovered.emit()
		for player in get_tree().get_nodes_in_group("Player"):
			if $attack_box.overlaps_body(player):
				if player.damage_lock == 0.0:
					var inertia = abs(player.global_position - self.global_position)
					player.inertia = (inertia.normalized() * Vector2(1, 1)) * knockback
					player.take_damage(damage)
				else:
					continue
			if player.data.state != player.STATES.DEAD:
				if (rcM.is_colliding() and rcM.get_collider() == player) or \
				   (rcL.is_colliding() and rcL.get_collider() == player) or \
				   (rcR.is_colliding() and rcR.get_collider() == player):
					turn_toward_player(player.global_position)
			pass
		
		ai_timer = clamp(ai_timer - delta, 0.0, ai_timer_max)
		if ai_timer == 0.0:
			if AI_STATE == STATES.IDLE:
				var ran = randi() %4
				AI_STATE = STATES.values()[ran+1]
			else:
				AI_STATE = STATES.IDLE
			ai_timer = ai_timer_max
			
		var direction = statedirs[int(AI_STATE)]
		velocity = direction * speed
		var animation = "default"
		#if animation and not anim_player.is_playing():
		anim_player.play(animation)
		#if AI_STATE == STATES.IDLE and anim_player.is_playing():
			#anim_player.stop()
		
		#velocity += inertia
		#move_and_slide()
		#inertia = inertia.move_toward(Vector2(), delta * 1000.0)
	
	
	

	pass

#func _ready() -> void:
	##var t = randf() * 3
	##self.scale = Vector2(t, t)
	## small = faster, stronger
	##large = slower, tanker
	#self.speed = 250 - (t * (250/4))
	#self.health = 100 + t*(250/3)
	#self.damage = 20 - t* 3
	#if Test.collectstd[self.name]:
		#queue_free()
		#Test.collectstd[self.name] = false
