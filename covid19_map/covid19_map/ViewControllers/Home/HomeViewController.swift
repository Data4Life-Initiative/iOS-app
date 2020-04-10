//
//  HomeViewController.swift
//  covid19_map
//
//  Created by Mohamed Rebin on 05/04/20.
//  Copyright © 2020 iGrant.io. All rights reserved.
//

import UIKit
import SideMenu
import GoogleMaps

class HomeViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    private var heatmapLayer: GMUHeatmapTileLayer!
    private var gradientColors = [UIColor.green, UIColor.red]
    private var gradientStartPoints = [0.2, 1.0] as [NSNumber]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        configHeatMap()
    }

    
    func configHeatMap() {
        // Set heatmap options.
        let camera = GMSCameraPosition.camera(withLatitude: 59.33181226723279, longitude: 18.044567678390518, zoom: 12)
        mapView.camera = camera
           heatmapLayer = GMUHeatmapTileLayer()
           heatmapLayer.radius = 80
           heatmapLayer.opacity = 0.8
           heatmapLayer.gradient = GMUGradient(colors: gradientColors,
                                               startPoints: gradientStartPoints,
                                               colorMapSize: 256)
           addHeatmap()
           // Set the heatmap to the mapview.
    }
    
    func addHeatmap()  {
      var list = [GMUWeightedLatLng]()
          Utils.showProgress()
          NetworkManager.sharedManager.getLocationForHeatMap{ (response) in
              Utils.hideProgress()
              if response?.status == 200 {
                for item in response?.data?.diseaseHotspots ?? [] {
                    let lat = CLLocationDegrees.init(exactly: Double(item.lat ?? "0")!)!
                    let long = CLLocationDegrees.init(exactly: Double(item.long ?? "0")!)!
                    list.append(GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat , long), intensity: 1.0))
//                    let marker = GMSMarker()
//                    marker.position = CLLocationCoordinate2DMake(lat , long)
//                    marker.title = "Sydney"
//                    marker.snippet = "Australia"
//                    marker.map = self.mapView

                }
                  DispatchQueue.main.async {
                    // Add the latlngs to the heatmap layer.
                    self.heatmapLayer.weightedData = list
                self.heatmapLayer.map = self.mapView

                 }
              }
          }

    }
    
//    func addHeatmap()  {
//      var list = [GMUWeightedLatLng]()
//      do {
//        // Get the data: latitude/longitude positions of police stations.
//        if let path = Bundle.main.url(forResource: "police_stations", withExtension: "json") {
//          let data = try Data(contentsOf: path)
//          let json = try JSONSerialization.jsonObject(with: data, options: [])
//          if let object = json as? [[String: Any]] {
//            for item in object {
//              let lat = item["lat"]
//              let lng = item["lng"]
//              let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat as! CLLocationDegrees, lng as! CLLocationDegrees), intensity: 1.0)
//
//                        let marker = GMSMarker()
//                marker.position = CLLocationCoordinate2DMake(lat as! CLLocationDegrees , lng as! CLLocationDegrees)
//                        marker.title = "Sydney"
//                        marker.snippet = "Australia"
//                        marker.map = self.mapView
//              list.append(coords)
//            }
//          } else {
//            print("Could not read the JSON.")
//          }
//        }
//      } catch {
//        print(error.localizedDescription)
//      }
//      // Add the latlngs to the heatmap layer.
//      heatmapLayer.weightedData = list
//    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func configNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "ic_menu_white"), style: .done, target: self, action: #selector(sideMenuTapped))
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        // Define the menus
        let leftMenuNavigationController = storyBoard.instantiateViewController(withIdentifier: "LeftMenuNav") as? SideMenuNavigationController
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        SideMenuManager.default.rightMenuNavigationController = nil
        SideMenuManager.default.leftMenuNavigationController?.menuWidth = self.view.frame.width
        SideMenuManager.default.leftMenuNavigationController?.blurEffectStyle = .regular
        SideMenuManager.default.leftMenuNavigationController?.presentationStyle = .menuSlideIn
        SideMenuManager.default.leftMenuNavigationController?.statusBarEndAlpha = 0
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
        
    }
    
    @objc func sideMenuTapped() {
        print("sidemenuPressed")
        let newViewController: SideMenuNavigationController?
        newViewController = SideMenuManager.default.leftMenuNavigationController
        self.navigationController?.present(newViewController!, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
