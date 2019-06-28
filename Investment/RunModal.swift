//
//  RunModal.swift
//  Investment
//
//  Created by Igor Malyarov on 28.06.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RunModal : View {
    @State private var isShown = false
    
    var body: some View {
        VStack {
            Button(action: {
                self.isShown.toggle()
            }) {
                Text("Run Modal")
                }
                .presentation(!isShown ? nil : Modal(ModalDetail(isShown: $isShown), onDismiss: {
                    self.isShown.toggle()
                }))
        }
    }
}

#if DEBUG
struct RunModal_Previews : PreviewProvider {
    static var previews: some View {
        RunModal()
    }
}
#endif
