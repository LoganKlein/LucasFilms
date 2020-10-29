//
//  SWFilm.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit
import ObjectMapper

class SWFilm: Mappable {
    
    var title: String?
    var episodeID: Int?
    var opening_crawl: String?
    var director: String?
    var producer: String?
    var releaseDate: Date?
    var releaseDateString: String?
    var species: [String]?
    var starships: [String]?
    var vehicles: [String]?
    var characters: [String]?
    var planets: [String]?
    var infoURL: String?
    
    var relatedSpecies: [SWSpecies]?
    var relatedStarships: [SWStarship]?
    var relatedVehicles: [SWVehicle]?
    var relatedCharacters: [SWCharacter]?
    var relatedPlanets: [SWPlanet]?
    
    //MARK: - Init Methods
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Mappable
    func mapping(map: Map) {
        title               <- map["title"]
        episodeID           <- map["episode_id"]
        opening_crawl       <- map["opening_crawl"]
        director            <- map["director"]
        producer            <- map["producer"]
        releaseDateString   <- map["release_date"]
        species             <- map["species"]
        starships           <- map["starships"]
        vehicles            <- map["vehicles"]
        characters          <- map["characters"]
        planets             <- map["planets"]
        infoURL             <- map["url"]
        
        determineReleasDate()
    }
    
    // MARK: - Helper Methods
    
    func determineReleasDate() {
        if let dateString = releaseDateString {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            releaseDate = dateFormatter.date(from:dateString)
        }
    }
    
    var isLucasFilm: Bool {
        return director?.lowercased() == "george lucas"
    }
    
    var filmImage: UIImage? {
        // We are not collecting this resource from SWAVG because their film id's do not align with the SWAPI episode_id. Also, the connection to SWAVG is tenuous at best
        guard let episodeID = episodeID else {
            print("missing episode ID")
            return nil
        }
        
        return UIImage(named: "ep\(episodeID)")
    }
    
    var displayDateString: String? {
        guard let date = releaseDate else {
            print("release date missing")
            return nil
        }
        
        return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
    }
    
    // MARK: - Additional Data Collection Methods
    
    func collectAllRelatedInfo(_ callback: @escaping (_ complete: Bool) -> ()) {
        var checkCount = 0
        var successCount = 0
        let checksNeeded = 5
        
        getSpecies { (success) in
            checkCount += 1
            if success { successCount += 1 }
            print("species collected successfully: \(success)")
            if checkCount == checksNeeded { callback(successCount == checksNeeded) }
        }
        
        getStarships { (success) in
            checkCount += 1
            if success { successCount += 1 }
            print("starships collected successfully: \(success)")
            if checkCount == checksNeeded { callback(successCount == checksNeeded) }
        }
        
        getVehicles { (success) in
            checkCount += 1
            if success { successCount += 1 }
            print("vehicles collected successfully: \(success)")
            if checkCount == checksNeeded { callback(successCount == checksNeeded) }
        }
        
        getCharacters { (success) in
            checkCount += 1
            if success { successCount += 1 }
            print("characters collected successfully: \(success)")
            if checkCount == checksNeeded { callback(successCount == checksNeeded) }
        }
        
        getPlanets { (success) in
            checkCount += 1
            if success { successCount += 1 }
            print("planets collected successfully: \(success)")
            if checkCount == checksNeeded { callback(successCount == checksNeeded) }
        }
    }
    
    func getSpecies(_ callback: @escaping (_ success: Bool) -> ()) {
        WebServices.shared().getItemsFromList(SWSpecies(), species) { (related) in
            self.relatedSpecies = related
            callback(related?.count == self.species?.count)
        }
    }
    
    func getStarships(_ callback: @escaping (_ success: Bool) -> ()) {
        WebServices.shared().getItemsFromList(SWStarship(), starships) { (related) in
            self.relatedStarships = related
            callback(related?.count == self.starships?.count)
        }
    }
    
    func getVehicles(_ callback: @escaping (_ success: Bool) -> ()) {
        WebServices.shared().getItemsFromList(SWVehicle(), vehicles) { (related) in
            self.relatedVehicles = related
            callback(related?.count == self.vehicles?.count)
        }
    }
    
    func getCharacters(_ callback: @escaping (_ success: Bool) -> ()) {
        WebServices.shared().getItemsFromList(SWCharacter(), characters) { (related) in
            self.relatedCharacters = related
            callback(related?.count == self.characters?.count)
        }
    }
    
    func getPlanets(_ callback: @escaping (_ success: Bool) -> ()) {
        WebServices.shared().getItemsFromList(SWPlanet(), planets) { (related) in
            self.relatedPlanets = related
            callback(related?.count == self.planets?.count)
        }
    }
    
    // MARK: - Unit Testing Methods
    
    class func generateGoodEx() -> SWFilm {
        let film = SWFilm()
        
        film.title = "A New Hope"
        film.episodeID = 4
        film.director = "George Lucas"
        film.producer = "Gary Kurtz, Rick McCallum"
        film.releaseDateString = "1977-05-25"
        film.infoURL = "http://swapi.dev/api/films/1/"
        
        return film
    }
    
    class func generateBadEx() -> SWFilm {
        let film = SWFilm()
        
        film.title = "Not a SW Film"
        film.episodeID = 112
        film.director = "Michael Scarn"
        film.producer = "Hans Gruber"
        film.releaseDateString = "2019-01-BB"
        film.infoURL = "https://www.google.com/"
        
        return film
    }
}
