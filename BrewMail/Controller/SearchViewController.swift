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
        
        // Function so keyboard hides when tapped outside. See Keyboard Related Code below.
        hideKeyboardWhenTappedAround()
        
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

// MARK: - Keyboard Related Code

extension SearchViewController {
    
    // Hides keyboard when tapped outside
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // References function above
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
