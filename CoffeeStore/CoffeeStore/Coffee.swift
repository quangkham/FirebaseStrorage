//
//  Coffee.swift
//  CoffeeStore
//
//  Created by Quang Kham on 20/05/2020.
//  Copyright © 2020 Quang Kham. All rights reserved.
//

import Foundation

class Coffees{
    
    var coffees : [Coffee] = []
    
    enum CodingKeys : String , CodingKey{
        case coffees = "coffees"
    }
}

class Coffee {
    
    var name : String?
    var description : String?
    var image : String?
    var price : [String :Any]?
}



class CoffeePrice{
    var small : String?
    var meduium : String?
    var large : String?
    var extra_large : String?
}
