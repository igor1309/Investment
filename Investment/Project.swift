//
//  Project.swift
//  Investment
//
//  Created by Igor Malyarov on 28.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Project : Identifiable {
//    var id = UUID()
//    var name: String
//    var decribtion: String
//    var budget: Int
    var id = UUID()
    var name: String = ""
    var decribtion: String = ""
    var city: String = "Berlin"
    var budget: Int = 100000
}

#if DEBUG
let testProjects = [
    Project(name: "To The Bone Charlottenburg", decribtion: "New venture with Giacomo, upscaled To The Bone", budget: 500000),
    Project(name: "Mashya Berlin", decribtion: "Dream project with Yossi & Yoram & Ofer", budget: 1000000)
]
#endif
