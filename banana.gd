extends Node2D

var projectile_a = 300
var projectile_b = 200

var direction = 0

var first = false
var second = false
var s1 = false
var s2 = false
var third = false
var num = 1.00025

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play_backwards()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$Sprite2D.rotate($Sprite2D.rotation + delta)
	if !first:
		if (projectile_a > self.position.x):
			self.position.x = clamp(self.position.x+(delta*200), 0, projectile_a)
		else:
			first = true
	
	if !second && first:
		if !s1:
			if (-200 < self.position.y):
				self.position.y -= pow((num), 2) * 2
				self.position.x += (num) * 5
			else: s1 = true
			num *= num
			if (num > 2): num = 2
		if !s2 and s1:
			if (-300 < self.position.y):
				self.position.y -= pow(num, .333) * 5
				self.position.x -= pow((num), 2) * 2
			else:
				s2 = true
				second = true
			num *= num
			if (num > 2): num = 2
	
	if second and first && !third:
		print(self.position)
		self.position = Vector2(move_toward(self.position.x, 0, 3), move_toward(self.position.y, 0, 2))
		#if (self.position >= Vector2(0, 0)):
			#self.position = Vector2(0,0)
		print(self.position)
