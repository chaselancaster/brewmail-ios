//
//  BeerModel.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/3/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import Foundation

struct BeerModel: Codable {
    
    let bid: Int
    let beerName: String
    let beerLabel: String
    let beerAbv: Double
    let beerIbu: Int
    let beerDescription: String
    let beerStyle: String
    let breweryId: Int
    let breweryName: String
    let breweryLabel: String
    
    enum CodingKeys: String, CodingKey {
        case bid
        case beerName
        case beerLabel
        case beerAbv
        case beerIbu
        case beerDescription
        case beerStyle
        case breweryId
        case breweryName
        case breweryLabel
    }
    
}
