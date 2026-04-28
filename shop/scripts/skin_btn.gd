extends Button

var main = load("res://shop/scripts/shop.gd").new()
var dc = load("res://game/scripts/db_control.gd").new()

var player_name = dc.select("INFO.in", "name")
var player_skins = dc.select("DB/%s.in" %[player_name], "skins")

func _ready():
	print(self["name"])
	updater( int(get_tooltip()) )

func updater(skin_id):
	var skin_name = main.skins_name[skin_id]
	
	if skin_name in player_skins:
		if dc.select("DB/%s.in" %[player_name], "active_skin") == skin_name:
			set_text("Используется")
			self["custom_styles/normal"].bg_color = Color("#00c46c")
			self["custom_styles/hover"].bg_color = Color("#00c46c")
		else: 
			set_text("Использовать")
			self["custom_styles/normal"].bg_color = Color("#009ac4")
			self["custom_styles/hover"].bg_color = Color("#009ac4")
	else:
		set_text( str( main.count_skin[ skin_id - 1 ] ) )
		self["custom_styles/normal"].bg_color = Color("#c400b0")
		self["custom_styles/hover"].bg_color = Color("#c400b0")
	#if self["name"] == "skin_btn5": self["name"]["custom_style/normal"].bg_color = Color("#fff")
	#$/root/shop/skin5/skin_btn5.text = "test"

func _on_skin_btn_pressed(extra_arg: int):
	var select_skin = main.skins_name[ extra_arg ]
	var player_money = int( dc.select("DB/%s.in" %[player_name], "money") )
	
	if select_skin in player_skins:
		if dc.select("DB/%s.in" %[player_name], "active_skin") == select_skin: OS.alert('Этот скин уже установлен', 'Инвентарь')
		else:
			var previous_skin = main.skins_id[ dc.select("DB/%s.in" %[player_name], "active_skin") ]
			dc.update("DB/%s.in" %[player_name], "active_skin", select_skin)
			
			#print(previous_skin)
			#print( main.skins_id[select_skin] )
			updater( previous_skin )
			updater( int(get_tooltip()) )
	else:
		if player_money >= main.count_skin[ extra_arg ]:
			player_skins.append(select_skin)
			player_money -= main.count_skin[ extra_arg ]
			
			dc.update("DB/%s.in" %[player_name], "skins", player_skins)
			dc.update("DB/%s.in" %[player_name], "money", player_money)

			OS.alert("Поздравляем с покупкой", "Магазин")
			
		else: OS.alert("Недостаточно моенток на счету", "Баланс")

