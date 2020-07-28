//
//  CellarViewController.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/19/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import Firebase
import Foundation
import UIKit

class CellarViewController: UITableViewController {
    
    @IBOutlet var beerLabel: UIImageView!
    @IBOutlet var beerName: UILabel!
    @IBOutlet var breweryName: UILabel!
    @IBOutlet var beerStyle: UILabel!
    
    var cellarBeer = [[String:Any]]()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        
        // Finding current user's id
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").document("\(uid)").collection("cellarBeer").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.cellarBeer.append(document.data())
                }
                print("cellarBeer ---->", self.cellarBeer)
            }
        }
        
    }
    
}

// MARK: - Table View Code

//extension CellarViewController {
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cellarBeer.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.beerCell, for: indexPath) as! BeerTableViewCell
//        let beer = cellarBeer[indexPath.row]
//        cell.beerName.text = beer.beerName
//        cell.breweryName.text = beer.breweryName
//        cell.beerStyle.text = beer.beerStyle
//        cell.beerLabel.sd_setImage(with: URL(string: beer.beerLabel), placeholderImage: UIImage(named: "placeholder.png"))
////        cell.textLabel?.text = beer.beerName
////        cell.detailTextLabel?.text = "\(beer.beerStyle) ABV: \(beer.beerAbv) | IBU: \(beer.beerIbu)"
//
//        return cell
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! BeerShowViewController
//
//        if let indexPath = tableView.indexPathForSelectedRow {
//            destinationVC.beerToShow = cellarBeer[indexPath.row]
//        }
//    }
//
//}
