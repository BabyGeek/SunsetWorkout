//
//  FloatingTextField.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 15/10/2022.
//

import SwiftUI

struct FloatingTextField: View {
    let textFieldHeight: CGFloat = 50
    private let placeHolderText: LocalizedStringKey
    private let placeHolderSuffix: String
    @Binding var text: String
    private let bgColor: Color
    @State private var isEditing = false

    var test: LocalizedStringKey {
        LocalizedStringKey(self.placeHolderSuffix)
    }

    public init(placeHolder: LocalizedStringKey,
                placeHolderSuffix: String? = nil,
                text: Binding<String>, bgColor: Color) {
        self._text = text
        self.placeHolderText = placeHolder
        self.placeHolderSuffix = placeHolderSuffix != nil ? "(\(placeHolderSuffix!))" : ""
        self.bgColor = bgColor
    }

    var shouldPlaceHolderMove: Bool {
        isEditing || (text.count != 0)
    }

    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $text, onEditingChanged: { (edit) in
                isEditing = edit
            })
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondary, lineWidth: 1)
                .frame(height: textFieldHeight))
            .foregroundColor(Color(.label))
            .accentColor(Color.secondary)
            .animation(.linear)
            HStack {
                Text(placeHolderText)
                Text(test)
            }
            .foregroundColor(Color(.secondaryLabel))
            .background(bgColor)
            .padding(shouldPlaceHolderMove ?
                     EdgeInsets(top: 0, leading: 15, bottom: textFieldHeight + 20, trailing: 0) :
                        EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
            .scaleEffect(shouldPlaceHolderMove ? 1.0 : 1.2)
            .animation(.linear)

        }
    }
}

#if DEBUG
struct FloatingTextField_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTextField(
            placeHolder: "Preview",
            placeHolderSuffix: "secs",
            text: .constant(""),
            bgColor: Color(.systemBackground))
    }
}
#endif
