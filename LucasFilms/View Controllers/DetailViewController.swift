//
//  DetailViewController.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit

struct DetailVCPacket {
    var item: SWReflectable?
    var image: UIImage?
}

class DetailViewController: UIViewController {
    
    @IBOutlet var referenceIV: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var bodyLbl: UILabel!
    
    var item: SWReflectable?
    var image: UIImage?
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        loadType()
        
        super.viewDidLoad()
    }
    
    func loadType() {
        var imageURL: String? = nil
        if let character = item as? SWCharacter {
            titleLbl.text = character.name?.lowercased()
            imageURL = character.getSWAVGImageUrl("characters")
        }
        
        else if let planet = item as? SWPlanet {
            titleLbl.text = planet.name?.lowercased()
            imageURL = planet.getSWAVGImageUrl("planets")
        }
        
        else if let starship = item as? SWStarship {
            titleLbl.text = starship.name?.lowercased()
            imageURL = starship.getSWAVGImageUrl("starships")
        }
        
        else if let vehicle = item as? SWVehicle {
            titleLbl.text = vehicle.name?.lowercased()
            imageURL = vehicle.getSWAVGImageUrl("vehicles")
        }
        
        else if let species = item as? SWSpecies {
            titleLbl.text = species.name?.lowercased()
            imageURL = species.getSWAVGImageUrl("species")
        }
        
        if imageURL != nil { referenceIV.setSWAVGIImage(imageURL!) }
        
        bodyLbl.text = item?.reflectAsText(["name"])
    }
    
    // MARK: - IBActions
    
    @IBAction func backPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
