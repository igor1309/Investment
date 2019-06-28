//
//  ModalDetail.swift
//  Investment
//
//  Created by Igor Malyarov on 28.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ModalDetail : View {
    @State private var editingHappened = false
    @Binding var isShown: Bool
    
    @State private var stateOfTextField = "какой-то текст"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Modal details here:").font(.headline)
                
                TextField(.constant(""),
                          placeholder: Text("some value"),
                          onEditingChanged: { (editting) in
                            self.editingHappened = editting
                })
                    .textFieldStyle(.roundedBorder)

                //  MARK: -
                //  MARK: нужно разобраться с onEditingChanged: и onCommit: для TextField
                TextField(.constant("some value 2"),
                          placeholder: Text("some text"),
                          onEditingChanged: { (changed) in
                            self.stateOfTextField = "Editing Changed"
                }) {
                    self.stateOfTextField = "Editing Commited"
                    }
                    .textFieldStyle(.roundedBorder)
                
                Text(stateOfTextField)
                
            }.padding()
            
                .navigationBarTitle(Text("Modal"))
                .navigationBarItems(trailing: Button(action: {
                    self.isShown.toggle() }) {
                HStack {
                    Text(editingHappened ? "Save(Done)" : "Cancel")
                    Image(systemName: "xmark")
                }
                })
        }
    }
}

#if DEBUG
struct ModalDetail_Previews : PreviewProvider {
    static var previews: some View {
        ModalDetail(isShown: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
#endif
