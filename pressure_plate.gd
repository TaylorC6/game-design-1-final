extends Node2D

var play
var first = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for player in get_tree().get_nodes_in_group("Player"):
		if $Area2D.overlaps_body(player) && first:
				$AnimatedSprite2D.animation = "new_animation"
				Fpjglobal.ppp[self.name] = true
				play = player
				first = false
		if play == player:
			if $Area2D.overlaps_body(player):
				$AnimatedSprite2D.animation = "new_animation"
				Fpjglobal.ppp[self.name] = true
				play = player
			else:
				$AnimatedSprite2D.animation = "default"
				
	
	pass



func _on_area_2d_area_entered(area: Area2D) -> void:
	#change sprite to lower
	#activates door
	pass
