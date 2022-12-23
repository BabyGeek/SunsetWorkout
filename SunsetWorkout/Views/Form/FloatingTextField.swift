//
//  FloatingTextField.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 15/10/2022.
//

import SwiftUI

struct FloatingTextField<LabelContent>: View where LabelContent: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: LocalizedStringKey
    private var placeHolderSuffix: String = ""
    @Binding var text: String
    private let bgColor: Color
    @FocusState var isInputActive: Bool
    var labelContent: LabelContent?

    var suffixText: LocalizedStringKey {
        LocalizedStringKey(self.placeHolderSuffix)
    }

    public init(placeHolder: LocalizedStringKey,
                placeHolderSuffix: String? = nil,
                text: Binding<String>,
                bgColor: Color,
                @ViewBuilder labelContent: () -> LabelContent? = { nil }) {
        self._text = text
        self.placeHolderText = placeHolder
        
        if let placeHolderSuffix {
            self.placeHolderSuffix = "(\(placeHolderSuffix))"
        }

        self.bgColor = bgColor
        self.labelContent = labelContent()
    }

    var shouldPlaceHolderMove: Bool {
        isInputActive || (text.count != 0)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            if shouldPlaceHolderMove {
                if let labelContent {
                    labelContent
                        .font(.caption)
                        .font(.system(size: 8, weight: .semibold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            TextField(
                placeHolderText,
                text: $text,
                prompt: Text(placeHolderText))
            .frame(height: 30)
        }
        .transition(.move(edge: .bottom))
        .animation(.linear, value: text.isEmpty)
    }
}

#if DEBUG
struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTextField(
            placeHolder: "Preview",
            placeHolderSuffix: "secs",
            text: .constant("g"),
            bgColor: Color(.systemBackground),
            labelContent: {
                Text("test")
            })
    }
}
#endif
