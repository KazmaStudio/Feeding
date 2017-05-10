//
//  ArticleListCellAuthorView.swift
//  Feeding
//
//  Created by zhaochenjun on 2017/5/4.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import UIKit

class ArticleListCellAuthorView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

	@IBOutlet var imageViewAuthorAvater: UIImageView!
	@IBOutlet var labelAuthorName: UILabel!
	@IBOutlet var imageViewTag: UIImageView!
	
	var containerView: UIView = UIView()
	
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
		self.containerView = UINib.init(nibName: String(describing: ArticleListCellAuthorView.self), bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        imageViewAuthorAvater.layer.borderWidth = ONE_PIXEL
        imageViewAuthorAvater.layer.borderColor = COLOR_BOARD_GRAY.cgColor
        self.addSubview(containerView)
    }
	
	override func layoutSubviews() {
		containerView.frame = self.bounds
		self.layoutIfNeeded()
		imageViewAuthorAvater.layer.cornerRadius = imageViewAuthorAvater.frame.width / 2
		
	}

}
