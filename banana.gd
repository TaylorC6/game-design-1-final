extends Node2D

var projectile_a = 5
var projectile_b = 2

var first = false
var second = false
var s1 = false
var s2 = false
var third = false
var num = 0.0002

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !first:
		if (projectile_a < self.position.x):
			self.position.x = clamp(self.position.x+(delta*10), 0, projectile_a)
		else:
			first = true
	
	if !second && first:
		if !s1:
			if (projectile_b < self.position.y):
				self.position.x -= num * 5
				self.position.y += num * 2
			num *= num
	
