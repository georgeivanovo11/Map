//
//  MapViewController.swift
//  Map
//
//  Created by george on 23/01/2017.
//  Copyright © 2017 george. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController
{
    var mapView: GMSMapView?
    
    override func viewDidLoad()
    {
        //Settings
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Map"
        GMSServices.provideAPIKey("AIzaSyD-Wz-BjKvWSYNiz0pttubdFtuXlOocTeg")
        setupMapView()
        
    }

}

extension MapViewController
{
    func setupMapView()
    {
        let startPosition = CLLocationCoordinate2D(latitude: 57.000394, longitude: 40.974598)
        let camera = GMSCameraPosition.camera(withTarget: startPosition, zoom: 15)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        view.addSubview(mapView!)
        
        mapView?.translatesAutoresizingMaskIntoConstraints = false
        mapView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
 
    }
}
