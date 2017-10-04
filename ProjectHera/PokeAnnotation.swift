//
//  PokeAnnotation.swift
//  ProjectHera
//
//  Created by Thomas Clements on 04/10/2017.
//  Copyright © 2017 Thomas Clements. All rights reserved.
//

import UIKit
import MapKit

class PokeAnnotation : NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var pokemon : Pokemon
    init(coord:CLLocationCoordinate2D, pokemon:Pokemon) {
        self.coordinate = coord
        self.pokemon = pokemon
    }
    
}
