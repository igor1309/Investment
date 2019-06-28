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
    
    @State private var isAssetsOpen = false
    @State private var isWorkingCapitalOpen = false
    @State private var showingEditSheet = false
    
    let currency = "€"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Assets".uppercased())) {
                    SectionTotal(total: "Total Assets",
                                 value: store.assets.filter({ $0.isDepreciable }).reduce(0, { $0 + $1.value }),
                                 isOpen: isAssetsOpen,
                                 depreciation: store.assets.filter({ $0.isDepreciable }).reduce(0, { $0 + $1.value / $1.lifetime / 12 }))
                        .tapAction { self.isAssetsOpen.toggle() }
                    
                    if isAssetsOpen {
                        ForEach(store.assets) { asset in if asset.isDepreciable {
                            // MARK: заменить на реальный
                            NavigationButton(destination: EditAssetForm(asset: asset)) {
                                SectionItem(heading: asset.name, subHeading: asset.description, value: asset.value, lifetime: asset.lifetime)
                            }
                            //TODO: - сделать изменение значения при двойном тапе вызовом нового вью
                            //  для тестирования   destination: Text("view for editing…")
                            }
                        }
                    }
                }
                
                Section(header: Text("Working Capital".uppercased()),
                        footer: Text("Working Capital includes items other than Assets t be financed from Investment (Capital), not Operations.").lineLimit(3)) {
        //  MARK: - заменить выше на lineLimit(nil) когда исправят ошибку
                    SectionTotal(total: "Working Capital",
                                 value: store.assets.filter({ !$0.isDepreciable }).reduce(0, { $0 + $1.value }),
                                 isOpen: isWorkingCapitalOpen, depreciation: 0).previewLayout(.sizeThatFits)
                        .tapAction { self.isWorkingCapitalOpen.toggle() }
                    
                    if isWorkingCapitalOpen {
                        ForEach(store.assets) { asset in if !asset.isDepreciable {
                            SectionItem(heading: asset.name, subHeading: asset.description, value: asset.value, lifetime: asset.lifetime)
                            //TODO: - сделать изменение значения при двойном тапе вызовом нового вью
                            //  для тестирования   destination: Text("view for editing…")
                            }
                        }
                    }
                }
            
                Section(header: Text("Investment".uppercased())) {
                    HStack {
                        Text("Total Investment".uppercased())
                        Spacer()
                        Text("\(store.assets.reduce(0, { $0 + $1.value }))")
                            .padding(.trailing)
                    }
                }
                
                Section(header: Text("Notes".uppercased())) {
                    Text("To calculate depreciation we use 3 and 5 years as live-time and straight-line method (equal amounts). We Consider the Salvage value of zero.").italic()
                        .font(.caption)
                        .lineLimit(nil)
                        .foregroundColor(Color.secondary)
                }
            }
                
                .navigationBarTitle(Text("Investment"))
                .navigationBarItems(trailing: PresentationButton(destination: DetailView()) {
                    Image(systemName: "slider.horizontal.3")
                })
        }
    }
    
    var sheet: ActionSheet {
        ActionSheet(title: Text("Action"),
                    message: Text("Quote mark"),
                    buttons: [.default(Text("Woo"), onTrigger: {
            self.showingEditSheet = false
        })])
    }
    
    func value() -> Int {
        store.assets.filter({ $0.isDepreciable }).reduce(0, { $0 + $1.value })
    }
    func depreciation() -> Int {
        store.assets.filter({ $0.isDepreciable }).reduce(0, { $0 + $1.value / $1.lifetime / 12 })
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail")
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(store: AssetStore(assets: testAssetsNew))
//            ContentView(store: AssetStore(assets: testAssetsNew))
//                .environment(\.colorScheme, .dark)
//                .environment(\.sizeCategory, .extraLarge)
        }
    }
}
#endif
