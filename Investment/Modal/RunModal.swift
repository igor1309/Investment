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
            //  MARK: -
            //  MARK нужно что-то типа isModalInPresentation (UIKit)
            //  15:00 Modernizing Your UI for iOS 13 - WWDC 2019 - Videos - Apple Developer
            //  https://developer.apple.com/videos/play/wwdc2019/224/
            //  https://developer.apple.com/documentation/uikit/view_controllers/disabling_pulling_down_a_sheet
            //  https://medium.com/@hacknicity/view-controller-presentation-changes-in-ios-13-ac8c901ebc4e
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
