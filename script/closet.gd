extends Control

@onready var floor_effect = $FloorEffect
@onready var main_interface = $MainInterface
@onready var dark_overlay = $MainInterface/DarkOverlay
@onready var porte_gauche = $MainInterface/Porte_gauche
@onready var porte_droite = $MainInterface/Porte_droite
@onready var sol_armoir = $MainInterface/sol_armoir
@onready var fond_noir = $MainInterface/FondNoir

var torch_on = false
var armoire_ouverte = true

var pos_gauche_ouverte = Vector2(-130, 0)
var pos_droite_ouverte = Vector2(130, 0)
var pos_gauche_fermee = Vector2(-550, 0)
var pos_droite_fermee = Vector2(550, 0)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	floor_effect.visible = true
	main_interface.visible = false
	floor_effect.scale = Vector2(1, 1)
	
	var tween = create_tween()
	tween.tween_property(floor_effect, "scale", Vector2(3, 3), 3.0)
	await tween.finished
	
	floor_effect.visible = false
	main_interface.visible = true
	
	# Initialisation
	porte_gauche.position = pos_gauche_ouverte
	porte_droite.position = pos_droite_ouverte
	sol_armoir.visible = false
	
	fond_noir.visible = true
	fond_noir.color = Color(0, 0, 0, 1)  
	
	update_torch()

func _input(event):
	if event is InputEventKey and event.keycode == KEY_SPACE:
		torch_on = event.pressed
		update_torch()
		sol_armoir.visible = torch_on
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and armoire_ouverte:
			armoire_ouverte = false
			print("Portes FERMÉES")
			var tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(porte_gauche, "position", pos_gauche_fermee, 0.2)
			tween.tween_property(porte_droite, "position", pos_droite_fermee, 0.2)
		elif not event.pressed and not armoire_ouverte:
			armoire_ouverte = true
			print("Portes OUVERTES")
			var tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(porte_gauche, "position", pos_gauche_ouverte, 0.2)
			tween.tween_property(porte_droite, "position", pos_droite_ouverte, 0.2)

func update_torch():
	if dark_overlay:
		dark_overlay.material.set_shader_parameter("torch_on", torch_on)

func _on_return_zone_mouse_entered():
	get_tree().change_scene_to_file("res://scenes/MainRoom.tscn")
