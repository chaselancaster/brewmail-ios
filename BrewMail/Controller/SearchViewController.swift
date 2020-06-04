//
//  SearchViewController.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/1/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    var beerManager = BeerManager()
    
    var beersFromSearch = [Beer]()
    
    override func viewDidLoad() {
        
        // Setting the VC as BeerManager's delegate
        beerManager.delegate = self
        
        beerManager.searchBeer(with: "Oberon")
        
    }
    
}

extension SearchViewController: BeerManagerDelegate {
    
    func didSearchBeer(_ beerManager: BeerManager, beers: [Beer]) {
        <#code#>
    }
    
    func didFailWithError(error: Error) {
        <#code#>
    }
    
}
