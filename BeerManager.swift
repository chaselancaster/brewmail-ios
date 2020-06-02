//
//  BeerManager.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/2/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import Foundation

struct BeerManager {
    
    let baseURL = "https://api.untappd.com/v4/"
    
    let clientID = "890DD1105A2483401A50DEE63A4369641B1E9F2C"
    let clientSecret = "ED374F4D5737AB079E99198D36F42B656E874F1F"
    
    var delegate: SearchViewController?
    
    func searchBeer(with name: String) {
        
        let urlString = "\(baseURL)search/beer?q=\(name)&client_id=\(clientID)&client_secret=\(clientSecret)"
//        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        // Creating the URL
        if let url = URL(string: urlString) {
            // Creating a URLSession
            let session = URLSession(configuration: .default)
            // Give session a task
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                // Check for errors
                if error == nil && data != nil {
                    // Parse JSON
                    let decoder = JSONDecoder()
                    
                    do {
                        let beerResponse = try decoder.decode(BeerResponse.self, from: data!)
                        print(beerResponse, "<-- beerResponse")
                    }
                    catch {
                        print("Error in JSON parsing")
                    }
                }
                
            }
            dataTask.resume()
        }
        
    }
    
}
