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

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var mapView: GMSMapView?
    var tableView: UITableView = UITableView()
    
    var listOfMainAddress: [String] = ["   "]
    var listOfAddAddress: [String] = ["   "]
    
    lazy var startAddress: UITextField =
    {
        let text = UITextField()
        text.backgroundColor = UIColor.white
        text.placeholder = "Ваш адрес..."
        text.textAlignment = .center
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.cornerRadius = 10
        text.layer.masksToBounds = true
        text.addTarget(self, action: #selector(appearHelpView), for: .editingDidBegin)
        text.addTarget(self, action: #selector(disappearHelpView), for: .editingDidEnd)
        text.addTarget(self, action: #selector(changeLetters), for: .editingChanged)
        return text
    }()
    
    var helpView: UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        setupHelpView()
        setupTable()
    }
}


//MARK: Table
extension MapViewController
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMainAddress.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = listOfMainAddress[indexPath.row]
        cell.detailTextLabel?.text = listOfAddAddress[indexPath.row]
        
        return cell
    }
}


//MARK:  Views
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
    
    func setupHelpView()
    {
        view.addSubview(helpView)
        helpView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        helpView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        helpView.topAnchor.constraint(equalTo: startAddress.bottomAnchor, constant: 5).isActive = true
        helpView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        helpView.isHidden = true
    }
    
    func setupTable()
    {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        helpView.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: helpView.leftAnchor, constant: 5).isActive = true
        tableView.rightAnchor.constraint(equalTo: helpView.rightAnchor, constant: -5).isActive = true
        tableView.topAnchor.constraint(equalTo: helpView.topAnchor, constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: helpView.bottomAnchor, constant: -5).isActive = true
    }
}

//MARK: Actions
extension MapViewController
{    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func appearHelpView()
    {
        helpView.isHidden = false
    }
    
    func disappearHelpView()
    {
        helpView.isHidden = true
    }
    
    func changeLetters()
    {
        let filter = GMSAutocompleteFilter()
        filter.type = GMSPlacesAutocompleteTypeFilter.address
        let b1 = CLLocationCoordinate2D(latitude: 56.912803, longitude: 40.788388)
        let b2 = CLLocationCoordinate2D(latitude: 57.088364, longitude: 41.142119)
        let bounds = GMSCoordinateBounds(coordinate: b1, coordinate: b2)
        let placesClient = GMSPlacesClient()
        placesClient.autocompleteQuery(startAddress.text!, bounds: bounds, filter: filter, callback:
        {
            (results, error) in
            
            if error != nil
            {
                print("error")
                return
            }
            
            self.listOfMainAddress.removeAll()
            self.listOfAddAddress.removeAll()
            
            if results?.count == 0
            {
                self.listOfMainAddress.append("No")
                self.listOfAddAddress.append(" ")
            }
            
            for result in results!
            {
                self.listOfMainAddress.append(result.attributedPrimaryText.string)
                self.listOfAddAddress.append((result.attributedSecondaryText?.string)!)
                /*
                let place = CLLocationCoordinate2D()
                let marker = GMSMarker
                marker.title = "Pozharka"
                marker.map = mapView
                */
            }
            
            DispatchQueue.main.async(execute:
            {
                self.tableView.reloadData()
            })
            
        })
    }
}
