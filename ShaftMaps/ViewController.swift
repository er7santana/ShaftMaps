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
            
        
        

        
        
        //centerMap(locValue)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        checkLocationAuthorizationStatus()
//
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            if let currentLocation = mapView.userLocation.location {
//                centerMapOnLocation(location: currentLocation)
//            }
//        }
//    }
//
//    func checkLocationAuthorizationStatus() {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//            mapView.showsUserLocation = true
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
//
//    func centerMapOnLocation(location: CLLocation) {
//        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
//                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
//        mapView.setRegion(coordinateRegion, animated: true)
//    }
    
}

