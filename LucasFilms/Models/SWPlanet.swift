//
//  SWPlanet.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit
import ObjectMapper

class SWPlanet: Mappable, SWReflectable, SWAVGable {
    
    var name: String?
    var diameter: String?
    var rotation_period: String?
    var orbital_period: String?
    var gravity: String?
    var population: String?
    var climate: String?
    var terrain: String?
    var surface_water: String?
    var residents: [String]?
    var films: [String]?
    var infoURL: String = ""
    
    //MARK: - Init Methods
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Mappable
    func mapping(map: Map) {
        name            <- map["name"]
        diameter        <- map["diameter"]
        rotation_period <- map["rotation_period"]
        orbital_period  <- map["orbital_period"]
        gravity         <- map["gravity"]
        population      <- map["population"]
        climate         <- map["climate"]
        terrain         <- map["terrain"]
        surface_water   <- map["surface_water"]
        residents       <- map["residents"]
        films           <- map["films"]
        infoURL         <- map["url"]
    }
}
