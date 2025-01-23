extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Fpjglobal.ppp["pressure_plate16"] && Fpjglobal.ppp["pressure_plate22"]):
		$AnimatedSprite2D.play("Stone_Open")
		await $AnimatedSprite2D.animation_finished
		queue_free()
