//
//  Car.swift
//  AutoCatalog
//
//  Created by Georgy Dyagilev on 02/03/2019.
//  Copyright © 2019 Georgy Dyagilev. All rights reserved.
//

import Foundation
class Car: Codable {
    var year: Int
    var model: String
    var manufacturer: String
    var carClass: CarClass
    var carType: CarType
    
    init(year: Int, model: String, manufacturer: String, carClass: CarClass, carType: CarType) {
        self.year = year
        self.model = model
        self.manufacturer = manufacturer
        self.carClass = carClass
        self.carType = carType
    }
}
