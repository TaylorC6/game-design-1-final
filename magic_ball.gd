extends Area2D

var damage = 15
var knockback = 10
var destroy = 10
var start = self.global_position
var velocity = 1.0
var dir = Vector2(0, 0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	for player in get_tree().get_nodes_in_group("Player"):
		if self.overlaps_body(player):
			$CollisionShape2D.disabled = true
			#self.position = Vector2(move_toward(self.position.x, start.x + (50 * x), velocity), move_toward(self.position.y, start.y + (30 * y), velocity))
			#$AnimatedSprite2D.play("Pinapple_Explosion")
			player.take_damage(damage)
			var dist = (player.global_position-self.global_position)
			player.inertia = dist.normalized() * knockback
			queue_free()
	self.position = Vector2(move_toward(self.position.x, start.x + (500 * dir.x), abs(velocity * dir.x)), move_toward(self.position.y, start.y + (500 * dir.y), abs(velocity * dir.y)))
	if destroy <= 0.0:
		queue_free()
	destroy -= delta
	pass
