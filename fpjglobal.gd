extends Node

var coorx = 0
var coory = 0
var player_names = {"Girl": "yippie","Boy": "Jimmy"}
var player_position = Vector2(0, 0)
var player_direction = Vector2(0, 1)
var camera = preload("res://Players/player_boy.tscn").instantiate().get_child(2)
#var player = load("res://Players/player_boy.tscn")
var current = player_names.get("Boy")
var glow = false
var stairsOpen = false
var doorOpen = false
var nogear = true
var noweapons = true
var firstframe = 1
var e = ""
var glow_shader = preload("res://Shaders/Glow.tres")
var message_box_visible = false
var message = ""
var strings = ["Grab your gear to prepare for the challenges ahead!", "lives here!"]
@export var area = ""
enum  STATES { IDLE=0, DEAD, DAMAGED, ATTACKING, CHARGING }
var data = {
	"max_health": 100.0,  # 20hp per heart, 5 per fraction
	"health": 100.0,      # Min 60 Max 400
	"money": 0,
	"state": STATES.IDLE,
	"secondaries": [],
	}

var ppp = {
	"pp1" = false,
	"pp2" = false
}
##get_tree().get_current_scene().get_node("y-sort").get_node("Player_Boy").get("entity").set_visible(true)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func process(_delta: float) -> void:
	#print(camera)

func glow_area(use_area: Area2D):
	return use_area.overlaps_body(get_tree().get_current_scene().get_node("y-sort").get_node("Player_Boy"))


func switch():
	if (current == player_names.get("Girl")):
		current = player_names.get("Boy")
		
	elif (current == player_names.get("Boy")) :
		current = player_names.get("Girl")
		
		#get_tree().get_current_scene().get_node("THE_WINDOW").scale *= -1
		print(get_tree().get_current_scene())
		if get_tree().get_current_scene().get_name() == "level_2":
			get_tree().get_current_scene().get_node("THE_WINDOW").scale *= -1


func switchop(dif):
	#camera.set_enabled(false)
	dif.set_enabled(true)
	if camera != null:
		camera.set_enabled(false)
	camera = dif
	#camera = dif

func set_cords(coorx, coory):
	self.coorx = coorx
	self.coory = coory

func get_cords():
	var corx = coorx
	var cory = coory
	coorx = 0
	coory = 0
	return Vector2(corx, cory)

func set_player(body):
	data = body
	

func nowep():
	noweapons = false

func noger():
	nogear = false
