extends Area2D

var speed = 150.0
var death = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_toward(0, 15, delta)
	death -= delta
	if death < 0:
		queue_free()
	pass
