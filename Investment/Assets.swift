//
//  Assets.swift
//  Investment
//
//  Created by Igor Malyarov on 27.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

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
#endif
