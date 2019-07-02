//
//  Project.swift
//  Investment
//
//  Created by Igor Malyarov on 28.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Project : Identifiable {
    var id = UUID()
    var name: String = ""
    var description: String = ""
    var city: String = "Berlin"
    var budget: Int = 100000
    var currency: Currency

    enum Status: String {   //  could use for filtering
        case dream = "it's just the dream"
        case idea = "idea. why not?"
        case talks = "talking with partners to be"
        case preparation = "preparation"
        case running = "running"
        case dead = "dead project"
    }
    var status: Status
    var comment: String
}

enum Currency: Character {
    case usd = "$", rub = "₽", euro = "€"
}

#if DEBUG
let testProjects = [
    Project(name: "To The Bone Charlottenburg", description: "New venture with Giacomo, upscaled To The Bone", budget: 500000, currency: .euro, status: .preparation, comment: "ищем помещение"),
    Project(name: "Mashya Berlin", description: "Dream project with Yossi & Yoram & Ofer", budget: 1000000, currency: .euro, status: .dream, comment: "и хочется и колется"),
    Project(name: "Грузия by Hatuna", description: "Возможный проект с Хатуной и Тенгизом", city: "Moscow", budget: 18000000, currency: .rub, status: .dead, comment: "Хатуна с Тенгизом сосредоточились на Грузии, в Москве вряд ли будут запускать что-либо")
]
#endif
