extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("Stone_Closed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Fpjglobal.ppp["pressure_plate"] && Fpjglobal.ppp["pressure_plate2"]):
		$AnimatedSprite2D.play("Stone_Open")
		await $AnimatedSprite2D.animation_finished
		queue_free()
