//
//  ContentView.swift
//  Investment
//
//  Created by Igor Malyarov on 27.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @ObjectBinding var store = AssetStore()
    
    @State private var isAssetsOpen = true
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
                        ForEach(store.assets) { asset in if asset.isDepreciable {
                            SectionItem(heading: asset.name, subHeading: asset.description, value: asset.value)
                            }
                        }
                    }
                }
                
                Section(header: Text("Working Capital".uppercased())) {
                    
                    SectionTotal(total: "Working Capital",
                                 value: ass.rentDeposit + ass.maxLoss + ass.extraCapital,
                                 isOpen: isWorkingCapitalOpen).previewLayout(.sizeThatFits)
                        .tapAction { self.isWorkingCapitalOpen.toggle() }
                    
                    if isWorkingCapitalOpen {
                        ForEach(store.assets) { asset in if !asset.isDepreciable {
                            //TODO: - сделать изменение значения при двойном тапе вызовом нового вью
                            //  для тестирования   destination: Text("view for editing…")
                            SectionItem(heading: asset.name, subHeading: asset.description, value: asset.value)
                            }
                        }
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
                
                Section(header: Text("Notes".uppercased())) {
                    //TODO: - надо бы текст переписать (копирайт!!)
                    Text("To calculate depreciation we use 3 and 5 years as live-time and straight-line method (equal amounts). We Consider the Salvage value of zero.").italic()
                        .font(.caption)
                        .lineLimit(nil)
                        .foregroundColor(Color.secondary)
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
            ContentView(store: AssetStore(assets: testAssetsNew))
            ContentView(store: AssetStore(assets: testAssetsNew))
                .environment(\.colorScheme, .dark)
                .environment(\.sizeCategory, .extraLarge)
        }
    }
}
#endif
