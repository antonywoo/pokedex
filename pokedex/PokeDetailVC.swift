//
//  PokeDetailVC.swift
//  pokedex
//
//  Created by Cex on 30/07/2016.
//  Copyright © 2016 newmediatechies. All rights reserved.
//

import UIKit

class PokeDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var PokedexId: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseLbl: UILabel!
    @IBOutlet weak var evolutionLbl: UILabel!
    @IBOutlet weak var currentEvo: UIImageView!
    @IBOutlet weak var nextEvo: UIImageView!
    
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalizedString
        var img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        currentEvo.image = img
        
        pokemon.downloadPokemonDetails { () -> () in
            //called after data loads
            self.updateUI()
        }
    }
    
    func updateUI() {

        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenceLbl.text = pokemon.defenceLbl
        heightLbl.text = pokemon.heightLbl
        weightLbl.text = pokemon.weightLbl
        baseLbl.text = pokemon.baseLbl
        evolutionLbl.text =  pokemon.evolutionLbl
        if pokemon.nextEvolution == "" {
            evolutionLbl.text = "No Evolutions"
            nextEvo.hidden = true
        } else {
            nextEvo.hidden = false
            nextEvo.image = UIImage(named: pokemon.nextEvolution)
            var str =  "Next Evolution: \(pokemon.evolutionLbl)"
            
            if pokemon.nextEvolLvl != "" {
                str += " - LVL \(pokemon.nextEvolLvl)"
            }
   
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
