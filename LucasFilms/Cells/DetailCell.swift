//
//  DetailCell.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit
import Kingfisher

class DetailCell: UITableViewCell {
    
    @IBOutlet var referenceIV: UIImageView!
    @IBOutlet var primaryLbl: UILabel!
    @IBOutlet var secondaryLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func finishSetup(_ character: SWCharacter) {
        let primary = character.name
        var secondary = ""
        if let birthYear = character.birth_year {
            secondary = "Born: \(birthYear)"
        }
        let imageURL = character.getSWAVGImageUrl("characters")
        setupWith(primary, secondary, imageURL)
    }
    
    func finishSetup(_ planet: SWPlanet) {
        let primary = planet.name
        let secondary = planet.climate
        let imageURL = planet.getSWAVGImageUrl("planets")
        setupWith(primary, secondary, imageURL)
    }
    
    func finishSetup(_ starship: SWStarship) {
        let primary = starship.name
        let secondary = starship.model
        let imageURL = starship.getSWAVGImageUrl("starships")
        setupWith(primary, secondary, imageURL)
    }
    
    func finishSetup(_ vehicle: SWVehicle) {
        let primary = vehicle.name
        let secondary = vehicle.model
        let imageURL = vehicle.getSWAVGImageUrl("vehicles")
        setupWith(primary, secondary, imageURL)
    }
    
    func finishSetup(_ species: SWSpecies) {
        let primary = species.name
        let secondary = species.classification
        let imageURL = species.getSWAVGImageUrl("species")
        setupWith(primary, secondary, imageURL)
    }
    
    func setupWith(_ primaryText: String?, _ secondaryText: String?, _ imageURL: String?) {
        referenceIV.setSWAVGIImage(imageURL)
        
        if let primary = primaryText {
            primaryLbl.text = primary.lowercased()
        }
        
        if let secondary = secondaryText {
            secondaryLbl.text = secondary.capitalized
        }
    }
}
