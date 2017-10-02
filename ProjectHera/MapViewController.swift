//
//  MapViewController.swift
//  ProjectHera
//
//  Created by Thomas Clements on 02/10/2017.
//  Copyright © 2017 Thomas Clements. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    var updateCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
             mapView.showsUserLocation = true
            manager.startUpdatingLocation()
        } else {
        manager.requestWhenInUseAuthorization()
        }
        

        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            if let centre = self.manager.location?.coordinate{
                let annotation = MKPointAnnotation()
                var annotationCoordinate = centre
                annotationCoordinate.latitude += 0.001
                annotation.coordinate = annotationCoordinate
                self.mapView.addAnnotation(annotation)
        
            }
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if updateCount < 3 {
        if let centre = manager.location?.coordinate{
        let region = MKCoordinateRegionMakeWithDistance(centre, 400, 400 )
        mapView.setRegion(region, animated:true)
        }
            updateCount+=1
            
        } else {
            manager.stopUpdatingLocation()
        }
        
    }
    
    
    @IBAction func compassTapped(_ sender: Any) {
        if let centre = manager.location?.coordinate{
            let region = MKCoordinateRegionMakeWithDistance(centre, 400, 400 )
            mapView.setRegion(region, animated:true)
    }
    
}
}
