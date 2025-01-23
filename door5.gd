extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Fpjglobal.ppp["pressure_plate7"] && Fpjglobal.ppp["pressure_plate8"]):
		Fpjglobal.ppp["pairp1"] = true
	if (Fpjglobal.ppp["pressure_plate9"] && Fpjglobal.ppp["pressure_plate10"]):
		Fpjglobal.ppp["pairp2"] = true
	if (Fpjglobal.ppp["pressure_plate11"] && Fpjglobal.ppp["pressure_plate12"]):
		Fpjglobal.ppp["pairp3"] = true
	if (Fpjglobal.ppp["pressure_plate13"] && Fpjglobal.ppp["pressure_plate14"]):
		Fpjglobal.ppp["pairp4"] = true
	if (Fpjglobal.ppp["pairp1"] == true && Fpjglobal.ppp["pairp2"] && Fpjglobal.ppp["pairp3"] && Fpjglobal.ppp["pairp4"]):
		$AnimatedSprite2D.play("Stone_Open")
		await $AnimatedSprite2D.animation_finished
		queue_free()
