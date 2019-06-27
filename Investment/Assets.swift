//
//  Assets.swift
//  Investment
//
//  Created by Igor Malyarov on 27.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Asset : Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var lifetime: Int           // in years
    var isDepreciable: Bool     // non Depreciable assets are expences forming Working Capital
    var value: Int
    
    init() {
        name = "New Asset or Expense"
        description = "Description of the New Asset or Expense"
        lifetime = 5
        isDepreciable = true
        value = 35000
    }

    init(name: String, description: String, lifetime: Int, isDepreciable: Bool, value: Int) {
        self.name = name
        self.description = description
        self.lifetime = lifetime
        self.isDepreciable = isDepreciable
        self.value = value
    }
}


struct Assets {
    var selingPrice: Int
    var allAdditions: Int
    var services: Int
    var bureaucracy: Int
    var rentDeposit: Int
    var maxLoss: Int
    var extraCapital: Int
}


#if DEBUG
let testAssets = [
    Assets(selingPrice: 280000, allAdditions: 157000, services: 8800, bureaucracy: 6700, rentDeposit: 7700, maxLoss: 47600, extraCapital: 25000),
    Assets(selingPrice: 280000, allAdditions: 157000, services: 8800, bureaucracy: 6700, rentDeposit: 7700, maxLoss: 47600, extraCapital: 25000)
]

let testAssetsNew = [
    Asset(name: "Selling Price", description: "Asked or estimated price", lifetime: 5, isDepreciable: true, value: 280000),
    Asset(name: "All Additions", description: "Furniture, Kitchen, Structural, Renovation, etc", lifetime: 5, isDepreciable: true, value: 157000),
    Asset(name: "Services", description: "Real estate agent graphic designer, web, PR (openning), etc", lifetime: 3, isDepreciable: true, value: 8800),
    Asset(name: "Bureaucracy", description: "Notary, company registration, etc", lifetime: 3, isDepreciable: true, value: 6700),
    Asset(name: "Rent Deposit", description: "", lifetime: 0, isDepreciable: false, value: 7700),
    Asset(name: "Max Cumulative Loss", description: "Estimated peak cummulative loss to be finaced by investment", lifetime: 0, isDepreciable: false, value: 47600),
    Asset(name: "Extra Working Capital", description: "\"Buffer\"", lifetime: 0, isDepreciable: false, value: 25000)
]
#endif
