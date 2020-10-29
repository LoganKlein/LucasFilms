//
//  FilmsViewController.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit

class FilmsViewController: UIViewController {
    
    @IBOutlet var mainTV: UITableView!
    @IBOutlet var loadingView: UIView!
    var lucasFilms: [SWFilm] = []
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        getFilms()
        
        super.viewDidLoad()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFilmDetail" {
            let film = sender as? SWFilm
            (segue.destination as? FilmDetailViewController)?.film = film
        }
    }
    
    // MARK: - Data Loading
    
    func getFilms() {
        WebServices.shared().getAllItemsOfType(SWFilm(), suffix: "films") { (films) in
            guard let films = films else {
                print("unable to collect films")
                return
            }
            
            // Check for a valid response
            if films.count > 0 {
                // Only display films where Lucas directed
                self.lucasFilms.removeAll()
                
                for film in films {
                    if film.isLucasFilm {
                        self.lucasFilms.append(film)
                    }
                }
            }
            
            if self.lucasFilms.count > 0 {
                self.loadingOpacity(0)
                self.mainTV.reloadData()
            }
        }
    }
    
    // MARK: - Animation Helpers
    
    func loadingOpacity(_ opacity: CGFloat) {
        UIView.animateKeyframes(withDuration: 0.35, delay: 0, options: [], animations: {
            self.loadingView.alpha = opacity
        }, completion: nil)
    }
}

// MARK: - UITableViewDataSource Methods

extension FilmsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lucasFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let film = lucasFilms[indexPath.row]
        let cell: FilmCell = tableView.dequeueReusableCell(withIdentifier: "filmCellID") as! FilmCell
        cell.finishSetup(film)
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate Methods

extension FilmsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let film = lucasFilms[indexPath.row]
        
        self.loadingOpacity(1)
        
        film.collectAllRelatedInfo({ (success) in
            let sender = film
            self.performSegue(withIdentifier: "goToFilmDetail", sender: sender)
            self.loadingOpacity(0)
        })
//        WebServices.shared().getItemsFromList(SWCharacter(), film.characters) { (characters) in
//            let sender = FilmDetailVCPacket(film: film, characters: characters)
//            self.performSegue(withIdentifier: "goToFilmDetail", sender: sender)
//            
//        }
    }
}
