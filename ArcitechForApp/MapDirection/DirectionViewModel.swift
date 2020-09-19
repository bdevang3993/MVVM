//
//  DirectionViewModel.swift
//  FugitCustomer
//
//  Created by devang bhavsar on 26/05/20.
//  Copyright © 2020 addis. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
//New data set up all
class DirectionViewModel: NSObject {
    var headerViewXib:CommanView?
    //MARK:- HeaderView
    func setHeaderView(headerView:UIView) {
        headerViewXib = setCommanHeaderViewWithArgument(width: headerView.frame.size.width)
        headerView.frame = headerViewXib!.bounds
        headerViewXib!.btnHeader.isHidden = true
        headerViewXib!.btnBack.isHidden = false
        headerViewXib!.btnBack.setImage(UIImage(named: "back"), for: .normal)
        headerViewXib!.btnBack.setTitle("", for: .normal)
        headerViewXib!.btnBack.addTarget(DirectionViewController(), action: #selector(DirectionViewController().backClicked), for: .touchUpInside)
      //  headerView.backgroundColor = hexStringToUIColor(hex: CustomColor().gradeintTopBackGround)
        headerView.addSubview(headerViewXib!)
    }
    
}
extension DirectionViewController:MKMapViewDelegate, CLLocationManagerDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
     
        
//        if annotation.isEqual(mapView.userLocation) {
//            /*  let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
//             annot.title = "Estimated Time of Arrival (ETA): 22 mins"
//             annotationView.image =  UIImage(named: "ambulance")
//             annotationView.canShowCallout = true
//             return annotationView*/
//        }
        
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom pin")
        if let myAnnotioan = (annotationView.annotation as? CustomAnnotation) {
            if myAnnotioan.categoryId == 1 {
                annotationView.image = UIImage(named: "userIcon")
            }
            else{
                annotationView.image = UIImage(named: "bevareCrack")
            }
        }
        
        annotationView.canShowCallout = true
        return annotationView
        
        
    }
    func getDirections() {
        
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        
        if let destination = destination {
            request.destination = destination
        }
        
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculate(completionHandler: {(response, error) in
            
            if let error = error {
                
            } else {
                if let response = response {
                    let route = response.routes[0]
                    let missionDoloresCoor = CLLocationCoordinate2DMake((self.userLocation?.coordinate.latitude)!, (self.userLocation?.coordinate.longitude)!)
                    let pin = CustomAnnotation(coor: missionDoloresCoor)
                    pin.categoryId = 1
                    pin.title = "Estimated Time of"
                    pin.subtitle = "Arrival (ETA): \(Int(route.expectedTravelTime/60)) mins"
                    self.routeMap.addAnnotation(pin)
                    
                    self.showRoute(response)
                }
            }
        })
    }
    func showRoute(_ response: MKDirections.Response) {
        
        for route in response.routes {
            
            routeMap.addOverlay(route.polyline,
                         level: MKOverlayLevel.aboveRoads)
            
            for step in route.steps {

            }
        }
        
        if let coordinate = userLocation?.coordinate {
           
            let regionRadius: CLLocationDistance = 1000
            
            let region =
                MKCoordinateRegion(center: coordinate,
                                   latitudinalMeters:regionRadius , longitudinalMeters:regionRadius )//1609*50
            routeMap.setRegion(region, animated: true)
        }
    }
    
     func mapView(_ mapView: MKMapView, rendererFor
            overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 5.0
            return renderer
        }
        
        func locationManager(_ manager: CLLocationManager,
                             didUpdateLocations locations: [CLLocation]) {
            userLocation = locations[0]
            
          //  guard let location = locations.last as CLLocation? else { return }

            let userCenter = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
            // Does not have to be userCenter, could replace latitude: and longitude: with any value you would like to center in on

    //        let region = MKCoordinateRegion(center: userCenter, span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0))
    //
    //        routeMap.setRegion(region, animated: true)
            
            self.getDirections()
            
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           
        }
}
