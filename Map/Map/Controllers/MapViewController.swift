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
    
    var startPlace: GPlace?
    var currentIndex: Int = -1
    
    var list: [Autocomplete] = []
    
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
    
    var buttonView: UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var button: UIButton =
    {
        let but = UIButton(type: .system)
        but.setTitle("+", for: .normal)
        but.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        but.translatesAutoresizingMaskIntoConstraints = false
        but.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        return but
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
        setupButtonView()
        setupStartAddress()
        setupHelpView()
        setupTable()
    }
}


//MARK: Table
extension MapViewController
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row].primaryAddress
        cell.detailTextLabel?.text = list[indexPath.row].secondaryAddress
        
        return cell
    }
    
    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        startAddress.text = list[indexPath.row].primaryAddress
        currentIndex = indexPath.row
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
    
    func setupButtonView()
    {
        view.addSubview(buttonView)
        buttonView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        buttonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        buttonView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        buttonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        buttonView.addSubview(button)
        button.leftAnchor.constraint(equalTo: buttonView.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: buttonView.rightAnchor).isActive = true
        button.topAnchor.constraint(equalTo: buttonView.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor).isActive = true
    }
    
    func setupStartAddress()
    {
        view.addSubview(startAddress)
        startAddress.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        startAddress.rightAnchor.constraint(equalTo: buttonView.leftAnchor, constant: -5).isActive = true
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
            
            self.list.removeAll()
            
            for result in results!
            {
                let a = result.attributedPrimaryText.string
                let b = result.attributedSecondaryText?.string
                let c = result.placeID
                self.list.append(Autocomplete(ad1: a,ad2: b!,id1: c!))
            }
            
            DispatchQueue.main.async(execute:
            {
                self.tableView.reloadData()
            })
            
        })
    }
    
    func pressButton()
    {
        if currentIndex == -1
        {
            print(currentIndex)
            return
        }
        
        let placesClient = GMSPlacesClient()
        placesClient.lookUpPlaceID(list[currentIndex].id, callback:
        {
            (place, error) in
         
            if error != nil
            {
               print("error")
               return
            }
         
            guard let place = place
            else
            {
               print("error")
               return
            }
         
            let a = self.list[self.currentIndex].primaryAddress
            let b = self.list[self.currentIndex].secondaryAddress
            let c = place
            self.startPlace = GPlace(ad1: a!,ad2: b!,inf: c)
            
            let marker = GMSMarker(position: (self.startPlace?.info?.coordinate)!)
            marker.title = self.startPlace?.primaryAddress
            marker.map = self.mapView
            self.mapView?.animate(with: GMSCameraUpdate.setTarget((self.startPlace?.info?.coordinate)!))
         })
        
        dismissKeyboard()
        disappearHelpView()
    }
}
