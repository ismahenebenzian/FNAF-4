extends Control

@onready var floor_effect = $FloorEffect
@onready var main_interface = $MainInterface
@onready var dark_overlay = $MainInterface/Zoom_Porte_droite/DarkOverlay
@onready var door_sprite = $MainInterface/Zoom_Porte_droite/DoorSprite

var torch_on = false
var is_returning = false
var door_is_closed = false
var can_interact = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	floor_effect.visible = true
	main_interface.visible = false
	floor_effect.scale = Vector2(1, 1)
	
	var tween = create_tween()
	tween.tween_property(floor_effect, "scale", Vector2(3, 3), 3.5)
	await tween.finished
	
	floor_effect.visible = false
	main_interface.visible = true
	
	door_sprite.visible = false
	door_is_closed = false
	print("🚪 Porte droite ouverte au départ")
	
	await get_tree().create_timer(0.2).timeout
	can_interact = true
	update_torch()

func _input(event):
	if event is InputEventKey and event.keycode == KEY_SPACE:
		torch_on = event.pressed
		update_torch()
	
	if not can_interact:
		return
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and not door_is_closed:
			door_is_closed = true
			print("🚪 Porte droite FERMÉE")
			door_sprite.visible = true
			door_sprite.position = Vector2(-100, 0)
			var tween = create_tween()
			tween.tween_property(door_sprite, "position", Vector2(0, 0), 0.2)
			
		elif not event.pressed and door_is_closed:
			door_is_closed = false
			print("🚪 Porte droite OUVERTE")
			var tween = create_tween()
			tween.tween_property(door_sprite, "position", Vector2(-100, 0), 0.2)
			await tween.finished
			door_sprite.visible = false

func update_torch():
	if dark_overlay:
		dark_overlay.material.set_shader_parameter("torch_on", torch_on)

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
