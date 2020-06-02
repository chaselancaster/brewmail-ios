//
//  BeerData.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/1/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import Foundation

struct BeerResponse: Codable {
    
    let beers:
    
}

struct Beers: Codable {
    
    let count: Int?
    let items: [Item]
    
}

struct Item: Codable {
    
    let beer: [Beer]

}

struct Beer: Codable {
    
    let beer_name: String
    let beer_label: String
    let beer_abv: String
    let beer_ibu: String
    let beer_description: String
    
}
