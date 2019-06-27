//
//  ContentView.swift
//  Investment
//
//  Created by Igor Malyarov on 27.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @State private var isAssetsOpen = false
    @State private var isWorkingCapitalOpen = true
    
    let ass = Assets(selingPrice: 280000, allAdditions: 157000, services: 8800, bureaucracy: 6700, rentDeposit: 7700, maxLoss: 47600, extraCapital: 25000)

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Assets".uppercased())) {
                    
                    SectionTotal(total: "Total Assets",
                                 value: ass.selingPrice + ass.allAdditions + ass.services + ass.bureaucracy,
                                 isOpen: isAssetsOpen).previewLayout(.sizeThatFits)
                        .tapAction { self.isAssetsOpen.toggle() }
                    
                    
                    if isAssetsOpen {
                        SectionItem(heading: "Selling Price",
                                    subHeading: "Asked or estimated price",
                                    value: ass.selingPrice)
                        
                        
                        SectionItem(heading: "All Additions",
                                    subHeading: "Furniture, Kitchen, Structural, Renovation, etc",
                                    value: ass.allAdditions)
                    
                        SectionItem(heading: "Services",
                                    subHeading: "Real estate agent graphic designer, web, PR (openning), etc",
                                    value: ass.services)
                    
                        SectionItem(heading: "Bureaucracy",
                                    subHeading: "Notary, company registration, etc",
                                    value: ass.bureaucracy)
                        
                    }
                }
                
                Section(header: Text("Working Capital".uppercased())) {
                    
                    SectionTotal(total: "Working Capital",
                                 value: ass.rentDeposit + ass.maxLoss + ass.extraCapital,
                                 isOpen: isWorkingCapitalOpen).previewLayout(.sizeThatFits)
                        .tapAction { self.isWorkingCapitalOpen.toggle() }
                    
                    if isWorkingCapitalOpen {
                        SectionItem(heading: "Rent Deposit",
                                    subHeading: "",
                                    value: ass.rentDeposit)
//TODO: - сделать изменение значения при двойном тапе вызовом нового вью
//  для тестирования   destination: Text("view for editing…")
                        
                        SectionItem(heading: "Max Cumulative Loss",
                                    subHeading: "Estimated peak cummulative loss to be finaced by investment",
                                    value: ass.maxLoss)
                        
                        SectionItem(heading: "Extra Working Capital",
                                    subHeading: "\"Buffer\"",
                                    value: ass.extraCapital)
                    }
                }
            
                Section(header: Text("Investment".uppercased())) {
                    HStack {
                        Text("Total Investment".uppercased())
                        Spacer()
                        Text("\(ass.selingPrice + ass.allAdditions + ass.services + ass.bureaucracy + ass.rentDeposit + ass.maxLoss + ass.extraCapital)")
                            .padding(.trailing)
                    }
                    
                }
            }
                
                .navigationBarTitle(Text("Investment"))
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .environment(\.colorScheme, .dark)
//                .environment(\.sizeCategory, .extraExtraLarge)
        }
    }
}
#endif
