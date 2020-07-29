//
//  DirectionViewController.swift
//  FugitCustomer
//
//  Created by devang bhavsar on 26/05/20.
//  Copyright © 2020 addis. All rights reserved.
//

import UIKit
import MapKit
class DirectionViewController: UIViewController {

    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var routeMap: MKMapView!
    var locationManager: CLLocationManager = CLLocationManager()
    var userLocation: CLLocation?
    var destination: MKMapItem?
    var shopLat = "40.0583"
    var shopLng = "-74.4058"
    var strShopName:String = ""
    var objDirectionViewModel = DirectionViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        objDirectionViewModel.setHeaderView(headerView: viewHeader)
        self.setUpMap()
    }
    func setUpMap() {
        self.routeMap.delegate = self
        self.routeMap.showsUserLocation = true
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestLocation()
        let london = MKPointAnnotation()
        
        london.title = "Customer"
        london.coordinate = CLLocationCoordinate2D(latitude: 40.0583, longitude: -74.4057)
       // london.coordinate = CLLocationCoordinate2D(latitude: userLat, longitude: userLong)
        //routeMap.addAnnotation(london)
        
     
         let missionDoloresCoor = CLLocationCoordinate2DMake(40.0583, -74.4057)
        //let missionDoloresCoor = CLLocationCoordinate2DMake(Double(shopLat)!, Double(shopLng)!)
        let pin = CustomAnnotation(coor: missionDoloresCoor)
        pin.categoryId = 0
        pin.title = strShopName//"ShopName"
        pin.subtitle = strShopName //"Hospital Name"
        
        self.routeMap.addAnnotation(pin)
        
        self.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude:Double(shopLat)!, longitude: Double(shopLng)!), addressDictionary: nil))
        self.locationManager.startUpdatingLocation()
    }
    
    @objc func backClicked() {
        self.navigationController?.popViewController(animated: true)
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
