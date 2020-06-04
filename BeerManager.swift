//
//  BeerManager.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/2/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import Foundation

protocol BeerManagerDelegate {
    
    func didSearchBeer(_ beerManager: BeerManager, beers: [Beer])
    
}

struct BeerManager {
    
    let baseURL = "https://api.untappd.com/v4/"
    
    let clientID = "890DD1105A2483401A50DEE63A4369641B1E9F2C"
    let clientSecret = "ED374F4D5737AB079E99198D36F42B656E874F1F"
    
    var delegate: SearchViewController?
    
    func searchBeer(with name: String) {
        
        let urlString = "\(baseURL)search/beer?q=\(name)&client_id=\(clientID)&client_secret=\(clientSecret)"
        print(urlString, "<-- urlString")
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        // Creating the URL
        print("creating URL")
        if let url = URL(string: urlString) {
            // Creating a URLSession
            print("creating session")
            let session = URLSession(configuration: .default)
            // Give session a task
            print("creating dataTask")
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                // Check for errors
                if error == nil && data != nil {
                    // parseJSON function
                    if let safeData = data {
                        self.parseJSON(safeData)
                    }
                }
                
            }
            dataTask.resume()
        }
        
    }
    
    func parseJSON(_ beerData: Data) -> [Beer]? {

        // Parse JSON
        print("parseJSON function hit")
        let decoder = JSONDecoder()
        print(beerData, "<-- beerData")
        do {
            var beerArray = [Beer]()
            let beerResponse = try decoder.decode(Root.self, from: beerData)
//            print(beerResponse, "<-- beerResponse")
            let beerSearchResults = beerResponse.response.beers.items
//            let beerItems = beerResponse.response.beers.items
            for item in beerSearchResults {
                let beer = item.beer
                let finalBeer = Beer(bid: beer.bid, beer_name: beer.beer_name, beer_label: beer.beer_label, beer_abv: beer.beer_abv, beer_ibu: beer.beer_ibu, beer_description: beer.beer_description)
                beerArray.append(finalBeer)
            }
            print(beerArray, "<--beerArray")
            return beerArray
        }
        catch {
            print(error, "<--Error in JSON parsing")
            return nil
        }

    }
    
}
