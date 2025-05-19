extends Node

const MOD_DIR := "nami-NoIntro" # Name of the directory that this file is in
const LOG_NAME := "nami-NoIntro:Main" # Full ID of the mod (AuthorName-ModName)

var mod_dir_path := ""
var extensions_dir_path := ""

func _init() -> void:
	mod_dir_path = ModLoaderMod.get_unpacked_dir().path_join(MOD_DIR)
	
	install_script_hook_files()

func install_script_hook_files() -> void:
	extensions_dir_path = mod_dir_path.path_join("extensions")
	ModLoaderMod.add_hook(skip_fall, "res://scenes/falling_scene/falling_scene.gd", "_ready")

func _ready() -> void:
	pass

func skip_fall(chain: ModLoaderHookChain) -> void:
	chain.execute_next()
	var player = Util.get_player()
	player.stats.max_hp = player.stats.character.starting_laff
	player.stats.hp = player.stats.character.starting_laff
	var main_node := chain.reference_object
	main_node.end_scene()
