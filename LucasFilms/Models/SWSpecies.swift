//
//  SWSpecies.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit
import ObjectMapper

class SWSpecies: Mappable, SWReflectable, SWAVGable {
    
    var name: String?
    var classification: String?
    var designation: String?
    var average_height: String?
    var average_lifespan: String?
    var eye_colors: String?
    var hair_colors: String?
    var skin_color: String?
    var language: String?
    var homeworld: String?
    var people: [String]?
    var films: [String]?
    var infoURL: String = ""
    
    //MARK: - Init Methods
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Mappable
    func mapping(map: Map) {
        name                <- map["name"]
        classification      <- map["classification"]
        designation         <- map["designation"]
        average_height      <- map["average_height"]
        average_lifespan    <- map["average_lifespan"]
        eye_colors          <- map["eye_colors"]
        hair_colors         <- map["hair_colors"]
        skin_color          <- map["skin_color"]
        language            <- map["language"]
        homeworld           <- map["homeworld"]
        people              <- map["people"]
        films               <- map["films"]
        infoURL             <- map["url"]
    }
}
