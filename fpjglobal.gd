extends Node

var glow = false
var stairsOpen = false
var firstframe = 1
var e = ""
var glow_shader = preload("res://Shaders/Glow.tres")
@export var area = ""

##get_tree().get_current_scene().get_node("y-sort").get_node("Player_Boy").get("entity").set_visible(true)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(_delta: float) -> void:
	pass

func glow_area(use_area: Area2D):
	return use_area.overlaps_body(get_tree().get_current_scene().get_node("y-sort").get_node("Player_Boy"))
