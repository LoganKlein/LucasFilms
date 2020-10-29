//
//  SWCharacter.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit
import ObjectMapper

class SWCharacter: Mappable, SWReflectable, SWAVGable {
    var name: String?
    var birth_year: String?
    var eye_color: String?
    var gender: String?
    var hair_color: String?
    var height: String?
    var mass: String?
    var skin_color: String?
    var homeworld: String?
    var films: [String]?
    var species: [String]?
    var infoURL: String = ""

    //MARK: - Init Methods
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Mappable
    func mapping(map: Map) {
        name        <- map["name"]
        birth_year  <- map["birth_year"]
        eye_color   <- map["eye_color"]
        gender      <- map["gender"]
        hair_color  <- map["hair_color"]
        height      <- map["height"]
        mass        <- map["mass"]
        skin_color  <- map["skin_color"]
        homeworld   <- map["homeworld"]
        films       <- map["films"]
        species     <- map["species"]
        infoURL     <- map["url"]
    }
    
    // MARK: - Unit Testing Methods
    
    class func generateGoodEx() -> SWCharacter {
        let character = SWCharacter()
        
        character.name = "Luke Skywalker"
        character.birth_year = "19BBY"
        character.eye_color = "Blue"
        character.gender = "Male"
        character.hair_color = "Blond"
        character.height = "172"
        character.mass = "77"
        character.skin_color = "Fair"
        character.infoURL = "http://swapi.dev/api/people/1/"
        
        return character
    }
    
    class func generateBadEx() -> SWCharacter {
        let character = SWCharacter()
        
        character.name = "John Slattery"
        character.birth_year = "113 BC"
        character.eye_color = "Red"
        character.gender = "Unknown"
        character.height = "180"
        character.mass = "64"
        character.skin_color = "Green"
        character.infoURL = "https://www.google.com/"
        
        return character
    }
}
