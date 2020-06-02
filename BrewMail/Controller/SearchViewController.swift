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
    
    override func viewDidLoad() {
        
        // Setting the VC as BeerManager's delegate
        beerManager.delegate = self
        
        beerManager.searchBeer(with: "Oberon")
        
    }
    
}
