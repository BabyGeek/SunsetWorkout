//
//  CreateFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 22/09/2022.
//

import SwiftUI
import HealthKit

enum SWWorkoutType: String {
    case highIntensityIntervalTraining = "HIIT"
    case traditionalStrengthTraining = "Strenght"

    var HKWorkoutActivityType: HKWorkoutActivityType {
        switch self {
        case .highIntensityIntervalTraining:
            return .highIntensityIntervalTraining
        case .traditionalStrengthTraining:
            return .traditionalStrengthTraining
        }
    }
}

struct SWWorkout {
    let type: SWWorkoutType
}

struct HIITFormView: View {
    @State private var name: String = ""

    var body: some View {
        FloatingTextField(placeHolder: "Round break (secs)", text: $name, bgColor: .white)

        FloatingTextField(placeHolder: "Round number", text: $name, bgColor: .white)

    }
}

struct TraditionalFormView: View {
    @State private var name: String = ""

    var body: some View {
        FloatingTextField(placeHolder: "Series break (secs)", text: $name, bgColor: .white)
        FloatingTextField(placeHolder: "Series number", text: $name, bgColor: .white)
        FloatingTextField(placeHolder: "Series repetition goal", text: $name, bgColor: .white)
    }
}

struct CreateFormView: View {
    @State private var type: SWWorkoutType = .highIntensityIntervalTraining
    @State private var name: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Picker("Type", selection: $type) {
                    Text(SWWorkoutType.highIntensityIntervalTraining.rawValue)
                        .tag(SWWorkoutType.highIntensityIntervalTraining)

                    Text(SWWorkoutType.traditionalStrengthTraining.rawValue)
                        .tag(SWWorkoutType.traditionalStrengthTraining)
                }
                .pickerStyle(.segmented)

                FloatingTextField(placeHolder: "Name", text: $name, bgColor: .white)
                FloatingTextField(placeHolder: "Exercice break (secs)", text: $name, bgColor: .white)

                if type == .highIntensityIntervalTraining {
                    HIITFormView()
                }

                if type == .traditionalStrengthTraining {
                    TraditionalFormView()
                }

                Spacer()
            }
            .navigationTitle("New workout")
            .padding()
        }
    }
}

struct CreateFormView_Previews: PreviewProvider {
    static var previews: some View {
        CreateFormView()
    }
}
