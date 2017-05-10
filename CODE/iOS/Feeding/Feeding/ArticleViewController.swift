//
//  ArticleViewController.swift
//  Feeding
//
//  Created by zhaochenjun on 2017/5/8.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var layoutConstraintVisualViewBottomHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTopHeight: NSLayoutConstraint!
    @IBOutlet weak var webViewMain: UIWebView!
    @IBOutlet weak var visualEffectViewTop: UIVisualEffectView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var layoutConstraintVisualEffectViewBottomBottom: NSLayoutConstraint!
    var scrollViewOffsetY = CGFloat(INT_0)
    var visualViewTopHeight = CGFloat(INT_0)
    let viewTopMinHeight = CGFloat(INT_20)
    let labelTitleMaxFontSize = CGFloat(INT_18)
    let labelTitleMinFontSize = CGFloat(INT_12)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitle.text = "New Title Here, It's a Long Title, Wrap Please. Wrap Wrap Wrap. More Lines, Maybe three Line. Other Line, Good Title"
        UIApplication.shared.isStatusBarHidden = true
        self.webViewMain.scrollView.contentInset = UIEdgeInsets.init(top: (self.navigationController?.navigationBar.frame.height)!, left: CGFloat(INT_0), bottom: layoutConstraintVisualViewBottomHeight.constant, right: CGFloat(INT_0))
        self.webViewMain.scrollView.scrollIndicatorInsets = UIEdgeInsets.init(top: (self.navigationController?.navigationBar.frame.height)!, left: CGFloat(INT_0), bottom: 20, right: CGFloat(INT_0))
        self.webViewMain.loadRequest(URLRequest.init(url: URL.init(string: "https://www.mapbox.com")!))
        self.webViewMain.scrollView.delegate = self
        scrollViewOffsetY = -(self.navigationController?.navigationBar.frame.height)!
        visualViewTopHeight = viewTopHeight.constant
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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
        if ((visualViewTopHeight - scrollView.contentOffset.y) >= viewTopMinHeight){
            viewTopHeight.constant = visualViewTopHeight - scrollView.contentOffset.y
            if ((labelTitleMaxFontSize - (visualViewTopHeight-viewTopHeight.constant)) > labelTitleMinFontSize && (labelTitleMaxFontSize - (visualViewTopHeight-viewTopHeight.constant)) <= labelTitleMaxFontSize){
                labelTitle.font = UIFont.boldSystemFont(ofSize: labelTitleMaxFontSize - (visualViewTopHeight-viewTopHeight.constant))
            }else if ((labelTitleMaxFontSize - (visualViewTopHeight-viewTopHeight.constant)) <= labelTitleMinFontSize){
                labelTitle.font = UIFont.boldSystemFont(ofSize: labelTitleMinFontSize)
            }else if ((labelTitleMaxFontSize - (visualViewTopHeight-viewTopHeight.constant)) > labelTitleMaxFontSize){
                labelTitle.font = UIFont.boldSystemFont(ofSize: labelTitleMaxFontSize)
            }
        }
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
