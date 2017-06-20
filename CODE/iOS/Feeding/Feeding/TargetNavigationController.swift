//
//  TargetNavigationController.swift
//  Feeding
//
//  Created by zhaochenjun on 2017/6/12.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import UIKit

class TargetNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        let storyBoard = UIStoryboard.init(name: VC_NAME_TARGET_LIST_TABLE, bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: VC_NAME_TARGET_LIST_TABLE)
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
