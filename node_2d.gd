extends Node2D

# Speed should change based on distance
# Should be min and max distances

var speed = 8 # move speed
var mousePos = null # null means nothing, so the mousePos is still not defined until the mouse is left-clicked
var StartDistance = 0.0 # Distance to mouse on click
var RemainDistance = 0.0
var time = 0.0
var startPos = self.global_position
var midpoint = Vector2(0,0) #Center of the ellipse
@onready var Mid: Node2D = $"."
@onready var Banana: AnimatedSprite2D = $Banana

var min_scale = Vector2(0.6, 0.6)


#var center := Vector2(400, 300)  # Center of the ellipse
var radius_x := 0  # Horizontal radius
var radius_y := 0  # Vertical radius
var angle := 0.0  # Current angle in radians
var rotated_position := Vector2.ZERO
var rotation_angle := 0.0
var has_completed_revolution := false
#var speed := 1.0  # Speed of movement


func _ready() -> void:
	#Mid.global_position = self.global_position
	Banana.global_position = self.global_position
	#Banana.visible = false
	

func _input(event: InputEvent):
	boom(event)
	#if event.is_action_pressed("lmb_pressed"): # detects if the mouse was left-clicked
		#mousePos = get_global_mouse_position()
		#StartDistance = position.distance_to(mousePos)
		#Mid.set_scale(Vector2(1.0, 1.0))
		##Banana.set_scale(Vector2(17.789, 17.789))
		##midpoint = get_local_mouse_position() / 2
		#
		##Mid.global_position = self.global_position
		##Mid.global_position = to_global(midpoint)
		##Mid.set_rotation(get_global_mouse_position().angle_to_point(position))
		#
##
	#if event is InputEventMouseButton and event.pressed:
		#min_scale = $"../scale_slider".value
		#$"../scale".text = str(min_scale)
		##$"../rotation".text = str(Mid.rotation_degrees)


func boom(event):
	if event.is_action_pressed("lmb_pressed"): # detects if the mouse was left-clicked
		Banana.visible = true
		#$Mid/Banana.play()
		mousePos = get_global_mouse_position()
		StartDistance = position.distance_to(mousePos) # Distance from original point to mouse click
		#Mid.set_scale(Vector2(1.0, 1.0))
		#Banana.set_scale(Vector2(17.789, 17.789))
		midpoint = get_local_mouse_position() / 2
		#
		#Mid.global_position = self.global_position
		#Mid.global_position = to_global(midpoint)
		#Mid.set_rotation(get_global_mouse_position().angle_to_point(position)) 
		rotation_angle = get_global_mouse_position().angle_to_point(position) # angle when mouse clicked
		angle = 0 # Player angle
		radius_x = StartDistance / 2.0
		radius_y = StartDistance / 4.0
		has_completed_revolution = false
		#Banana.global_position = self.global_position
		
		
			# Set the position of the moving object
		#while rotation_angle
		
		
		#var scale_up = 1.01
		#var scale_down = 0.99
		
		#var direction = Mid.global_position - global_position  # Calculate direction vector
		#direction = direction.normalized()  # Normalize to get a unit vector
		#
		#for sec in range(4):
			#for deg in range(50):
				#Mid.rotate(deg_to_rad(1.8))
				#Banana.rotate(deg_to_rad(-1.8))
				#await get_tree().create_timer(0.001).timeout
				##Banana.translate(direction * -2.5)  # Move towards target  # Adjust speed as needed
#
				#var scale_up = 1.00715888536
				#var scale_down = 0.992892
				#
				#
				#if sec == 1 or sec == 3:
					##if deg <= 6.5:
					##if Mid.scale.x <= min_scale:
					#Mid.scale *= scale_up
					#Banana.scale *= scale_down
				#else:
				##if deg <= 43.5:
				##if Mid.scale.x >= min_scale:
					#Mid.scale *= scale_down
					#$Mid/Banana.scale *= scale_up


#func _process_process(delta):
	
func _physics_process(delta):
	# Parametric equations for an ellipse
	var local_position = Vector2(
	radius_x * cos(angle),
	radius_y * sin(angle)
	)

	if not has_completed_revolution:
		angle += speed * delta  # Update angle
	
	if angle >= TAU:
		angle = 0  # Reset angle to 0 for the next revolution
		has_completed_revolution = true  # Stop the movement
	
	var transformed = Transform2D(rotation_angle, Vector2.ZERO)
	rotated_position = transformed * local_position
	# Rotate the point using a 2D transformation
	
	if not has_completed_revolution:
		Banana.position = midpoint + rotated_position
		Banana.animation = "default"
		Banana.play()
	else:
		Banana.visible = false
	
	print("pos  ", Banana.position)
	print("ang  ", angle)
	
	
	
	#tester()
	#print("Running")
	#print(Mid.scale)
	#var slowdown = (RemainDistance / StartDistance)
	#if mousePos:
		
		
		#RemainDistance = position.distance_to(mousePos)
		#if slowdown >= 0.3:
			#velocity = position.direction_to(mousePos) * (speed * slowdown)# move to the mouse pointer
			#time = StartDistance / (speed * slowdown)
		#else:
			#velocity = position.direction_to(mousePos) * speed * 0.3
			#time = StartDistance / (speed * 0.3)
			##if RemainDistance / StartDistance:
		 	##don't move it the mouse pointer if it was too close to the player
			 ##distanceto 1.0 end 0.0 multiplier of speed currently
			##velocity = Vector2.ZERO
			
		#if position.distance_to(mousePos) < 5: # don't move it the mouse pointer if it was too close to the player
			#velocity = Vector2.ZERO
		
		#move_and_slide()

#func tester():
	#var _t = true
	#$"../Sprite2D2".rotation = Banana.position.x
	#await get_tree().create_timer(1).timeout
