//
//  AppDelegate.swift
//  Map
//
//  Created by george on 23/01/2017.
//  Copyright © 2017 george. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        window?.rootViewController = UINavigationController(rootViewController: MapViewController())
        
        GMSServices.provideAPIKey("AIzaSyD-Wz-BjKvWSYNiz0pttubdFtuXlOocTeg")
        GMSPlacesClient.provideAPIKey("AIzaSyD-Wz-BjKvWSYNiz0pttubdFtuXlOocTeg")
        return true
    }

}

