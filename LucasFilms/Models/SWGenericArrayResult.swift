//
//  SWGenericArrayResult.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit
import ObjectMapper

class SWGenericArrayResult: Mappable {
    
    var count: Int?
    var results: Any?
    
    //MARK: - Init Methods
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    // MARK: - Mappable
    func mapping(map: Map) {
        count   <- map["count"]
        results <- map["results"]
    }
}
