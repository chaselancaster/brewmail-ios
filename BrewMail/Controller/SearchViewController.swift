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
        print("didSearchBeer function hit in SearchVC")
        beersFromSearch.append(contentsOf: beers)
        print(beersFromSearch, "<-- beersFromSearch Array")
    }
    
    func didFailWithError(error: Error) {
        print(error, "<-- didFailWithError function hit in SearchVC")
    }
    
}
