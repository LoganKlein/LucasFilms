//
//  FilmCell.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit

class FilmCell: UITableViewCell {
    
    @IBOutlet var posterIV: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var releaseDateLbl: UILabel!
    
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
        titleLbl.text = film?.title?.lowercased()
        
        if let releaseDate = film?.displayDateString {
            releaseDateLbl.text = "Released: \(releaseDate)"
        }
    }
}
