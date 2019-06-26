//
//  SectionItem.swift
//  Investment
//
//  Created by Igor Malyarov on 27.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct SectionItem : View {
    var heading: String
    var subHeading: String
    var value: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(heading)
                Text(subHeading)
                    .font(.footnote)
                    .color(.secondary)
                    .lineLimit(nil)
            }
            Spacer()
            Text("\(value)")
                .font(.callout)
                .padding(.trailing)
        }
    }
}

#if DEBUG
struct SectionItem_Previews : PreviewProvider {
    static var previews: some View {
        SectionItem(heading: "Selling Price",
                    subHeading: "Real estate agent graphic designer, web, PR (openning), etc",
                    value: 255000)
            .previewLayout(.sizeThatFits)
    }
}
#endif
