//
//  CellarBeerShowViewController.swift
//  BrewMail
//
//  Created by Chase Lancaster on 7/30/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import Firebase
import FirebaseFirestoreSwift
import SDWebImage
import UIKit

class CellarBeerShowViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    // Beer being passed in from CellarVC
    var beerToShow: BeerModel?

    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var beerName: UILabel!
    @IBOutlet var beerStyle: UILabel!
    @IBOutlet var beerABV: UILabel!
    @IBOutlet var beerIBU: UILabel!
    @IBOutlet var breweryName: UILabel!
    @IBOutlet var beerDescription: UITextView!
    
    override func viewDidLoad() {
        
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
    
    
}
