//
//  DcSuperHero.swift
//  MdFahimFaezAbir-30028
//
//  Created by Bjit on 8/12/22.
//

import Foundation


struct DcSuperHero{
    var name: String
    var image: String
}
extension DcSuperHero{
    static var dcSuperHero = [DcSuperHero(name: "Batman", image: "batman"),
        DcSuperHero(name: "SuperMan", image: "superMan"),
        DcSuperHero(name: "Wonder Women", image: "wonderwomen"),
      DcSuperHero(name: "The Flash", image: "flash")
    ]
}
