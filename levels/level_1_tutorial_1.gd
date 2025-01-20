extends Node2D

@onready var audio = $Node2D/AudioStreamPlayer2
@onready var aud_player = $Node2D/AudioStreamPlayer
@onready var sus = preload("res://Sounds/Suspense_1.mp3")
@onready var cat = preload("res://Sounds/oo-ee-a-ea-101soundboards.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aud_player.stream = cat
	aud_player.play()
	await get_tree().create_timer(1.5).timeout
	audio.stream = cat
	audio.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Fpjglobal.stairsOpen == true:
		$Stairs/StairsBarrier/CollisionShape2D.disabled = true
	if aud_player.playing == false:
		aud_player.play()
	if audio.playing == false:
		audio.play()
	pass
