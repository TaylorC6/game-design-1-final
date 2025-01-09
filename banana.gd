extends Node2D

var projectile_a = 15
var projectile_b = 5
var circle = Vector2(10, -10)
var start = Fpjglobal.player_position
var radius = 5
var circumference = radius*PI*2
var direction = Fpjglobal.player_direction
var angle = direction
var dir = Vector2(0, 0)

var first = false
var second = false
var s1 = false
var s2 = false
var third = false
var t1 = false
var rn = false
var num = 1.0
var st = start.y # -30
var str = start.x # + 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (direction > -PI && direction < 0) : direction -= PI
	#angle = abs(round(180/PI * (direction)))
	dir = Vector2(cos(direction), sin(direction))
	if (abs(dir.x) < 0.001) :
		dir.x = 0
	elif (abs(dir.y) < 0.001) :
		dir.y = 0
	#print(dir.x, " ", dir.y)
	#print(cos(direction))
	if (dir.x == 0 && dir.y > 0):
		var temp = projectile_a
		projectile_a = projectile_b
		projectile_b = temp
	elif (dir.x == 0 && dir.y < 0) :
		var temp = projectile_a
		projectile_a = projectile_b
		projectile_b = -temp
	elif (dir.x < 0 && dir.y == 0) :
		projectile_a *= -1
		var temp = st
		st = str
		str = temp
	self.rotate(direction)
	$AnimatedSprite2D.play_backwards()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$Sprite2D.rotate($Sprite2D.rotation + delta)
	var x = dir.x
	var y = dir.y
	if !first:
		if (-projectile_a > self.position.x):
			self.position.x = clamp(self.position.x+(delta*200), 0, projectile_a)
		else:
			first = true
	
	#if rn :
		#num = 
	
	if !second && first:
		if !s1:
			#if (st-30 < self.position.y):
				#self.position.x += 5
				#self.position.y -= pow((self.position.x), 2) / 8000.0
				#self.position.x += pow((num), 2) / 1000.0
#could try velocity
			print(start.y-30 < self.position.y, " ", dir.x, " ", dir.y)
			if (dir == Vector2(-1,0) && st- 30 < self.position.y):
				print("hi")
				self.position += Vector2(num * circumference / 10, -(1-num) * circumference  / 10)
			elif (dir == Vector2(0, 1) && st-30 < self.position.y) :
				self.position += Vector2(-(1-num) * circumference / 10, num * circumference  / 10)
			elif (dir == Vector2(0, -1) && st-30 < self.position.y):
				self.position += Vector2((1-num) * circumference / 10, num * circumference  / 10)
			elif (dir == Vector2(1, 0) && str-60 < self.position.x):
				print("hi", self.position.y)
				self.position += Vector2(-num * circumference / 10, (1-num) * circumference  / 10)
				
			else: 
				s1 = true
				rn = true
			num -= delta 
			if (num < 0): num = 0
		if !s2 && s1:
			#if (str+60 < self.position.x):
				#self.position.x -= 
				#self.position.y -= pow((self.position.x), 1.5) / 500.0
			if (dir == Vector2(-1,0) && str+60 < self.position.x):
				self.position += Vector2(-num * circumference / 10, -(1-num) * circumference  / 10)
			elif (dir == Vector2(0, 1) && st-30 < self.position.y) :
				print("hi", self.position.y)
				self.position += Vector2(-(1-num) * circumference / 10, -num * circumference  / 10)
			elif (dir == Vector2(0, -1) && st-30 < self.position.y):
				print("hi", self.position.y)
				self.position += Vector2((1-num) * circumference / 10, -num * circumference  / 10)
			elif (dir == Vector2(1, 0) && st + 60 > self.position.y):
				print("hi", self.position.y)
				self.position += Vector2(-(1-num) * circumference / 10, (num) * circumference  / 10)
			else:
				s2 = true
				second = true
			num += delta 
			if (num > 1): 
				num = 1
	
	if second && first && !third:
		if self.position.x != start.x && self.position.y != start.y && !t1:
			self.position = Vector2(move_toward(self.position.x, start.x, 3), move_toward(self.position.y, start.y, 3))
			
		else :
			t1 = true
			#print(Fpjglobal.player_position)
			self.position = Vector2(move_toward(self.position.x, Fpjglobal.player_position.x, 10), move_toward(self.position.y, Fpjglobal.player_position.y, 10))
			if self.position == Fpjglobal.player_position:
				queue_free()
		#if (self.position >= Vector2(0, 0)):
			#self.position = Vector2(0,0)
		#print(self.position)
	
