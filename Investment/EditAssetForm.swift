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
                    TextField("New Asset or Expense", text: $asset.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.accentColor)
                }
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .padding(0)
                    TextField("Description of the New Asset or Expense", text: $asset.description)
                            .lineLimit(nil)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(.accentColor)
                }
            
                VStack {
                    HStack {
                        Text("Lifetime, years:")
                        Spacer()
                        }.padding(0)
                    
                    Picker("Lifetime", selection: $asset.lifetime) {
                        ForEach(1..<8) { index in
                            Text("\(index)").tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            
                Toggle(isOn: $asset.isDepreciable) {
                    Text("Asset is Depreciable")
                }
    
                HStack {
                    Text("Amount, €")
                    TextField("Value of the Asset or Expense", text: .constant("150000"))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.accentColor)
                }
    
                HStack {
                    Spacer()
                    //  MARK: -
                    //  TODO: save and dismiss view
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
