extends Control

@onready var floor_effect = $FloorEffect
@onready var main_interface = $MainInterface
@onready var dark_overlay = $MainInterface/Zoom_Porte_droite/DarkOverlay
@onready var door_sprite = $MainInterface/Zoom_Porte_droite/DoorSprite
@onready var fond_couloir = $MainInterface/Zoom_Porte_droite/FondCouloir
@onready var son_souffle = $SonSouffle

var tex_normal = preload("res://assets/images/Zoom_Porte_Droite.png")
var tex_loin   = preload("res://assets/images/monstre_couloir_droite_loin.png")

var torch_on = false
var is_returning = false
var door_is_closed = false
var can_interact = false
var porte_tenue_timer : float = 0.0
var porte_tenue_active : bool = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	door_sprite.visible = false
	floor_effect.visible = true
	main_interface.visible = false
	floor_effect.scale = Vector2(1, 1)

	var tween = create_tween()
	tween.tween_property(floor_effect, "scale", Vector2(3, 3), 3.5)
	await tween.finished

	floor_effect.visible = false
	main_interface.visible = true
	door_is_closed = false

	await get_tree().create_timer(0.2).timeout
	can_interact = true
	update_torch()
	_update_visuel_monstre()

func _process(delta):
	_update_visuel_monstre()
	_update_son_souffle()

	if porte_tenue_active and door_is_closed:
		porte_tenue_timer += delta
		if porte_tenue_timer >= 3.0:
			porte_tenue_active = false
			porte_tenue_timer = 0.0
			MonstreManager.retour_spawn()

func _input(event):
	if event is InputEventKey and event.keycode == KEY_SPACE:
		torch_on = event.pressed
		update_torch()
		if torch_on and MonstreManager.etat == MonstreManager.Etat.COULOIR_DROITE_LOIN:
			MonstreManager.retour_spawn()
		elif torch_on and MonstreManager.etat == MonstreManager.Etat.COULOIR_DROITE_DEVANT:
			get_tree().change_scene_to_file("res://scenes/screamer.tscn")

	if not can_interact:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and not door_is_closed:
			door_is_closed = true
			door_sprite.visible = true
			door_sprite.position = Vector2(-100, 0)
			var tween = create_tween()
			tween.tween_property(door_sprite, "position", Vector2(0, 0), 0.2)
			if MonstreManager.etat == MonstreManager.Etat.COULOIR_DROITE_DEVANT:
				porte_tenue_active = true
				porte_tenue_timer = 0.0

		elif not event.pressed and door_is_closed:
			door_is_closed = false
			porte_tenue_active = false
			porte_tenue_timer = 0.0
			var tween = create_tween()
			tween.tween_property(door_sprite, "position", Vector2(-100, 0), 0.2)
			await tween.finished
			door_sprite.visible = false

func _update_visuel_monstre():
	if MonstreManager.etat == MonstreManager.Etat.COULOIR_DROITE_LOIN:
		fond_couloir.texture = tex_loin
	else:
		fond_couloir.texture = tex_normal

func _update_son_souffle():
	var devant = MonstreManager.etat == MonstreManager.Etat.COULOIR_DROITE_DEVANT
	if devant and not son_souffle.playing:
		son_souffle.play()
	elif not devant and son_souffle.playing:
		son_souffle.stop()

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
