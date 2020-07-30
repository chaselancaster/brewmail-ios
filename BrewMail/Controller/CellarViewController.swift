//
//  CellarViewController.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/19/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import Firebase
import FirebaseFirestoreSwift
import Foundation
import UIKit

class CellarViewController: UITableViewController {
    
    @IBOutlet var beerLabel: UIImageView!
    @IBOutlet var beerName: UILabel!
    @IBOutlet var breweryName: UILabel!
    @IBOutlet var beerStyle: UILabel!
    
    var cellarBeer = [BeerModel]()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Clearing array so it doesn't duplicate every time a user checks cellar
        cellarBeer = [BeerModel]()
        
        findUserCellarBeer()
        
    }
    
    func findUserCellarBeer() {
        
        // Finding current user's id
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let docRef = db.collection("users").document("\(uid)").collection("cellarBeer")
        
        // Grabbing user cellarBeer from Firestore
        docRef.getDocuments { (snapshot, error) in
            
            if let error = error {
                print("Error retreiving documents from cellarBeer:", error)
            } else if let snapshot = snapshot {
                let firestoreCellarBeer = snapshot.documents.compactMap() { (document) -> BeerModel? in
                    return try? document.data(as: BeerModel.self)
                }
                self.cellarBeer = firestoreCellarBeer
                print("cellarBeer has been populated with the user's cellarBeer in Firestore")
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
 
    }
    
}

// MARK: - Table View Code

extension CellarViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellarBeer.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.beerCell, for: indexPath) as! BeerTableViewCell
        let beer = cellarBeer[indexPath.row]
        cell.beerName.text = beer.beerName
        cell.breweryName.text = beer.breweryName
        cell.beerStyle.text = beer.beerStyle
        cell.beerLabel.sd_setImage(with: URL(string: beer.beerLabel), placeholderImage: UIImage(named: "placeholder.png"))
        //        cell.textLabel?.text = beer.beerName
        //        cell.detailTextLabel?.text = "\(beer.beerStyle) ABV: \(beer.beerAbv) | IBU: \(beer.beerIbu)"
        
        return cell
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let destinationVC = segue.destination as! CellarBeerShowViewController
    
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.beerToShow = cellarBeer[indexPath.row]
            }
        }
    
}
