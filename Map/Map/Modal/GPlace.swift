//
//  GPlace.swift
//  Map
//
//  Created by george on 24/01/2017.
//  Copyright © 2017 george. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GPlace: NSObject
{
    var primaryAddress: String?
    var secondaryAddress: String?
    var info: GMSPlace?
    var marker: GMSMarker?
    
    init(ad1: String, ad2: String, inf: GMSPlace)
    {
        super.init()
        primaryAddress = ad1
        secondaryAddress = ad2
        info = inf
        marker = GMSMarker(position: (info?.coordinate)!)
        marker?.title = primaryAddress
    }
}
