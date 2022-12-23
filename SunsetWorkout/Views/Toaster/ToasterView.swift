//
//  ToasterView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 14/11/2022.
//

import SwiftUI

struct ToasterBoolTestView: View {
    @State var isPresented: Bool = false

    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                withAnimation {
                    isPresented = true
                }
            }
            .toast(isPresented: $isPresented, position: .bottom)
    }
}

struct ToasterTestView: View {
    @State var item: SWError?

    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                item = SWError(error: RealmError.failure)
            }
            .toastWithError($item, position: .bottom)
    }
}

#if DEBUG
struct ToasterView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ToasterTestView()
            ToasterBoolTestView()
        }
    }
}
#endif

struct ToasterView: View {
    let type: ToasterType
    let position: ToasterPosition
    let title: String
    let text: String
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            if position == .bottom {
                Spacer()
            }

            HStack(spacing: 12) {
                Image(systemName: type.iconName)
                    .resizable()
                    .frame(width: 24, height: 24)

                VStack(alignment: .leading) {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.bold)
                    Text(text)
                        .font(.subheadline)
                }
            }
            .foregroundColor(type.foregroundColor)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(50)
            .shadow(radius: 5)

            if position == .top {
                Spacer()
            }
        }
        .padding()
        .animation(.easeInOut(duration: 1), value: isPresented)
        .transition(.move(edge: position.edgeMoving))
    }
}
