extends Node2D

@onready var aud_player = $Node2D/AudioStreamPlayer
@onready var sus = preload("res://Sounds/Suspense_1.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aud_player.stream = sus
	aud_player.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Fpjglobal.stairsOpen == true:
		$Stairs/StairsBarrier/CollisionShape2D.disabled = true
	pass
