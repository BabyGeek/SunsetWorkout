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
    
    @FocusState var isSearchActive: Bool

    init(_ exerciseUUID: String) {
        _viewModel = StateObject(
            wrappedValue: WorkoutExerciseViewModel(workoutUUID: exerciseUUID)
        )
    }

    var body: some View {
        VStack {
            formView
            
            Spacer()
            
            SWButton(tint: .green) {
                Text("button.save")
            } action: {
                viewModel.saveExercise()
                if viewModel.saved {
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    viewModel.error = SWError(error: SWExerciseError.notSaved)
                    
                }
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
        }
    }
}

// MARK: - Form view
extension WorkoutExerciseFormView {
    var formView: some View {
        Form {
            FloatingTextField<EmptyView>(
                placeHolder: "exercise.name",
                text: $viewModel.name,
                bgColor: .clear)
            .focused($isSearchActive)
            .simultaneousGesture(
                TapGesture()
                    .onEnded({ _ in
                        isSearching = true
                    })
            )
            
            FloatingTextField<EmptyView>(
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
        }
        .clearListBackground()
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
        WorkoutExerciseFormView(HIITExample.id)
    }
}
#endif
