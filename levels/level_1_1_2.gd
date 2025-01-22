extends Node2D

@onready var aud_player = $Node2D/AudioStreamPlayer
@onready var sus = preload("res://Sounds/Suspense_1.mp3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aud_player.stream = sus
	aud_player.play()
	$"y-sort/Player_Boy".noweapons = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Fpjglobal.doorOpen == true or Fpjglobal.GirldoorOpen == true:
		$Door/DoorBarrier/CollisionShape2D.disabled = true
		$Door/DoorBarrier2/CollisionShape2D.disabled = true
	pass
