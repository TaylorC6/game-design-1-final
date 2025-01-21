extends Area2D

var damage    = 50
var knockback = 64.0
var anim_life = 1.0
var expl_time = 1.0
var velocity = 2
var player_direction = Fpjglobal.player_direction
var start = Vector2(0, 0)

var chunk = preload("res://chunk.tscn")
func _ready() -> void:
	start = self.global_position

func explode():
	#for i in range(16):
		#var t = chunk.instantiate()
		#t.dir = Vector2()
		#t.rotate(i)
		#t.global_position = self.global_position
		#add_child(t)
	
	pass

func _process(delta: float) -> void:
	expl_time -= delta
	for enemy in get_tree().get_nodes_in_group("Enemy"):
		if self.overlaps_body(enemy):
			$CollisionShape2D.disabled = true
			self.position = Vector2(move_toward(self.position.x, start.x + (50 * player_direction.x), velocity), move_toward(self.position.y, start.y + (30 * player_direction.y), velocity))
			$AnimatedSprite2D.play("Pinapple_Explosion")
			enemy.take_damage(damage, self)
			var dist = (enemy.global_position-self.global_position)
			enemy.inertia = dist.normalized() * knockback
			await get_tree().create_timer(.9).timeout
			queue_free()
	self.position = Vector2(move_toward(self.position.x, start.x + (50 * player_direction.x), velocity), move_toward(self.position.y, start.y + (30 * player_direction.y), velocity))
	if expl_time <= 0.0:
		$AnimatedSprite2D.play("Pinapple_Explosion")
		#await $AnimatedSprite2D.animation_finished
		for enemy in get_tree().get_nodes_in_group("Enemy"):
			if self.overlaps_body(enemy):
				enemy.take_damage(damage, self)
				var dist = (enemy.global_position-self.global_position)
				enemy.inertia = dist.normalized() * knockback
		await get_tree().create_timer(.9).timeout
		queue_free()
	
	pass
