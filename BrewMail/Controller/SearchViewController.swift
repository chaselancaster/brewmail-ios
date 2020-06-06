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
        if let searchText = searchBar.text {
            beerManager.searchBeer(with: searchText)
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print(beersFromSearch)
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

// MARK: - Table View Code

extension SearchViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beersFromSearch.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.beerCell, for: indexPath)
        
        cell.textLabel?.text = beersFromSearch[indexPath.row].beer_name
        cell.detailTextLabel?.text = "ABV: \(beersFromSearch[indexPath.row].beer_abv) | IBU: \(beersFromSearch[indexPath.row].beer_ibu)"
        
        return cell
    }
    
}
