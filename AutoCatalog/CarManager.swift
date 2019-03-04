//
//  CarManager.swift
//  AutoCatalog
//
//  Created by Georgy Dyagilev on 27/02/2019.
//  Copyright © 2019 Georgy Dyagilev. All rights reserved.
//

import Foundation

class CarManager: Codable {
    
    static let shared = CarManager()
    
    private init() { }
        
    func loadCarsFromUserDefaults() -> [Car] {
        let savedCars = UserDefaults(suiteName: "SavedCarCatalog")?.data(forKey: "cars")
        if let savedCars = savedCars,
            let cars = try? JSONDecoder().decode([Car].self, from: savedCars) {
            return cars
        } else {
            return loadPredefinedCars()
        }
    }
    
    func saveCarsToUserDefaults(_ cars: [Car]) {
        let encodedCars = try? JSONEncoder().encode(cars)
        UserDefaults(suiteName: "SavedCarCatalog")?.set(encodedCars, forKey: "cars")
    }
    
    fileprivate func loadPredefinedCars() -> [Car] {
        let someCars: [Car] = [
            Car(year: 2019, model: "S500", manufacturer: "Mersedes", carClass: .classF, carType: .sedan),
            Car(year: 1980, model: "469", manufacturer: "УАЗ", carClass: .classSUV, carType: .offroad),
            Car(year: 1983, model: "2101", manufacturer: "ВАЗ", carClass: .classC, carType: .sedan)
        ]
        return someCars
    }
}
