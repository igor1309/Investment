//
//  RunModal.swift
//  Investment
//
//  Created by Igor Malyarov on 28.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RunModal : View {
    @State private var modal = false
    var body: some View {
        Button(action: {
            self.modal.toggle()
        }) {
            Text("Run Modal")
            }
            .presentation(!modal ? nil : Modal(ModalDetail(), onDismiss: {
                self.modal.toggle()
            }))
    }
}

#if DEBUG
struct RunModal_Previews : PreviewProvider {
    static var previews: some View {
        RunModal()
    }
}
#endif
