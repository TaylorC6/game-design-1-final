extends Node2D

var projectile_a = 150
var projectile_b = 50
var circle = Vector2(100, -100)
var radius = 5
var circumference = radius*PI*2 
var direction = 0

var first = false
var second = false
var s1 = false
var s2 = false
var third = false
var rn = false
var num = 1.0

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
	
	#if rn :
		#num = 
	
	if !second && first:
		if !s1:
			if (-150 < self.position.y):
				#self.position.x += 5
				#self.position.y -= pow((self.position.x), 2) / 8000.0
				#self.position.x += pow((num), 2) / 1000.0
#could try velocity
				self.position += Vector2(num * circumference / 5, -(1-num) * circumference  / 5)
			else: 
				s1 = true
				rn = true
			num -= delta 
			if (num < 0): num = 0
		if !s2 && s1:
			if (200 < self.position.x):
				#self.position.x -= 5
				#self.position.y -= pow((self.position.x), 1.5) / 500.0
				self.position += Vector2(-(num) * circumference / 5, -(1-num) * circumference / 5)
			else:
				s2 = true
				second = true
			num += delta 
			if (num > 1): 
				num = 1
	
	if second && first && !third:
		if self.position.x != 0 && self.position.y != 0:
			self.position = Vector2(move_toward(self.position.x, 0, 3), move_toward(self.position.y, 0, 3))
		else :
			print(Fpjglobal.player_position)
			self.position = Vector2(move_toward(self.position.x, Fpjglobal.player_position.x, 10), move_toward(self.position.y, Fpjglobal.player_position.y, 10))
		#if (self.position >= Vector2(0, 0)):
			#self.position = Vector2(0,0)
		#print(self.position)
