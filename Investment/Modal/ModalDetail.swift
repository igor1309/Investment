//
//  ModalDetail.swift
//  Investment
//
//  Created by Igor Malyarov on 28.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ModalDetail : View {
    @Binding var isShown: Bool
    @State private var hasChanges = false
    
    @State private var stateOfTextField = "какой-то текст"
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Modal details here:").font(.headline)
                
                TextField("some value",
                          text: .constant(""),
                          onEditingChanged: { (editting) in
                            self.hasChanges = editting
                          })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                //  MARK: -
                //  MARK: нужно разобраться с onEditingChanged: и onCommit: для TextField
                TextField("some text",
                          text: .constant("some value 2"),
                          onEditingChanged: { (changed) in
                            self.stateOfTextField = "Editing Changed"
                          }) {
                    self.stateOfTextField = "Editing Commited"
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text(stateOfTextField)
                
            }.padding()
            
            .navigationBarTitle(Text("Modal"))
            
            .navigationBarItems(trailing: closeButton)
        }
    }
    
    private var closeButton: some View {
        Button(action: {
                self.isShown.toggle() }) {
            HStack {
                Text(hasChanges ? "Save(Done)" : "Cancel")
                Image(systemName: "xmark")
            }
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
