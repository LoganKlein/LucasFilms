//
//  LucasFilmsTests.swift
//  LucasFilmsTests
//
//  Created by Logan Klein on 10/28/20.
//

import XCTest
@testable import LucasFilms

class LucasFilmsTests: XCTestCase {
    
    var goodFilm: SWFilm!
    var badFilm: SWFilm!
    var goodCharacter: SWCharacter!
    var badCharacter: SWCharacter!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        goodFilm = SWFilm.generateGoodEx()
        badFilm = SWFilm.generateBadEx()
        goodCharacter = SWCharacter.generateGoodEx()
        badCharacter = SWCharacter.generateBadEx()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        goodFilm = nil
        badFilm = nil
        goodCharacter = nil
        badCharacter = nil
    }

    func testExample() throws {
        // SWAVGable getSWAVGImageUrl
        XCTAssertNotNil(goodCharacter.getSWAVGImageUrl("characters"))
        XCTAssertNil(badCharacter.getSWAVGImageUrl("characters"))
        
        // SWReflectable getValue
        XCTAssertNotNil(goodCharacter.getValue("name"))
        XCTAssertNil(badCharacter.getValue("unknown"))
        
        // SWReflectable reflectAsText
        XCTAssertNotNil(goodCharacter.reflectAsText([]))
        
        // Font loading (Star Jedi)
        XCTAssertNotNil(UIFont(name: "Star Jedi", size: 12))
        XCTAssertNil(UIFont(name: "Star Hamster", size: 12))
    }

    func testPerformanceExample() throws {
        self.measure {
            // Date formatting from string to date
            goodFilm.determineReleasDate()
            
            // Formatting date for string display
            let _ = goodFilm.displayDateString
            
            // SWReflectable reflectAsText
            let _ = goodCharacter.reflectAsText([])
        }
    }

}
