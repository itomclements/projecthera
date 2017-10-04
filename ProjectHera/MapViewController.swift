//
//  MapViewController.swift
//  ProjectHera
//
//  Created by Thomas Clements on 02/10/2017.
//  Copyright © 2017 Thomas Clements. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var manager = CLLocationManager()
    var updateCount = 0
    var pokemons : [Pokemon] = []
   
    
    override func viewDidLoad() {
        pokemons = getAllPokemon()
       
        
        
        
        super.viewDidLoad()
        manager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
             mapView.showsUserLocation = true
            manager.startUpdatingLocation()
            mapView.delegate = self
        } else {
        manager.requestWhenInUseAuthorization()
        }
        

        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
            if let centre = self.manager.location?.coordinate{
                
                var annotationCoordinate = centre
                annotationCoordinate.latitude += (Double(arc4random_uniform(200)) - 100.0)/50000.0
                annotationCoordinate.longitude += (Double(arc4random_uniform(200)) - 100.0)/50000.0
                
                let randomIndex = Int(arc4random_uniform(UInt32(self.pokemons.count)))
                
                let annotation = PokeAnnotation(coord: annotationCoordinate, pokemon: self.pokemons[randomIndex])
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        if annotation is MKUserLocation {
            annoView.image = UIImage(named: "player")
            var frame = annoView.frame
            frame.size.height = 50
            frame.size.width = 50
            annoView.frame = frame
        } else {
            if let pokeAnnotation = annotation as? PokeAnnotation{
                if let imageName = pokeAnnotation.pokemon.imageName{
        annoView.image = UIImage(named: imageName)
        var frame = annoView.frame
        frame.size.height = 50
        frame.size.width = 50
        annoView.frame = frame
        }
            }
        }
        return annoView
    }
    
    
    @IBAction func compassTapped(_ sender: Any) {
        if let centre = manager.location?.coordinate{
            let region = MKCoordinateRegionMakeWithDistance(centre, 400, 400 )
            mapView.setRegion(region, animated:true)
    }
    
}
}
