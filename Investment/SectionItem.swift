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
    var lifetime: Int
    
    let currency = "€"
        
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(heading)
                    Text(subHeading)
                        .font(.footnote)
                        .color(.secondary)
                        .lineLimit(nil)
                }
                
                Spacer()

                //MARK: TextField($name, placeholder: Text("\(value)")) ломает выранивание. Пока не найду решение с тектовым полем возвращаю просто Text("…")
                Text("\(value)")
                    .font(.callout)
                    .padding(.trailing)
            }
            
            if lifetime != 0 {
                Text("Depreciation: \(lifetime) years, \(currency)\(value / lifetime / 12) per month")
                    .font(.caption)
                    .color(.secondary)
                    .padding(0)
            }
        }
    }
}

#if DEBUG
struct SectionItem_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            SectionItem(heading: "Selling Price", subHeading: "Real estate agent graphic designer, web, PR (openning), etc", value: 255000, lifetime: 5)
                .previewLayout(.sizeThatFits)
            SectionItem(heading: "Extra Working Capital", subHeading: "\"Buffer\"", value: 255000, lifetime: 0)
                .previewLayout(.sizeThatFits)
        }
    }
}
#endif
