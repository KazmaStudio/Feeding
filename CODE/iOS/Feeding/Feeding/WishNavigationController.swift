//
//  WishNavigationController.swift
//  Feeding
//
//  Created by ZHAOCHENJUN on 2017/5/3.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import UIKit

class WishNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
		let storyBoard = UIStoryboard.init(name: VC_NAME_WISH_LIST_MAP, bundle: nil)
		let viewController = storyBoard.instantiateViewController(withIdentifier: VC_NAME_WISH_LIST_MAP)
		self.pushViewController(viewController, animated: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
