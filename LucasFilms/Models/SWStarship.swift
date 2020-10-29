//
//  SWStarship.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit
import ObjectMapper

class SWStarship: Mappable, SWReflectable, SWAVGable {
    
    var name: String?
    var model: String?
    var starship_class: String?
    var manufacturer: String?
    var cost_in_credits: String?
    var length: String?
    var crew: String?
    var passengers: String?
    var max_atmosphering_speed: String?
    var hyperdrive_rating: String?
    var MGLT: String?
    var cargo_capacity: String?
    var consumables: String?
    var films: [String]?
    var pilots: [String]?
    var infoURL: String = ""
    
    //MARK: - Init Methods
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Mappable
    func mapping(map: Map) {
        name                    <- map["name"]
        model                   <- map["model"]
        starship_class          <- map["starship_class"]
        manufacturer            <- map["manufacturer"]
        cost_in_credits         <- map["cost_in_credits"]
        length                  <- map["length"]
        crew                    <- map["crew"]
        passengers              <- map["passengers"]
        max_atmosphering_speed  <- map["max_atmosphering_speed"]
        hyperdrive_rating       <- map["hyperdrive_rating"]
        MGLT                    <- map["MGLT"]
        cargo_capacity          <- map["cargo_capacity"]
        consumables             <- map["consumables"]
        films                   <- map["films"]
        pilots                  <- map["pilots"]
        infoURL                 <- map["url"]
    }
}
