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
    func didFailWithError(error: Error)
}

struct BeerManager {
    
    let baseURL = "https://api.untappd.com/v4/"
    
    let clientID = "890DD1105A2483401A50DEE63A4369641B1E9F2C"
    let clientSecret = "ED374F4D5737AB079E99198D36F42B656E874F1F"
    
    var delegate: SearchViewController?
    
    func searchBeer(with name: String) {
        
        let urlString = "\(baseURL)search/beer?q=\(name)&client_id=\(clientID)&client_secret=\(clientSecret)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        // Creating the URL
        if let url = URL(string: urlString) {
            // Creating a URLSession
            let session = URLSession(configuration: .default)
            // Give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!, "<-- Error after dataTask")
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let beerData = self.parseJSON(safeData) {
                        self.delegate?.didSearchBeer(self, beers: beerData)
                    }
                }
                
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ beerData: Data) -> [BeerModel]? {
        
        // Parse JSON
        let decoder = JSONDecoder()
        do {
            var beerArray = [BeerModel]()
            let beerResponse = try decoder.decode(Root.self, from: beerData)
            //            print(beerResponse, "<-- beerResponse")
            let beerSearchResults = beerResponse.response.beers.items
            //            let beerItems = beerResponse.response.beers.items
            for item in beerSearchResults {
                let beer = item.beer
                let brewery = item.brewery
                let finalBeer = Beer(bid: beer.bid, beer_name: beer.beer_name, beer_label: beer.beer_label, beer_abv: beer.beer_abv, beer_ibu: beer.beer_ibu, beer_description: beer.beer_description)
                beerArray.append(finalBeer)
            }
//            print(beerArray, "<--beerArray")
            return beerArray
        }
        catch {
            print(error, "<--Error in JSON parsing")
            return nil
        }
        
    }
    
}
