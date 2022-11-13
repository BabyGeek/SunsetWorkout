//
//  CustomBlurView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/10/2022.
//

import SwiftUI

struct CustomBlurView: UIViewRepresentable {
    var effect: UIBlurEffect.Style
    var onChange: (UIVisualEffectView) -> Void

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            onChange(uiView)
        }
    }
}

struct CustomBlurView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBlurView(effect: .systemUltraThinMaterial, onChange: { _ in })
    }
}
