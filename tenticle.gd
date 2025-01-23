extends Area2D

var damage = 20
var knockback = 50
var first = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("pre_anim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if first:
		await $AnimatedSprite2D.animation_finished
		first = false
		$AnimatedSprite2D.play("default")
	else:
		for player in get_tree().get_nodes_in_group("Enemy"):
			if self.overlaps_body(player):
				$CollisionShape2D.disabled = true
				#self.position = Vector2(move_toward(self.position.x, start.x + (50 * player_direction.x), velocity), move_toward(self.position.y, start.y + (30 * player_direction.y), velocity))
				#$AnimatedSprite2D.play("Pinapple_Explosion")
				player.take_damage(damage, self)
				var dist = (player.global_position-self.global_position)
				player.inertia = dist.normalized() * knockback
		if $AnimatedSprite2D.frame_progress == 1:
			queue_free()
	pass
