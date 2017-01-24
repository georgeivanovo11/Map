//
//  Autocomplete.swift
//  Map
//
//  Created by george on 24/01/2017.
//  Copyright © 2017 george. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class Autocomplete: NSObject
{
    var primaryAddress: String?
    var secondaryAddress: String?
    var id: String
    
    init(ad1: String, ad2: String, id1: String)
    {
        primaryAddress = ad1
        secondaryAddress = ad2
        id = id1
    }
}
