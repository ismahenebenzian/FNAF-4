extends Control

@onready var floor_effect = $FloorEffect
@onready var main_interface = $MainInterface
@onready var dark_overlay = $MainInterface/Zoom_Lit/DarkOverlay

var torch_on = false
var is_returning = false
var can_interact = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Transition : image du sol
	floor_effect.visible = true
	main_interface.visible = false
	floor_effect.scale = Vector2(1, 1)
	
	var tween = create_tween()
	tween.tween_property(floor_effect, "scale", Vector2(3, 3), 3.5)
	await tween.finished
	
	# Affichage du lit
	floor_effect.visible = false
	main_interface.visible = true
	
	await get_tree().create_timer(0.2).timeout
	can_interact = true
	update_torch()

func _input(event):
	# Torche (Espace)
	if event is InputEventKey and event.keycode == KEY_SPACE:
		torch_on = event.pressed
		update_torch()
	
	if not can_interact:
		return

func update_torch():
	if dark_overlay:
		dark_overlay.material.set_shader_parameter("torch_on", torch_on)
		print("Torche : ", "ALLUMÉE" if torch_on else "éteinte")

# Retour à la chambre (zone basse ou bouton)
func _on_return_zone_mouse_entered():
	if is_returning:
		return
	is_returning = true
	can_interact = false
	
	main_interface.visible = false
	floor_effect.visible = true
	floor_effect.scale = Vector2(3, 3)
	
	var tween = create_tween()
	tween.tween_property(floor_effect, "scale", Vector2(1, 1), 1.5)
	await tween.finished
	
	get_tree().change_scene_to_file("res://scenes/MainRoom.tscn")
