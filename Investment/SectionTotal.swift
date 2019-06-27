//
//  SectionTotal.swift
//  Investment
//
//  Created by Igor Malyarov on 27.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SectionTotal : View {
    var total: String
    var value: Int
    var isOpen: Bool
    var depreciation: Int
    
    let currency = "€"

    
    var body: some View {
        VStack {
            HStack {
                Text(total.uppercased()).font(.subheadline)
                Spacer()
                Text("\(value)")
                Image(systemName: isOpen ? "chevron.up" : "chevron.down")
                    .foregroundColor(.accentColor)
                    .imageScale(.small)
            }
            if depreciation != 0 {
                Text("Depreciation: \(currency)\(Int(depreciation)) per month")
                    .font(.footnote)
                    .color(.secondary)
            }
        }
    }
}

#if DEBUG
struct SectionTotal_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            SectionTotal(total: "Total Assets", value: 255000, isOpen: true, depreciation: 4566).previewLayout(.sizeThatFits)
            SectionTotal(total: "Total Assets", value: 255000, isOpen: true, depreciation: 0).previewLayout(.sizeThatFits)
        }
    }
}
#endif
