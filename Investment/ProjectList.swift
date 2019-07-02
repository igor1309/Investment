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
        Project(name: "To The Bone Charlottenburg", description: "New venture with Giacomo, upscaled To The Bone", budget: 500000, currency: .euro, status: .preparation, comment: "ищем помещение"),
        Project(name: "Mashya Berlin", description: "Dream project with Yossi & Yoram & Ofer", budget: 1000000, currency: .euro, status: .dream, comment: "и хочется и колется"),
        Project(name: "Грузия by Hatuna", description: "Возможный проект с Хатуной и Тенгизом", city: "Moscow", budget: 18000000, currency: .rub, status: .dead, comment: "Хатуна с Тенгизом сосредоточились на Грузии, в Москве вряд ли будут запускать что-либо")
    ]
    
    var body: some View {
        NavigationView {
            
            List(projects) { project in
                NavigationButton(destination: Text("детали…"), isDetail: true) {
                    ProjectRow(project: project)
                }
            }
            
                .navigationBarTitle(Text("Restaurant Projects"))
                .navigationBarItems(leading: Button(action: {},label: { Image(systemName: "slider.horizontal.3") }),
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

