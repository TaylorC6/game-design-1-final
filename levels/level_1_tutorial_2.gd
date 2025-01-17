extends Node2D

@onready var aud_player = $Node2D/AudioStreamPlayer
@onready var ins = preload("res://Sounds/Inspirational_1.mp3")
@onready var girl = preload("res://Players/player_girl.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	aud_player.stream = ins
	aud_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
