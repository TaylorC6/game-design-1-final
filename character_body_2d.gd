extends CharacterBody2D

# Speed should change based on distance
# Should be min and max distances

var speed = 8 # move speed
var mousePos = null # null means nothing, so the mousePos is still not defined until the mouse is left-clicked
var StartDistance = 0.0 # Distance to mouse on click
var startPos = self.global_position
var midpoint = Vector2(0,0) #Center of the ellipse
@onready var Mid = $Mid
@onready var Banana = $Mid/Banana

var radius_x := 0  # Horizontal radius
var radius_y := 0  # Vertical radius
var angle := 0.0  # Current angle in radians
var rotated_position := Vector2.ZERO
var rotation_angle := 0.0
var has_completed_revolution := false

func _ready() -> void:
	#Mid.global_position = self.global_position
	Banana.global_position = self.global_position
	Banana.visible = false
	has_completed_revolution = true

func _input(event: InputEvent):
	if has_completed_revolution:
		boom(event)

func boom(event):
	if event.is_action_pressed("fire"): # detects if the mouse was left-clicked
		Banana.visible = true
		Banana.play()
		mousePos = get_local_mouse_position()
		StartDistance = position.distance_to(mousePos) # Distance from original point to mouse click
		midpoint = get_local_mouse_position() / 2
		rotation_angle = get_global_mouse_position().angle_to_point(position) # angle when mouse clicked
		angle = 0 # Player angle
		radius_x = StartDistance / 2.0
		radius_y = StartDistance / 4.0
		has_completed_revolution = false
		

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
	
	#print("pos  ", Banana.position)
	#print("ang  ", angle)
