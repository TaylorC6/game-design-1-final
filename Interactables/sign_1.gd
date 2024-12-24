extends Node2D

func in_range(player) -> bool:
	return $StaticBody2D/Area2D.overlaps_body(player)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Fpjglobal.process(_delta)
	
		
	pass
