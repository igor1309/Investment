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
    
    var body: some View {
        HStack {
            Text(total.uppercased()).font(.subheadline)
            Spacer()
            Text("\(value)")
            Image(systemName: isOpen ? "chevron.up" : "chevron.down")
                .foregroundColor(.accentColor)
                .imageScale(.small)
        }
    }
}

#if DEBUG
struct SectionTotal_Previews : PreviewProvider {
    static var previews: some View {
        SectionTotal(total: "Total Assets", value: 255000, isOpen: true).previewLayout(.sizeThatFits)
    }
}
#endif
