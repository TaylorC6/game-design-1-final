extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("Desert_Closed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Fpjglobal.ppp["pressure_plate29"] && Fpjglobal.ppp["pressure_plate30"]):
		$AnimatedSprite2D.play("Desert_Open")
		await $AnimatedSprite2D.animation_finished
		queue_free()
