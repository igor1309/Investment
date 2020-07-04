//
//  ProjectRow.swift
//  Investment
//
//  Created by Igor Malyarov on 28.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ProjectRow : View {
    var project: Project
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(project.name)
                
                Spacer()
                
                Text("\(String(project.currency.rawValue)) \(project.budget)") //MARK: сделать форматирование числа
                    .font(.callout)
            }
            
            HStack {
                Text(project.city)
                    .font(.callout)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(project.status.rawValue)
                    .font(.footnote)
                    .foregroundColor(.primary)
            }

            Text(project.description)
                .font(.callout)
                .foregroundColor(.secondary)
                .lineLimit(nil)

            HStack(alignment: .firstTextBaseline) {
//                Image(systemName: "doc.plaintext")
//                    .imageScale(.small)
//                    .foregroundColor(.secondary)
                Text("❂")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Text("" + project.comment)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(nil)
            }
        }
    }
}

#if DEBUG
struct ProjectRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ProjectRow(project: testProjects[2])
                .previewLayout(.sizeThatFits)
            ProjectRow(project: testProjects[2])
                .previewLayout(.sizeThatFits)
                .environment(\.sizeCategory, .extraExtraLarge)
        }
    }
}
#endif
