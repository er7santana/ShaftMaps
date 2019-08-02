//
//  ViewController.swift
//  ShaftMaps
//
//  Created by Rodrigo Sant Ana on 01/08/19.
//  Copyright © 2019 Shaft Corporation. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
    let annotation = MKPointAnnotation()
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    var isFirstLocation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        if isFirstLocation {
            
            let coordinateRegion = MKCoordinateRegion(center: locValue,
                                                      latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
            
            annotation.coordinate = locValue
            annotation.title = "John Shaft"
            annotation.subtitle = "current location"
            mapView.addAnnotation(annotation)
            
            isFirstLocation = false
        }
        else {
            annotation.coordinate = locValue
        }
    }
    
    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
        mapView.mapType = MKMapType.init(rawValue: UInt(sender.selectedSegmentIndex)) ?? .standard
    }
    
}

