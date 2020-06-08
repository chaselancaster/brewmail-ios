//
//  BeerData.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/1/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import Foundation

struct Root: Codable {
    
    let response: BeersResponse
    
}

struct BeersResponse: Codable {
    
    let beers: BeersPacket
    
}

struct BeersPacket: Codable {
    
    let items: [Beers]
    
}

struct Beers: Codable {
    
    let beer: Beer
    let brewery: Brewery
}

struct Beer: Codable {
    
    let bid: Int
    let beer_name: String
    let beer_label: String
    let beer_abv: Double
    let beer_ibu: Int
    let beer_description: String
    
}

struct Brewery: Codable {
    
    let brewery_name: String
    let brewery_label: String
    
}
