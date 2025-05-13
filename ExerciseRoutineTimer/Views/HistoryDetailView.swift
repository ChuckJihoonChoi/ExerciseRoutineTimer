//
//  HistoryDetailView.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/2/25.
//
import SwiftUI

struct HistoryDetailView: View {
    let routineHistory: RoutineHistory
    @State private var editMode: Bool = false  // Edit mode toggle

    var body: some View {
        NavigationView {
            List {
                // Routine info section
                Section(header: Text("Routine Info")) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(routineHistory.routineName)")
                            .font(.headline)
                        Text("\(routineHistory.createdAt.formatted(date: .abbreviated, time: .shortened))")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 2)
                }

                // Module records section
                Section(header:
                    HStack {
                        Text("Modules")
                        Spacer()
                        Button(editMode ? "Done" : "Edit") {
                            editMode.toggle()
                        }
                        .font(.caption)
                        .foregroundColor(.blue)
                    }
                ) {
                    ForEach(routineHistory.modules.sorted(by: { $0.orderIndex < $1.orderIndex })) { module in
                        VStack(alignment: .leading, spacing: 6) {
                            Text("\(module.moduleName)")
                                .font(.headline)

                            Text("Sets: \(module.executedSets), Reps: \(module.executedReps), Weight: \(module.executedWeight)kg")
                                .font(.subheadline)

                            Text("Work: \(module.executedWorkSeconds)s, Rest: \(module.executedRestSeconds)s")
                                .font(.subheadline)

                            if !module.note.isEmpty {
                                Text("Note: \(module.note)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }

                            // Editable set records
                            ForEach(module.setRecords.sorted(by: { $0.setIndex < $1.setIndex })) { record in
                                WorkoutSetRecordEditorView(record: record, editMode: editMode)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.vertical, 2)
                        .padding(.horizontal, 2)
                    }
                }
            }
            .navigationTitle("Workout Summary")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//
//#Preview {
//    HistoryDetailView()
//}

