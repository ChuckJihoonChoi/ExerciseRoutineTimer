//
//  RoutineItemView.swift
//  FlexPlan
//
//  Created by Nguyet Nga Nguyen on 5/2/25.
//
import SwiftUI
import SwiftData

enum RoutineItemSource {
    case routineView
    case workoutView
    case historyView
}

struct RoutineItemView: View {
    @Bindable var routine: Routine
    let source: RoutineItemSource

    @State private var showingRestAlert = false
    @State private var restTimeInput = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(routine.name)
                    .font(StyleConstants.titleFont)
                Spacer()
                if let date = routine.lastExecutedAt {
                    Text(date, style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            HStack {
                Spacer()

                // Rest time text (not tappable)
                Text("Rest Time: \(routine.restBetweenModules) sec")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)

                // Clock button
                Button(action: {
                    restTimeInput = "\(routine.restBetweenModules)"
                    showingRestAlert = true
                }) {
                    Image(systemName: "clock")
                        .foregroundColor(.blue)
                        .frame(width: 30, height: 30)
                        .background(Color(.systemGray5))
                        .clipShape(Rectangle())
                }
                .buttonStyle(.plain)

                // Voice toggle
                Toggle(isOn: $routine.voiceEnabled) {
                    Image(systemName: "speaker.wave.2.fill")
                }
                .toggleStyle(.button)

                // Vibration toggle
                Toggle(isOn: $routine.vibrationEnabled) {
                    Image(systemName: "iphone.radiowaves.left.and.right")
                }
                .toggleStyle(.button)
            }
        }
        .padding(StyleConstants.cardPadding)
        .background(StyleConstants.cardBackground)
        .cornerRadius(StyleConstants.cardCornerRadius)
        .shadow(color: StyleConstants.cardShadow, radius: StyleConstants.cardShadowRadius)
        .alert("Edit Rest Time", isPresented: $showingRestAlert) {
            TextField("Seconds", text: $restTimeInput)
                .keyboardType(.numberPad)
            Button("OK") {
                if let newValue = Int(restTimeInput), newValue >= 0 {
                    routine.restBetweenModules = newValue
                }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Enter rest time between modules in seconds.")
        }
    }
}

//#Preview {
//    RoutineItemView(routine: Routine.mock1, source: .routineView)
//}


