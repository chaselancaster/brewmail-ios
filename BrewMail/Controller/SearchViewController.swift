//
//  SearchViewController.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/1/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import UIKit
import SDWebImage

class SearchViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!

    var beerManager = BeerManager()
    
    var beersFromSearch = [BeerModel]()
    
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
    
    func didSearchBeer(_ beerManager: BeerManager, beers: [BeerModel]) {
        beersFromSearch = []
        print("didSearchBeer hit")
        beersFromSearch.append(contentsOf: beers)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
//        print(beersFromSearch, "<-- beersFromSearch")
    }
    
    func didFailWithError(error: Error) {
        print(error, "<-- didFailWithError function hit in SearchVC")
    }
    
}

// MARK: - Keyboard Related code

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

// MARK: - Table View code

extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beersFromSearch.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.beerCell, for: indexPath) as! BeerTableViewCell
        let beer = beersFromSearch[indexPath.row]
        cell.beerName.text = beer.beerName
        cell.breweryName.text = beer.breweryName
        cell.beerStyle.text = beer.beerStyle
        cell.beerLabel.sd_setImage(with: URL(string: beer.beerLabel), placeholderImage: UIImage(named: "placeholder.png"))
//        cell.textLabel?.text = beer.beerName
//        cell.detailTextLabel?.text = "\(beer.beerStyle) ABV: \(beer.beerAbv) | IBU: \(beer.beerIbu)"
        
        return cell
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! BeerShowViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.beerToShow = beersFromSearch[indexPath.row]
        }
    }
    
}

// MARK: - BeerCell code

class BeerTableViewCell: UITableViewCell {
    
    @IBOutlet var beerLabel: UIImageView!
    @IBOutlet var beerName: UILabel!
    @IBOutlet var breweryName: UILabel!
    @IBOutlet var beerStyle: UILabel!
    
}
