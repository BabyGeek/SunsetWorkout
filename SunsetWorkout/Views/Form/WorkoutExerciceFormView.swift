//
//  WorkoutExerciceFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/10/2022.
//

import SwiftUI

struct WorkoutExerciceFormView: View, KeyboardReadable {
    var workout: SWWorkout

    @State var searchExerciceText: String = ""
    @State var isSearching: Bool = false
    @State var selectedSearch: ExerciseSearch?

    @State private var exerciseBreak: String

    @State var roundBreak: String
    @State var roundNumber: String

    @State var seriesBreak: String
    @State var seriesNumber: String
    @State var repetitionGoal: String

    @State var isKeyboardVisible: Bool = false

    init(_ workout: SWWorkout) {
        self.workout = workout

        _exerciseBreak = State(
            initialValue: workout.metadata.first(where: { $0.type == .exerciseBreak })?.value ?? "")
        _roundBreak = State(
            initialValue: workout.metadata.first(where: { $0.type == .roundBreak })?.value ?? "")
        _roundNumber = State(
            initialValue: workout.metadata.first(where: { $0.type == .roundNumber })?.value ?? "")
        _seriesBreak = State(
            initialValue: workout.metadata.first(where: { $0.type == .serieBreak })?.value ?? "")
        _seriesNumber = State(
            initialValue: workout.metadata.first(where: { $0.type == .serieNumber })?.value ?? "")
        _repetitionGoal = State(
            initialValue: workout.metadata.first(where: { $0.type == .repetitionGoal })?.value ?? "")
    }

    var body: some View {
        VStack {
            FloatingTextField(
                placeHolder: "Name",
                text: $searchExerciceText,
                bgColor: .clear)
            .simultaneousGesture(
                TapGesture()
                    .onEnded({ _ in
                        isSearching = true
                    })
            )

            if !isSearching {
                formView
            } else {
                WorkoutExerciceSearchView(
                    search: $searchExerciceText,
                    selected: $selectedSearch,
                    isSearching: $isSearching)
                Spacer()
            }
        }
        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
            isKeyboardVisible = newIsKeyboardVisible
        }
        .onChange(of: selectedSearch) { _ in
            isSearching = false
        }
    }
}

// MARK: - Form view
extension WorkoutExerciceFormView {
    var formView: some View {
        VStack {
            FloatingTextField(
                placeHolder: "Exercice break",
                text: $exerciseBreak,
                bgColor: .clear)
            .keyboardType(.numberPad)

            if workout.type == .highIntensityIntervalTraining {
                HIITFormView(
                    roundBreak: $roundBreak,
                    roundNumber: $roundNumber)
            }

            if workout.type == .traditionalStrengthTraining {
                TraditionalFormView(
                    seriesBreak: $seriesBreak,
                    seriesNumber: $seriesNumber,
                    repetitionGoal: $repetitionGoal)
            }

            Spacer()

            if !isKeyboardVisible {
                Button {
                    dump(workout)
                } label: {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 50)
                        .overlay(
                            Text("Save")
                                .foregroundColor(Color(.label))
                        )
                }
            }
        }
    }
}

#if DEBUG
struct WorkoutExerciceFormView_Previews: PreviewProvider {
    static let HIITExample = SWWorkout(name: "Test HIIT", type: .highIntensityIntervalTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "20"),
        SWMetadata(type: .roundBreak, value: "10"),
        SWMetadata(type: .roundNumber, value: "5")
    ])

    static let StrengthExample = SWWorkout(name: "Test Strength", type: .traditionalStrengthTraining, metadata: [
        SWMetadata(type: .exerciseBreak, value: "120"),
        SWMetadata(type: .serieBreak, value: "60"),
        SWMetadata(type: .serieNumber, value: "6"),
        SWMetadata(type: .repetitionGoal, value: "12")
    ])

    static var previews: some View {
        WorkoutExerciceFormView(HIITExample)
    }
}
#endif
