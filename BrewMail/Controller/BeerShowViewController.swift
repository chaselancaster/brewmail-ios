//
//  BeerShowViewController.swift
//  BrewMail
//
//  Created by Chase Lancaster on 6/8/20.
//  Copyright © 2020 Chase Lancaster. All rights reserved.
//

import UIKit

class BeerShowViewController: UIViewController {
    
    
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
    }
    
}
