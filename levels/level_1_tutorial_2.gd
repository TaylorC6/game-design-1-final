extends Node2D

@onready var aud_player = $Node2D/AudioStreamPlayer
@onready var ins = preload("res://Sounds/Inspirational_1.mp3")
@onready var girl = preload("res://Players/player_girl.tscn")
#@onready var cat = preload("res://Sounds/oo-ee-a-ea-101soundboards.mp3")

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	
	#aud_player.stream = cat
	#aud_player.pitch_scale /= 5
	#aud_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
