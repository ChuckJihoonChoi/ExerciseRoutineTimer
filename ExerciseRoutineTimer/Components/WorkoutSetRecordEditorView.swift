//
//  WorkoutSetRecordEditorView.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/7/25.
//
import SwiftUI
import SwiftData

struct WorkoutSetRecordEditorView: View {
    @Bindable var record: WorkoutSetRecord
    let editMode: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Set \(record.setIndex + 1)")
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack(spacing: 12) {
                VStack(alignment: .leading) {
                    Text("Reps")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("0", value: $record.executedReps, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .frame(width: 50)
                        .textFieldStyle(.roundedBorder)
                        .disabled(!editMode)
                }

                VStack(alignment: .leading) {
                    Text("Weight (kg)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("0", value: $record.executedWeight, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .frame(width: 60)
                        .textFieldStyle(.roundedBorder)
                        .disabled(!editMode)
                }
                Spacer(minLength: 8)
            }
            .opacity(editMode ? 1 : 0.6)

            Text("Duration: \(record.executedWorkSeconds)s work + \(record.executedRestSeconds)s rest")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color(.systemGray6)))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        .padding(.horizontal, 0)
    }

}

