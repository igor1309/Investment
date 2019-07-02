//
//  AssetsList.swift
//  Investment
//
//  Created by Igor Malyarov on 29.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct AssetsList : View {
    
    private func readAssets() -> [Asset] {
        let path = Bundle.main.path(forResource: "content", ofType: "plist")
        print(path ?? "")
        var contentsArray = [Asset]()
        if let path = path {
            if let contentsXML = FileManager.default.contents(atPath: path) {
                do {
                    let plistData = try PropertyListSerialization.propertyList(from: contentsXML, options: [], format: nil)
                    contentsArray = plistData as! Array
                } catch {
                    NSLog("Error when decoding contents from \(path)")
                }
            }
        }
        return contentsArray
    }

    var body: some View {
        let assets = readAssets()
        
        return Form {
            Text("\(assets[0].name)")
            Text("dsvj sdoh fhoigoihf")
        }
    }
}

#if DEBUG
struct AssetsList_Previews : PreviewProvider {
    static var previews: some View {
        AssetsList()
    }
}
#endif
