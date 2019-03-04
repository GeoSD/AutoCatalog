//
//  Enums.swift
//  AutoCatalog
//
//  Created by Georgy Dyagilev on 02/03/2019.
//  Copyright © 2019 Georgy Dyagilev. All rights reserved.
//

import Foundation

enum CarClass: String, Codable, CaseIterable {
    case classA = "Класс А"
    case classB = "Класс В"
    case classC = "Класс С"
    case classD = "Класс D"
    case classE = "Класс Е"
    case classF = "Класс F"
    case classG = "Класс G"
    case classH = "Класс H"
    case classSUV = "Класс SUV"
    case classMPV = "Класс MPV"
}

enum CarType: String, Codable, CaseIterable {
    case sedan = "Седан"
    case hatchback = "Хэтчбек"
    case universal = "Универсал"
    case liftback = "Лифтбэк"
    case cupe = "Купе"
    case cabrioletcase = "Кабриолет"
    case rodster = "Родстер"
    case targa = "Тарга"
    case limo = "Лимузин"
    case stretch = "Стретч"
    case offroad = "Внедорожник"
    case crossover = "Кроссовер"
    case pickup = "Пикап"
    case furgon = "Фургон"
    case minivan = "Минивэн"
    case microautobus = "Микроавтобус"
    
}
