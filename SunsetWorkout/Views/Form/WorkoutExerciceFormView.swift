//
//  WorkoutExerciceFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/10/2022.
//

import SwiftUI

struct WorkoutExerciceFormView: View, KeyboardReadable {
    @Environment(\.presentationMode) var presentationMode
    var workoutViewModel: WorkoutViewModel

    @State var searchExerciceText: String = ""
    @State var isSearching: Bool = false
    @State var selectedSearch: ExerciseSearch?

    @State private var exerciseBreak: String

    @State var roundBreak: String
    @State var roundNumber: String
    @State var roundDuration: String

    @State var seriesBreak: String
    @State var seriesNumber: String
    @State var repetitionGoal: String

    @State var isKeyboardVisible: Bool = false

    init(_ viewModel: WorkoutViewModel) {
        self.workoutViewModel = viewModel

            _exerciseBreak = State(
                initialValue: workoutViewModel.workout?.metadata.first(where: { $0.type == .exerciseBreak })?.value ?? "")
            _roundBreak = State(
                initialValue: workoutViewModel.workout?.metadata.first(where: { $0.type == .roundBreak })?.value ?? "")
            _roundNumber = State(
                initialValue: workoutViewModel.workout?.metadata.first(where: { $0.type == .roundNumber })?.value ?? "")
            _roundDuration = State(
                initialValue: workoutViewModel.workout?.metadata.first(where: { $0.type == .roundDuration })?.value ?? "")
            _seriesBreak = State(
                initialValue: workoutViewModel.workout?.metadata.first(where: { $0.type == .serieBreak })?.value ?? "")
            _seriesNumber = State(
                initialValue: workoutViewModel.workout?.metadata.first(where: { $0.type == .serieNumber })?.value ?? "")
            _repetitionGoal = State(
                initialValue: workoutViewModel.workout?.metadata.first(where: { $0.type == .repetitionGoal })?.value ?? "")
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

            if workoutViewModel.workout?.type == .highIntensityIntervalTraining {
                HIITFormView(
                    roundBreak: $roundBreak,
                    roundDuration: $roundDuration,
                    roundNumber: $roundNumber)
            }

            if workoutViewModel.workout?.type == .traditionalStrengthTraining {
                TraditionalFormView(
                    seriesBreak: $seriesBreak,
                    seriesNumber: $seriesNumber,
                    repetitionGoal: $repetitionGoal)
            }

            Spacer()

            if !isKeyboardVisible {
                Button {
                    let metadata = [
                        SWMetadata(type: .roundDuration, value: roundDuration),
                        SWMetadata(type: .roundBreak, value: roundBreak),
                        SWMetadata(type: .roundNumber, value: roundNumber),
                        SWMetadata(type: .serieBreak, value: seriesBreak),
                        SWMetadata(type: .serieNumber, value: seriesNumber),
                        SWMetadata(type: .exerciseBreak, value: exerciseBreak),
                        SWMetadata(type: .repetitionGoal, value: repetitionGoal)
                    ]

                    if let workout = workoutViewModel.workout {
                        let exercise = SWExercise(
                            name: searchExerciceText,
                            order: workout.exercises.count + 1,
                            metadata: metadata.filter({ workout.type.SWMetadataTypes.contains($0.type) }))

                        workoutViewModel.addExercise(exercise)
                        workoutViewModel.saveWorkout()
                    }

                    if workoutViewModel.saved {
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        workoutViewModel.error = SWError(error: SWExerciseError.notSaved)
                    }

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
        WorkoutExerciceFormView(WorkoutViewModel(workout: HIITExample))
    }
}
#endif
