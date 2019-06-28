//
//  ProjectList.swift
//  Investment
//
//  Created by Igor Malyarov on 28.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ProjectList : View {
//    var projects = [Project]
    
    @State var projects = [
        Project(name: "To The Bone Charlottenburg", decribtion: "New venture with Giacomo, upscaled To The Bone", budget: 500000),
        Project(name: "Mashya Moscow", decribtion: "Dream project with Yossi & Yoram & Ofer", city: "Moscow", budget: 1000000)
    ]
    
    var body: some View {
        NavigationView {
            
            List(projects) { project in
                ProjectRow(project: project)
            }
            
                .navigationBarTitle(Text("Restaurant Projects"))
                .navigationBarItems(leading: Button(action: {},
                                                    label: { Image(systemName: "slider.horizontal.3") }),
                                    trailing: Button(action: addProject,
                                                     label: { Image(systemName: "plus") }))
        }
    }
    
    func addProject() {
        if let project = projects.randomElement() {
            projects.insert(project, at: 0)
        }
    }
}

#if DEBUG
struct ProjectList_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ProjectList()
            ProjectList()
                .environment(\.colorScheme, .dark)
                .environment(\.sizeCategory, .extraExtraLarge)
        }
    }
}
#endif

