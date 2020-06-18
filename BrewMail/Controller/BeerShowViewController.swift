//
//  BeerShowViewController.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/8/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import Firebase
import SDWebImage
import UIKit

class BeerShowViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerName: UILabel!
    @IBOutlet var beerStyle: UILabel!
    @IBOutlet var beerABV: UILabel!
    @IBOutlet var beerIBU: UILabel!
    @IBOutlet var breweryName: UILabel!
    @IBOutlet var beerDescription: UITextView!
    
    var beerToShow: BeerModel?
    
    override func viewDidLoad() {
        print(beerToShow, "<--beerToShow")
        
        if let beer = beerToShow {
            beerName.text = beer.beerName
            beerStyle.text = beer.beerStyle
            beerABV.text = "ABV: \(String(beer.beerAbv))"
            beerIBU.text = "IBU: \(String(beer.beerIbu))"
            breweryName.text = beer.breweryName
            beerDescription.text = beer.beerDescription
            beerImageView.sd_setImage(with: URL(string: beer.beerLabel), placeholderImage: UIImage(named: "placeholder.png"))
        }
        
    }
    
    @IBAction func addToCellarButtonTapped(_ sender: Any) {
        if let beer = beerToShow {
            // Finding current user
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            let beerData: [String: Any] = [
                "bid": beer.bid,
                "beerName": beer.beerName,
                "beerLabel": beer.beerLabel,
                "beerAbv": beer.beerAbv,
                "beerIbu": beer.beerIbu,
                "beerDescription": beer.beerDescription,
                "beerStyle": beer.beerStyle,
                "breweryId": beer.breweryId,
                "breweryName": beer.breweryName,
                "breweryLabel": beer.breweryLabel
            ]
            db.collection("users").document("\(uid)").collection("cellarBeer").document("\(beer.beerName)").setData(beerData) { err in
                if let err = err {
                    print("Error adding cellarBeer document: \(err)")
                } else {
                    print("Beer successfully added to cellarBeer")
                }
            }
            
        }
        
    }
}
