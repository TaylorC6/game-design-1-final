extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Fpjglobal.enemies["moving_slime"]):
		$AnimatedSprite2D.play("Stone_Open")
		await $AnimatedSprite2D.animation_finished
		queue_free()
