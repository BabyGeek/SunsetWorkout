//
//  BackgroundView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/10/2022.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size

            Color.red
                .opacity(0.25)
                .ignoresSafeArea()

            Circle()
                .fill(Color.purple)
                .padding(50)
                .blur(radius: 120)
                .offset(x: -size.width / 1.8, y: -size.height / 5)

            Circle()
                .fill(Color.purple)
                .padding(100)
                .blur(radius: 30)
                .offset(x: size.width / 1.8, y: -size.height / 40)

            Circle()
                .fill(Color.blue)
                .frame(width: 80, height: 80)
                .padding(50)
                .blur(radius: 8)
                .offset(x: size.width / 8, y: -size.height / 5)

            Circle()
                .fill(Color.purple)
                .frame(width: 80, height: 80)
                .padding(70)
                .blur(radius: 8)
                .offset(x: size.width / 2, y: size.height / 1.1)

            Circle()
                .fill(Color.purple)
                .padding(100)
                .blur(radius: 30)
                .offset(x: -size.width / 1.8, y: size.height / 2)

            Circle()
                .fill(Color.blue)
                .padding(50)
                .blur(radius: 150)
                .offset(x: size.width / 1.8, y: -size.height / 2)

            Circle()
                .fill(Color.blue)
                .padding(50)
                .blur(radius: 90)
                .offset(x: size.width / 1.8, y: size.height / 2)

            Circle()
                .fill(Color.purple)
                .padding(100)
                .blur(radius: 110)
                .offset(x: size.width / 1.8, y: size.height / 2)

            Circle()
                .fill(Color.purple)
                .padding(100)
                .blur(radius: 110)
                .offset(x: -size.width / 1.8, y: size.height / 2)
        }
        .ignoresSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
