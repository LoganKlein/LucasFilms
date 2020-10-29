//
//  WebServices.swift
//  LucasFilms
//
//  Created by Logan Klein on 10/28/20.
//

import UIKit
import Alamofire
import ObjectMapper

class WebServices: NSObject {
    
    let sessionManager = Alamofire.Session.default
    let baseSWAPIURL = "https://swapi.dev/api/"
    static var instance: WebServices!
    
    // MARK: - Shared instance
    class func shared() -> WebServices {
        self.instance = (self.instance ?? WebServices())
        return self.instance
    }
    
    // MARK: - Generic Collection
    
    func getAllItemsOfType<T: BaseMappable>(_ type: T, suffix: String, _ callback: @escaping (_ items: [T]?)->()) {
        let endpoint = "\(baseSWAPIURL)\(suffix)"
        sessionManager.request(endpoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) .response { response in
            if let jsonData = response.data {
                if let json = WebServices.dataToJSON(data: jsonData) {
                    let result = Mapper<SWGenericArrayResult>().map(JSON: json as! [String : Any])
                    let results = Mapper<T>().mapArray(JSONArray: result?.results as! [[String : Any]])
                    callback(results)
                    return
                }
            }
        }
    }
    
    func getItemsFromList<T: BaseMappable>(_ type: T, _ list: [String]?, _ callback: @escaping (_ items: [T]?) -> ()) {
        guard let endpoints = list else {
            print("endpoints missing")
            callback(nil)
            return
        }
        
        var returnList: [T] = []
        var responses = 0
        
        for url in endpoints {
            getItem(type, url) { (item) in
                if let item = item {
                    returnList.append(item)
                }
                
                responses += 1
                
                if responses == endpoints.count {
                    callback(returnList)
                    return
                }
            }
        }
    }
    
    func getItem<T: BaseMappable>(_ type: T, _ fromURL: String?, _ callback: @escaping (_ item: T?) -> ()) {
        guard let endpoint = fromURL else {
            print("endpoint missing")
            callback(nil)
            return
        }
        
        sessionManager.request(endpoint, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil) .response { response in
            if let jsonData = response.data {
                if let json = WebServices.dataToJSON(data: jsonData) {
                    let item = Mapper<T>().map(JSON: json as! [String : Any])
                    callback(item)
                    return
                }
            }
            
            callback(nil)
        }
    }
    
    // MARK: - JSON Extraction
    
    public class func dataToJSON(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        
        return nil
    }
}
