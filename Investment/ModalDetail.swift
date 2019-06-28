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
    
    var body: some View {
        VStack {
            Text("Modal details here.")
            TextField(.constant("some value"))
                .textFieldStyle(.roundedBorder)
                .foregroundColor(.accentColor)
            TextField(.constant("some value 2"),
                      placeholder: Text("some text"),
                      onEditingChanged: { (editting) in
                        self.editingHappened = editting
            })
                .textFieldStyle(.roundedBorder)
                .foregroundColor(.accentColor)
        }.padding()
    }
}

#if DEBUG
struct ModalDetail_Previews : PreviewProvider {
    static var previews: some View {
        ModalDetail().previewLayout(.sizeThatFits)
    }
}
#endif
