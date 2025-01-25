extends CharacterBody2D
 
var speed = 800  # move speed
var mousePos = null # null means nothing, so the mousePos is still not defined until the mouse is left-clicked
var anim = false
var StartDistance = 0.0
var RemainDistance = 0.0
var time = 0.0
var startPos = self.global_position

func _input(event):
	if event.is_action_pressed("ui_left"): # detects if the mouse was left-clicked
		mousePos = get_global_mouse_position()
		StartDistance = position.distance_to(mousePos)
		
		startPos = self.global_position
		print(time)
		print(startPos)
		print(mousePos)

 
func _physics_process(_delta):
	var slowdown = (RemainDistance / StartDistance)
	if mousePos:
		RemainDistance = position.distance_to(mousePos)
		if slowdown >= 0.3:
			velocity = position.direction_to(mousePos) * (speed * slowdown)# move to the mouse pointer
			time = StartDistance / (speed * slowdown)
		else:
			velocity = position.direction_to(mousePos) * speed * 0.3
			time = StartDistance / (speed * 0.3)
		#		if RemainDistance / StartDistance:
			# don't move it the mouse pointer if it was too close to the player
			# distanceto 1.0 end 0.0 multiplier of speed currently
			# 
			#velocity = Vector2.ZERO
		if position.distance_to(mousePos) < 10: # don't move it the mouse pointer if it was too close to the player
			velocity = Vector2.ZERO
		move_and_slide()
	
	if velocity != Vector2(0,0):
		anim = true
	else:
		anim = false

	var a = ""
	if anim:
		a = "spin"
	else:
		a = "idle"
	$AnimatedSprite2D.animation = a
	$AnimatedSprite2D.play()

	
