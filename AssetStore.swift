//
//  AssetStore.swift
//  Investment
//
//  Created by Igor Malyarov on 27.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI
import Combine

class AssetStore : BindableObject {
    var assets: [Asset] {
        didSet { didChange.send(()) }
    }
    
    init(assets: [Asset] = []) {
        self.assets = assets
    }
    
    var didChange = PassthroughSubject<Void, Never>()
}
