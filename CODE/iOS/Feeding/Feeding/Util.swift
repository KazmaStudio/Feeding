//
//  Util.swift
//  Feeding
//
//  Created by zhaochenjun on 2017/6/5.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import Foundation
import UIKit

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

func showTip(text : String){
    let window = UIApplication.shared.keyWindow
    let tempLabel = window?.viewWithTag(TAG_TIP_VIEW)
    if ((tempLabel) != nil){
        UIView.animate(withDuration: 0.3, animations: {
            let addedLabel = window?.viewWithTag(TAG_TIP_VIEW)
            addedLabel?.alpha = 0
        }, completion: {finished in
            tempLabel?.removeFromSuperview()
        })
    }
    let label = UILabel.init()
    label.tag = TAG_TIP_VIEW
    label.backgroundColor = RGBA(r: 0, g: 0, b: 0, a: 0.8)
    label.clipsToBounds = true
    label.layer.cornerRadius = 8
    label.textAlignment = .center
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: CGFloat(INT_14))
    label.text = text
    label.sizeToFit()
    label.alpha = 0
    let tempWidth = ((label.frame.size.width < 100) ? 100 : label.frame.size.width) + 16
    let labelWidth = (tempWidth > (SCREEN_WIDTH - 32)) ? (SCREEN_WIDTH - 32) : tempWidth
    let labelHeight = label.frame.size.height + 16
    label.frame = CGRect.init(x: (SCREEN_WIDTH - labelWidth) / 2, y: SCREEN_HEIGHT - TAB_BAR_HEIGHT - labelHeight - CGFloat(INT_16), width: labelWidth, height: labelHeight)
    UIView.animate(withDuration: 0.3, animations: {
        window?.addSubview(label)
        label.alpha = 1
    }, completion: {finished in
        UIView.animate(withDuration: 0.3, delay: 3, options: .curveLinear, animations: {
            window?.addSubview(label)
            label.alpha = 0
        }, completion: {finished in
            label.removeFromSuperview()
        })
    })
    
}
