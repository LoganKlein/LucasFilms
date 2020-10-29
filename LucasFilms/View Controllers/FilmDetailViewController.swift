//
//  FilmDetailViewController.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit

class FilmDetailViewController: UIViewController {
    
    @IBOutlet var mainTV: UITableView!
    
    var film: SWFilm?
    var headerItems: [String] = []
    var displayItems: [[Any]] = []
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        // Check items to build the display array
        buildDisplayOrder()
        
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailView" {
            let packet = sender as? DetailVCPacket
            (segue.destination as? DetailViewController)?.item = packet?.item
        }
    }
    
    // MARK: - Construction Methods
    
    func buildDisplayOrder() {
        // DISPLAY ORDER: CHARACTERS > PLANETS > STARSHIPS > VEHICLES > SPECIES
        if let characters = film?.relatedCharacters {
            headerItems.append("characters")
            displayItems.append(characters)
        }
        
        if let planets = film?.relatedPlanets {
            headerItems.append("planets")
            displayItems.append(planets)
        }
        
        if let starships = film?.relatedStarships {
            headerItems.append("starships")
            displayItems.append(starships)
        }
        
        if let vehicles = film?.relatedVehicles {
            headerItems.append("vehicles")
            displayItems.append(vehicles)
        }
        
        if let species = film?.relatedSpecies {
            headerItems.append("species")
            displayItems.append(species)
        }
        
        mainTV.reloadData()
    }
}

// MARK: - UITableViewDataSource Methods

extension FilmDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        
        let count = displayItems[section - 1].count
        // CURRENTLY LIMITING ALL ITEMS TO THE FIRST 3. UNCOMMENT THIS LINE TO RETURN ALL ITEMS
//        return count
        
        if count > 3 { return 3 }
        else { return count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let film = film {
                let cell: FilmDetailHeaderCell = tableView.dequeueReusableCell(withIdentifier: "detailHeaderCellID") as! FilmDetailHeaderCell
                cell.finishSetup(film)
                return cell
            }
            
            else {
                print("something has gone seriously wrong if we're here. Missing film during header cell setup")
            }
        }
        
        // Get the generic item for display
        let items = displayItems[indexPath.section - 1]
        
        let item = items[indexPath.row]
        let cell: DetailCell = tableView.dequeueReusableCell(withIdentifier: "detailCellID") as! DetailCell
        
        if let character = item as? SWCharacter {
            cell.finishSetup(character)
        }
        
        else if let planet = item as? SWPlanet {
            cell.finishSetup(planet)
        }
        
        else if let starship = item as? SWStarship {
            cell.finishSetup(starship)
        }
        
        else if let vehicle = item as? SWVehicle {
            cell.finishSetup(vehicle)
        }
        
        else if let species = item as? SWSpecies {
            cell.finishSetup(species)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        label.font = UIFont(name: "Star Jedi", size: 16)
        label.textAlignment = .center
        
        if section > 0 {
            let headerText = headerItems[section - 1]
            label.text = "- \(headerText) -"
        }
        
        return label
    }
}

// MARK: - UITableViewDelegate Methods

extension FilmDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let items = displayItems[indexPath.section - 1]
        let item = items[indexPath.row] as? SWReflectable
        let detailVCPacket = DetailVCPacket(item: item, image: nil)
        self.performSegue(withIdentifier: "goToDetailView", sender: detailVCPacket)
    }
}
