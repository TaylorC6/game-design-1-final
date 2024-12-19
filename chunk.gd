extends Area2D

var speed = 10.0
var death = 1.0
var dir = Vector2(1, 1);
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position += (dir * Vector2(speed, speed))
	death -= delta
	if death <= 0:
		queue_free()
	pass
