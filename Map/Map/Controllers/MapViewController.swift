//
//  MapViewController.swift
//  Map
//
//  Created by george on 23/01/2017.
//  Copyright © 2017 george. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController
{
    var mapView: GMSMapView?
    
    var startAddress: UITextField =
    {
        let text = UITextField()
        text.backgroundColor = UIColor.white
        text.placeholder = "Ваш адрес..."
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.cornerRadius = 10
        text.layer.masksToBounds = true
        return text
    }()
    
    override func viewDidLoad()
    {
        //Settings
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Map"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain , target: self, action: #selector(dismissKeyboard))
        
        //View
        setupMapView()
        setupStartAddress()
    }

}

extension MapViewController
{
    func setupMapView()
    {
        let startPosition = CLLocationCoordinate2D(latitude: 57.000394, longitude: 40.974598)
        let camera = GMSCameraPosition.camera(withTarget: startPosition, zoom: 15)
        let point = CGPoint.init(x: 0, y:0)
        let size = CGSize.init(width: 50, height: 50)
        let rect = CGRect.init(origin: point, size: size)
        mapView = GMSMapView.map(withFrame: rect , camera: camera)
        
        view.addSubview(mapView!)
        
        mapView?.translatesAutoresizingMaskIntoConstraints = false
        mapView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mapView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        mapView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    func setupStartAddress()
    {
        view.addSubview(startAddress)
        startAddress.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        startAddress.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        startAddress.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        startAddress.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}

extension MapViewController
{    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
