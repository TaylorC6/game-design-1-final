extends Area2D

var damage    = 10
var knockback = 64.0
var anim_life = 1.0
var expl_time = 1.0


var chunk = preload("res://chunk.tscn")

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
