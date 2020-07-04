//
//  AssetRow.swift
//  Investment
//
//  Created by Igor Malyarov on 02.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct AssetRow : View {
    var period: Int?
    @State var idDepreciable: Bool
    
    var body: some View {
        VStack {
            Text("Placeholder")
           
            Toggle(isOn: .constant(true)) {
                Text("Lifetime, years:")
            }
            
            if period == nil {
                Picker("", selection: .constant(1)) {
                    ForEach(1..<10) { index in
                        Text("\(index)").tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

#if DEBUG
struct AssetRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            AssetRow(idDepreciable: true)
                .previewLayout(.sizeThatFits)
            AssetRow(idDepreciable: false)
                .previewLayout(.sizeThatFits)
                .environment(\.sizeCategory, .extraExtraLarge)
        }

    }
}
#endif
