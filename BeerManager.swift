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
        print(urlString)
        
    }
    
}
