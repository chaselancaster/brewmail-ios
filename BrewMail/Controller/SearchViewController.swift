//
//  SearchViewController.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/1/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    
    var beerManager = BeerManager()
    
    var beersFromSearch = [Beer]()
    
    override func viewDidLoad() {
        
        // Setting the VC as BeerManager's delegate
        beerManager.delegate = self
        searchBar.delegate = self
        
    }
    
}

// MARK: - SearchBarDelegate code

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        if let search = searchBar.text {
          beerManager.searchBeer(with: search)
        }
        // Removing the keyboard when search button is pressed
        searchBar.resignFirstResponder()
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.searchBar.endEditing(true)
//    }
    
}

// MARK: - BeerManagerDelegate code

extension SearchViewController: BeerManagerDelegate {
    
    func didSearchBeer(_ beerManager: BeerManager, beers: [Beer]) {
        print("didSearchBeer hit")
        beersFromSearch.append(contentsOf: beers)
    }
    
    func didFailWithError(error: Error) {
        print(error, "<-- didFailWithError function hit in SearchVC")
    }
    
}
