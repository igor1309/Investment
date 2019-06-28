//
//  EditAssetForm.swift
//  Investment
//
//  Created by Igor Malyarov on 27.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct EditAssetForm : View {
    @State var asset: Asset
    
    var body: some View {
        Form {
            Section(header: Text("Asset or Expense".uppercased())) {
                
                VStack(alignment: .leading) {
                    Text("Name")
                        .padding(0)
                        TextField($asset.name, placeholder: Text("New Asset or Expense"))
                            .textFieldStyle(.roundedBorder)
                            .foregroundColor(.accentColor)
                }
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .padding(0)
                        TextField($asset.description, placeholder: Text("Description of the New Asset or Expense"))
                            .lineLimit(nil)
                            .textFieldStyle(.roundedBorder)
                            .foregroundColor(.accentColor)
                }
            
                VStack {
                    HStack {
                        Text("Lifetime, years:")
                        Spacer()
                        }.padding(0)
                    
                    SegmentedControl(selection: $asset.lifetime) {
                        ForEach(1...7) { index in
                            Text("\(index)").tag(index)
                        }
                    }
                }
            
                Toggle(isOn: $asset.isDepreciable) {
                    Text("Asset is Depreciable")
                }
    
                HStack {
                    Text("Amount, €")
                    TextField(.constant("150000"), placeholder: Text("Value of the Asset or Expense"))
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.accentColor)
                }
    
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("¿ Save ?")
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }
            
            .navigationBarTitle(Text("New Asset or Expense"))
    }
}

#if DEBUG
struct EditAssetForm_Previews : PreviewProvider {
    static var previews: some View {
        EditAssetForm(asset: Asset())
//            .previewLayout(.sizeThatFits)
    }
}
#endif
