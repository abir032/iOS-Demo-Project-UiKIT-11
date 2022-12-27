//
//  MarvelSuperHero.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 8/12/22.
//

import Foundation


struct MarvelSuperHero{
    var name: String
    var image: String
}
extension MarvelSuperHero{
    static var marvelSuperHero = [MarvelSuperHero(name: "Iron Man", image: "ironman"),
    MarvelSuperHero(name: "Thor", image: "thor"),
    MarvelSuperHero(name: "Spider Man", image: "spiderman"),
    MarvelSuperHero(name: "Captain America", image: "captainamerica")
    ]
}
