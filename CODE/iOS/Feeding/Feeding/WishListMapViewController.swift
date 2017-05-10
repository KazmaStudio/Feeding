//
//  WishListMapViewController.swift
//  Feeding
//
//  Created by ZHAOCHENJUN on 2017/5/3.
//  Copyright © 2017年 com.kazmastudio. All rights reserved.
//

import UIKit
import MapKit

class WishListMapViewController: UIViewController, MKMapViewDelegate {

	@IBOutlet var mapView: MKMapView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		mapView.delegate = self
		let overlayPath = "https://stamen-tiles.a.ssl.fastly.net/toner/{z}/{x}/{y}.png"
		let overlay = MKTileOverlay(urlTemplate: overlayPath)
		overlay.canReplaceMapContent = true
		self.mapView.add(overlay)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
		
		guard let tileOverlay = overlay as? MKTileOverlay else {
			return MKOverlayRenderer(overlay: overlay)
		}
		return MKTileOverlayRenderer(tileOverlay: tileOverlay)
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
