//
//  pokemon.swift
//  pokedex
//
//  Created by Cex on 30/07/2016.
//  Copyright © 2016 newmediatechies. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _descriptionLbl: String!
    private var _typeLbl: String!
    private var _defenceLbl: String!
    private var _heightLbl: String!
    private var _weightLbl: String!
    private var _baseLbl: String!
    private var _evolutionLbl: String!
    private var _nextEvolution: String!
    private var _nextEvolLvl: String!
    private var _pokemonUrl: String!
    
    var description: String {
        get {
            if _descriptionLbl == nil {
                _descriptionLbl = ""
            }
        return _descriptionLbl
        }
    }
    
    var type: String {
            if _typeLbl == nil {
                _typeLbl = ""
            }
            return _typeLbl
    }
    var defenceLbl: String {
        if _defenceLbl == nil {
            _defenceLbl = ""
        }
            return _defenceLbl
    }
    var heightLbl: String {
        if _heightLbl == nil {
            _heightLbl = ""
        }
        return _heightLbl
    }
    var weightLbl: String {
        if _weightLbl == nil {
            _weightLbl = ""
        }
        return _weightLbl
    }
    var baseLbl: String {
        if _baseLbl == nil {
            _baseLbl = ""
        }
        return _baseLbl
    }
    var evolutionLbl: String {
        if _evolutionLbl == nil {
            _evolutionLbl = ""
        }
        return _evolutionLbl
    }
    var nextEvolution: String {
        if _nextEvolution == nil {
            _nextEvolution = ""
        }
        return _nextEvolution
    }
    var nextEvolLvl: String {
        if _nextEvolLvl == nil {
            _nextEvolLvl = ""
        }
        return _nextEvolLvl
    }
    
    
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weightLbl = weight
                }
                if let height = dict["height"] as? String {
                    self._heightLbl = height
                }
                if let defense = dict["defense"] as? Int {
                    self._defenceLbl = "\(defense)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defenceLbl = "\(defense)"
                }

                print(self._defenceLbl)
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    if let name = types[0]["name"] {
                        self._typeLbl = name.capitalizedString
                    }
                    //go through API and pull all the types and add to types lable w/  '/' before it e.g. typeA / typeB / typeC
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"] {
                                self._typeLbl! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._typeLbl = ""
                }
                print(self._typeLbl)
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")
                        Alamofire.request(.GET, url).responseJSON { response in
                            //view url API code in json (formatter) to see class name, and the type e.g. string, sting, or string, anyobject
                            let result = response.result
                            
                            if let descDict = result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    self._descriptionLbl = description
                                    print(self._descriptionLbl)
                                }
                        }
                            completed()
                    }
                        
                   }
                } else {
                    self._descriptionLbl =  ""
                }
                // this gets called before descArr code bcz it takes a while to d/l
                if let evol = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evol.count > 0 {
                    if let to = evol[0]["to"] as? String {
                        if to.rangeOfString("mega") == nil {
                            if let uri = evol[0]["resource_uri"] as? String {
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvolution = num
                                self._evolutionLbl = to
                                if let lvl = evol[0]["level"] as? Int {
                                    self._nextEvolLvl = "\(lvl)"
                                }
                                print(self._nextEvolLvl)
                                print(self._nextEvolution)
                                print(self._evolutionLbl)
                                
                            }
                            


                        
                    }
                }
                
                } else {
                    self._evolutionLbl = ""
                }
                
                
                }
        }
 }
    
}