//
//  CustomAnotation.swift
//  ArcitechForApp
//
//  Created by devang bhavsar on 29/07/20.
//  Copyright © 2020 devang bhavsar. All rights reserved.
//
import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation
{
    // 3
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var categoryId: Int
    
    // 4
    init(coor: CLLocationCoordinate2D)
    {
        coordinate = coor
        categoryId = 0
    }
}
