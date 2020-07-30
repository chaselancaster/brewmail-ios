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
    
    
}
