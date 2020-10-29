//
//  FilmDetailHeaderCell.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit

class FilmDetailHeaderCell: UITableViewCell {
    
    @IBOutlet var posterIV: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var releaseLbl: UILabel!
    @IBOutlet var directorLbl: UILabel!
    @IBOutlet var producerLbl: UILabel!
    
    var film: SWFilm?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func finishSetup(_ aFilm: SWFilm) {
        film = aFilm
        
        posterIV.image = film?.filmImage
        
        if let episodeNum = film?.episodeID, let filmTitle = film?.title?.lowercased() {
            titleLbl.text = "ep. \(episodeNum): \(filmTitle)"
        }
        
        if let releaseDate = film?.displayDateString {
            releaseLbl.text = "Released: \(releaseDate)"
        }
        
        if let director = film?.director { directorLbl.text = "Directed by: \(director)" }
        if let producer = film?.producer { producerLbl.text = "Produced by: \(producer)" }
        
    }
}
