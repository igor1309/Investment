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
                
                Text("\(project.budget)") //MARK: сделать форматирование числа
                    .font(.callout)
            }
            
            Text(project.city)
                .font(.callout)
                .color(.secondary)
            
            Text(project.decribtion)
                .font(.callout)
                .color(.secondary)
                .lineLimit(nil)
        }
    }
}

#if DEBUG
struct ProjectRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ProjectRow(project: testProjects[0])
                .previewLayout(.sizeThatFits)
            ProjectRow(project: testProjects[0])
                .previewLayout(.sizeThatFits)
                .environment(\.sizeCategory, .extraExtraLarge)
        }
    }
}
#endif
