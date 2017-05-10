//
//  CONST.swift
//  Feeding
//
//  Created by zhaochenjun on 2017/5/4.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import Foundation
import UIKit

let EMPTY_STRING = ""
let CELL_STRING = "CELL"

let INT_0 = 0
let INT_10 = 10
let INT_12 = 12
let INT_14 = 14
let INT_16 = 16
let INT_18 = 18
let INT_20 = 20
let INT_24 = 24
let INT_32 = 32
let INT_44 = 44
let INT_64 = 64

let VC_NAME_ARTICLE_LITS_TABLE = "ArticleListTableViewController"
let VC_NAME_ARTICLE = "ArticleViewController"
let VC_NAME_WISH_LIST_MAP = "WishListMapViewController"

let CELL_ARTICLE_LIST_TYPE_A = "ArticleTypeATableViewCell"
let CELL_ARTICLE_LIST_TYPE_B = "ArticleTypeBTableViewCell"
let CELL_ARTICLE_LIST_TYPE_C = "ArticleTypeCTableViewCell"

let IMG_NAME_RECORD = "record"
let IMG_NAME_CHECKED = "checked"
let IMG_NAME_AVATAR_DEFAULT_GIRL = "avater-default-girl"
let IMG_NAME_PLACEHOLDER = "placeholder"

let ONE_PIXEL = 1 / UIScreen.main.scale
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height
let TAB_BAR_HEIGHT = 49

let COLOR_BOARD_GRAY = UIColor.init(red: 200 / 255, green: 200 / 255, blue: 220 / 255, alpha: 1)

var TAG_CELL_HIGHLIGHT_VIEW = 99901

func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor { return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a) }

func CELL_HIGHLIGHT(cell : UITableViewCell){
	let view = UIView.init(frame: CGRect(x:0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height))
	view.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0)
	view.tag = TAG_CELL_HIGHLIGHT_VIEW
	cell.contentView.addSubview(view)
	UIView.animate(withDuration: 0.2, animations: {view.backgroundColor = RGBA(r: 100, g: 100, b: 100, a: 0.1)}, completion: {(value: Bool) in })
	
}

func CELL_UNHIGHLIGHT(cell : UITableViewCell){
	let view = cell.contentView.viewWithTag(TAG_CELL_HIGHLIGHT_VIEW)
	view!.backgroundColor = RGBA(r: 100, g: 100, b: 100, a: 0.1)
	UIView.animate(withDuration: 0.2, animations: {view!.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0)}, completion: {(value: Bool) in view!.removeFromSuperview()})
}
