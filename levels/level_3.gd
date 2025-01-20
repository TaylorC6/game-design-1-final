extends Node2D

@onready var aud_player = $Node2D/AudioStreamPlayer
@onready var des = preload("res://Sounds/Desert_1.mp3")
func _ready() -> void:
	aud_player.stream = des
	aud_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
