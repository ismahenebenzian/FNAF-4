extends Control

func _ready():
	$Boutons/BoutonJouer.pressed.connect(_on_jouer)
	$Boutons/BoutonInfo.pressed.connect(_on_info)
	$Boutons/BoutonQuitter.pressed.connect(_on_quitter)
	$PanneauInfo/BoutonFermer.pressed.connect(func(): $PanneauInfo.visible = false)

func _on_jouer():
	get_tree().change_scene_to_file("res://scenes/MainRoom.tscn")

func _on_info():
	$PanneauInfo.visible = true

func _on_quitter():
	get_tree().quit()
