//
//  ToasterView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 14/11/2022.
//

import SwiftUI

enum ToasterType {
    case error, success, warning, info
    
    var iconName: String {
        switch self {
        case .error:
            return "xmark.circle.fill"
        case .success:
            return "checkmark.circle.fill"
        case .warning:
            return "exclamationmark.triangle.fill"
        case .info:
            return "info.circle.fill"
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .error:
            return .red
        case .success:
            return .green
        case .warning:
            return .yellow
        case .info:
            return .blue
        }
    }
}

enum ToasterPosition {
    case top, bottom
    
    var edgeMoving: Edge {
        switch self {
        case .top:
            return .top
        case .bottom:
            return .bottom
        }
    }
}

struct TestToastItem: Identifiable {
    let id = UUID()
}

struct ToasterTestView: View {
    @State var isPresented: Bool = false
    @State var item: SWError?
    
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                isPresented = true
                item = SWError(error: RealmError.failure)
            }
            .toastWithError($item)
    }
}

#if DEBUG
struct ToasterView_Previews: PreviewProvider {
    static var previews: some View {
        ToasterTestView()
    }
}
#endif

struct ToasterView: View {
    let type: ToasterType
    let position: ToasterPosition
    let title: String
    let text: String
    
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
        .animation(.easeInOut(duration: 1))
        .transition(.move(edge: position.edgeMoving))
    }
}
