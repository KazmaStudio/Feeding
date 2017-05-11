//
//  ArticleViewController.swift
//  Feeding
//
//  Created by zhaochenjun on 2017/5/8.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UIScrollViewDelegate, UIWebViewDelegate {
    
    @IBOutlet weak var layoutConstraintVisualViewBottomHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTopHeight: NSLayoutConstraint!
    @IBOutlet weak var webViewMain: UIWebView!
    @IBOutlet weak var visualEffectViewTop: UIVisualEffectView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var layoutConstraintVisualEffectViewBottomBottom: NSLayoutConstraint!
    var scrollViewOffsetY = CGFloat(INT_0)
    var visualViewTopHeight = CGFloat(INT_0)
    let viewTopMinHeight = UIApplication.shared.statusBarFrame.height
    let labelTitleMaxFontSize = CGFloat(INT_16)
    let labelTitleMinFontSize = CGFloat(INT_12)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isStatusBarHidden = true
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        labelTitle.text = "这是个新标题，一个中文标题。这而且是个很长很长的标题，换行，换行，继续换行。超长的标题，又要换行了"
        webViewMain.loadRequest(URLRequest.init(url: URL.init(string: "https://www.mapbox.com")!))
        webViewMain.scrollView.delegate = self
        webViewMain.delegate = self
        scrollViewOffsetY = -(self.navigationController?.navigationBar.frame.height)!
        visualViewTopHeight = viewTopHeight.constant
        webViewMain.scrollView.contentInset = UIEdgeInsets.init(top: visualViewTopHeight * 2, left: CGFloat(INT_0), bottom: layoutConstraintVisualViewBottomHeight.constant - viewTopMinHeight, right: CGFloat(INT_0))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        UIApplication.shared.isStatusBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        if(self.tabBarController?.tabBar.isHidden)!{
            layoutConstraintVisualEffectViewBottomBottom.constant = CGFloat(INT_0)
        }else{
            layoutConstraintVisualEffectViewBottomBottom.constant = CGFloat(-TAB_BAR_HEIGHT)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((visualViewTopHeight - scrollView.contentOffset.y) >= viewTopMinHeight + visualViewTopHeight + viewTopMinHeight){
            viewTopHeight.constant = -scrollView.contentOffset.y - viewTopMinHeight
            if ((labelTitleMaxFontSize - (visualViewTopHeight - viewTopHeight.constant)) <= labelTitleMinFontSize){
                labelTitle.font = UIFont.boldSystemFont(ofSize: labelTitleMinFontSize)
            }else if ((labelTitleMaxFontSize - (visualViewTopHeight - viewTopHeight.constant)) > labelTitleMaxFontSize){
                labelTitle.font = UIFont.boldSystemFont(ofSize: labelTitleMaxFontSize)
            }else{
                labelTitle.font = UIFont.boldSystemFont(ofSize: labelTitleMaxFontSize - (visualViewTopHeight-viewTopHeight.constant))
            }
        }else{
            viewTopHeight.constant = viewTopMinHeight
        }
        self.webViewMain.scrollView.scrollIndicatorInsets = UIEdgeInsets.init(top: viewTopHeight.constant + viewTopMinHeight, left: CGFloat(INT_0), bottom: layoutConstraintVisualViewBottomHeight.constant - viewTopMinHeight, right: CGFloat(INT_0))
    }
    
    @IBAction func buttonBackTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
