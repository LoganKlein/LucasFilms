//
//  Extensions.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setSWAVGIImage(_ imageURL: String?) {
        if let urlString = imageURL, let url = URL(string: urlString) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url, completionHandler: { result in
                switch result {
                case .success:
                    break
                    
                case .failure(let error):
                    print(error)
                    self.image = UIImage(named: "missing_image")
                    break
                    
                }
            })
        }
        
        else {
            self.image = UIImage(named: "missing_image")
        }
    }
}

protocol SWReflectable {
    
}

extension SWReflectable {
    func getValue(_ named: String) -> Any? {
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            if child.label == named {
                return child.value
            }
        }
        
        return nil
    }
    
    func reflectAsText(_ omitLabels: [String]) -> String {
        var returnText = ""
        let mirror = Mirror(reflecting: self)

        for child in mirror.children {
            if let value = child.value as? String, let label = child.label {
                // Make sure not to output names with links
                if !value.hasPrefix("http") {
                    // Respect omission values that have been passed in
                    if !omitLabels.contains(label) {
                        // Make the value names more presentable
                        if let name = child.label?.replacingOccurrences(of: "_", with: " ") {
                            returnText.append(name.capitalized)
                            returnText.append(": ")
                            returnText.append("\(value.capitalized)")
                            
                            // Handle special considerations for units of measurement
                            switch child.label?.lowercased() {
                            case "height", "average_height":
                                returnText.append("(cm)")
                                break
                                
                            case "mass":
                                returnText.append("(kg)")
                                break
                                
                            case "length":
                                returnText.append("(m)")
                                break
                                
                            case "cargo_capacity":
                                returnText.append("(kg)")
                                break
                                
                            case "average_lifespan":
                                returnText.append(" years")
                                break
                                
                            case "diameter":
                                returnText.append("(km)")
                                break
                                
                            case "rotation_period":
                                returnText.append(" hours")
                                break
                                
                            case "orbital_period":
                                returnText.append(" days")
                                break
                                
                            case "gravity":
                                returnText.append("(G)")
                                break
                                
                            case "surface_water":
                                returnText.append("%")
                                break
                                
                            default:
                                break
                            }
                            
                            // Append a new line at the end
                            returnText.append("\n")
                        }
                    }
                }
            }
        }
        
        print(returnText)
        return returnText
    }
}

protocol SWAVGable {
    var infoURL: String { get set }
}

extension SWAVGable {
    func getSWAVGImageUrl(_ type: String) -> String? {
        // This is simply a quick and dirty way to get the images since they are not available via SWAPI. It would be safer to find a consistent data source for these, or include them in the project bundle.
        
        // Ensure we have a valid SWAPI URL to start
        guard infoURL.hasPrefix("http://swapi.") else {
            print("not a SWAPI url. low confidence, abort")
            return nil
        }
        
        // Strip all the unnecessary prefixes and symbols from the URL
        var pieces = infoURL.components(separatedBy: "/")
        pieces.removeLast()
        
        if let charID = pieces.last {
            // Construct a URL that points to the Star Wars: A Visual Guide site which has the images we need
            let SWAVGURLString = "https://starwars-visualguide.com/assets/img/\(type)/\(charID).jpg"
            return SWAVGURLString
        }
        
        return nil
    }
}
