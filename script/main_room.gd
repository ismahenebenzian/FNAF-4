extends Control


@onready var overlay = $DarkOverlay

var can_change_scene = true
var interaction_disabled = true

func _ready():
	print("Scène main_room prête")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	await get_tree().create_timer(1.0).timeout
	interaction_disabled = false
	print("Interactions activées")

func _process(_delta):
	var mouse = get_viewport().get_mouse_position()
	var screen_size = get_viewport_rect().size

	if screen_size.x > 0 and screen_size.y > 0:
		var uv = mouse / screen_size
		overlay.material.set_shader_parameter("light_pos", uv)

	if can_change_scene and not interaction_disabled and mouse.y >= screen_size.y - 30:
		can_change_scene = false
		print("Retour main_room")
		get_tree().change_scene_to_file("res://scenes/main_room.tscn")

# ---------- Porte Gauche ----------
func _on_zone_porte_gauche_input_event(_viewport, event, _shape_idx):
	if interaction_disabled:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Porte gauche cliquée !")
		get_tree().change_scene_to_file("res://scenes/left_door.tscn")

# ---------- Porte Droite ----------
func _on_zone_porte_droite_input_event(_viewport, event, _shape_idx):
	if interaction_disabled:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		print("Porte droite cliquée !")
		get_tree().change_scene_to_file("res://scenes/right_door.tscn")

# ---------- Armoire ----------
func _on_zone_armoire_input_event(_viewport, event, _shape_idx):
	if interaction_disabled:
		return
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Armoire cliquée !")
		get_tree().change_scene_to_file("res://scenes/closet.tscn")

# ---------- Lit ----------
func _on_zone_lit_mouse_entered():
	if interaction_disabled:
		return
	print("Survol du lit")
	get_tree().change_scene_to_file("res://scenes/bed.tscn")
