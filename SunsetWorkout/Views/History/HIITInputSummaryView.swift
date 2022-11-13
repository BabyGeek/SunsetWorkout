//
//  HIITInputSummaryView.swift
//  SunsetWorkout
//
//  Created by Paul Oggero on 12/11/2022.
//

import SwiftUI

struct HIITInputSummaryView: View {
    let inputs: [ActivityHIITInput]
    let exerciseName: String
    @State var selectedInput: ActivityHIITInput
    @State var selectInputIndex: Int = 0

    var body: some View {
        VStack {
            Text(exerciseName)

            TabView(selection: $selectedInput) {
                ForEach(inputs) { input in
                    HIITInputRowView(input: input)
                        .tag(input)
                }
            }
            .animation(.easeInOut)
            .transition(.slide)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .frame(height: 200)
        .onAppear {
            if let first = inputs.first {
                selectedInput = first
            }
        }
        .onChange(of: selectedInput) { _ in
            if let index = inputs.firstIndex(of: selectedInput) {
                selectInputIndex = index
            }
        }
        .overlay(
            Button(action: {
                selectedInput = inputs[inputs.index(after: selectInputIndex)]
            }, label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(.label))
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray)
                            .frame(width: 25, height: 20))
            })
            .padding(.leading)
            .opacity(inputs.index(after: selectInputIndex) < inputs.count ? 1 : 0)
            .buttonStyle(PlainButtonStyle()),
            alignment: .trailing
        )
        .overlay(
            Button(action: {
                selectedInput = inputs[inputs.index(before: selectInputIndex)]
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(.label))
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray)
                            .frame(width: 25, height: 20))
            })
            .padding(.trailing)
            .opacity(inputs.index(before: selectInputIndex) >= 0 ? 1 : 0)
            .buttonStyle(PlainButtonStyle()),
            alignment: .leading
        )
        .padding(.horizontal)
    }
}

struct HIITInputSummaryView_Previews: PreviewProvider {
    static let HIITInputs = [
        ActivityHIITInput(round: 1, timePassed: 30, skipped: false),
        ActivityHIITInput(round: 2, timePassed: 30, skipped: false),
        ActivityHIITInput(round: 3, timePassed: 30, skipped: false),
        ActivityHIITInput(round: 4, timePassed: 30, skipped: false),
        ActivityHIITInput(round: 5, timePassed: 25, skipped: true)
    ]

    static var previews: some View {
        HIITInputSummaryView(inputs: HIITInputs, exerciseName: "Preview HIIT", selectedInput: HIITInputs.first!)
    }
}
