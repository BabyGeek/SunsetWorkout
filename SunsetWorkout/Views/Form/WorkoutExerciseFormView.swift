//
//  WorkoutExerciseFormView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 16/10/2022.
//

import SwiftUI

struct WorkoutExerciseFormView: View, KeyboardReadable {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: WorkoutExerciseViewModel

    @State var isSearching: Bool = false
    @State var selectedSearch: ExerciseSearch?
    @State var isKeyboardVisible: Bool = false

    init(_ exerciseUUID: String) {
        _viewModel = StateObject(
            wrappedValue: WorkoutExerciseViewModel(workoutUUID: exerciseUUID)
        )
    }

    var body: some View {
        VStack {
            FloatingTextField(
                placeHolder: "exercise.name",
                text: $viewModel.name,
                bgColor: .clear)
            .simultaneousGesture(
                TapGesture()
                    .onEnded({ _ in
                        isSearching = true
                    })
            )

            formView
        }
        .padding()
        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
            isKeyboardVisible = newIsKeyboardVisible
        }
        .onChange(of: selectedSearch) { newSelection in
            isSearching = false
            if let newSelection {
                viewModel.name = newSelection.value
            }
        }
        .sheet(isPresented: $isSearching) {
            WorkoutExerciseSearchView(
                search: $viewModel.name,
                selected: $selectedSearch,
                isSearching: $isSearching)
        }
        .toastWithError($viewModel.error)
        .onAppear {
            // viewModel.initMetadataWithValues()
        }
    }
}

// MARK: - Form view
extension WorkoutExerciseFormView {
    var formView: some View {
        VStack {
            FloatingTextField(
                placeHolder: "exercise.break",
                text: $viewModel.exerciseBreak,
                bgColor: .clear)
            .keyboardType(.numberPad)

            if viewModel.isHIITTraining {
                HIITFormView(
                    roundBreak: $viewModel.roundBreak,
                    roundDuration: $viewModel.roundDuration,
                    roundNumber: $viewModel.roundNumber)
            }

            if viewModel.isTraditionalTraining {
                TraditionalFormView(
                    seriesBreak: $viewModel.seriesBreak,
                    seriesNumber: $viewModel.seriesNumber,
                    repetitionGoal: $viewModel.repetitionGoal)
            }

            Spacer()

            if !isKeyboardVisible {
                Button {
                    viewModel.saveExercise()
                    if viewModel.saved {
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        viewModel.error = SWError(error: SWExerciseError.notSaved)
                    }

                } label: {
                    Text("button.save")
                        .foregroundColor(Color(.label))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .overlay(Capsule().stroke(Color.green))
                }
            }
        }
    }
}

#if DEBUG
struct WorkoutExerciseFormView_Previews: PreviewProvider {
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
        Text("In progress")
        WorkoutExerciseFormView(HIITExample.id)
    }
}
#endif
