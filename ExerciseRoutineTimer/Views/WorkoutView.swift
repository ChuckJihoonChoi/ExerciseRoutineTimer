//
//  WorkoutView.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/2/25.
//

import SwiftUI
import SwiftData

struct WorkoutView: View {
    let routine: Routine
    @StateObject private var viewModel: WorkoutViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(routine: Routine, modelContext: ModelContext) {
        self.routine = routine
        _viewModel = StateObject(wrappedValue: WorkoutViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        
        VStack(spacing: 24) {
            // Routine Information + Total Time
            RoutineItemView(routine: routine, source: .workoutView)
                .padding(.horizontal)
            
            Text("Total Time: \(viewModel.totalElapsedTimeString)")
                .font(.headline)
            
            // Current Module Info and state
            if let currentModule = viewModel.currentModule {
                VStack(spacing: 4) {
                    Text(currentModule.name)
                        .font(.title2)
                        .bold()
                    Text("Current Set: \(viewModel.currentSet) of \(currentModule.sets)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    // Reps & Weight
                    if let module = viewModel.currentModule {
                        HStack(spacing: 12) {
                            Text("Reps: \(module.repititions)")
                            Text("Weight: \(module.weight)kg")
                        }
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    }
                    // Note
                    if let note = viewModel.currentModule?.note, !note.isEmpty {
                        Text(note)
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                }
            } else {
                Text("Workout Complete!")
                    .font(.title2)
                    .foregroundColor(.green)
            }
            
            // Circular Timer component
            TimerControlPanel(viewModel: viewModel, restBetweenModules: routine.restBetweenModules)
                .frame(height: 250)
            
            Spacer()
            // Control Buttons
            HStack(spacing: 16) {
                Button("Skip") {
                    viewModel.skipCurrentPhase()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .foregroundColor(.blue)
                .cornerRadius(12)
                
                Button("Finish") {
                    viewModel.finishWorkout()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding(.horizontal, 8)
            
            HStack(spacing: 16) {
                Button("Back") {
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.secondary.opacity(0.2))
                .foregroundColor(.gray)
                .cornerRadius(12)
                .disabled(!viewModel.isWorkoutCompleted)
                
                Button("Records") {
                    viewModel.showRecord = true
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.secondary.opacity(0.2))
                .foregroundColor(.blue)
                .cornerRadius(12)
                .disabled(!viewModel.isWorkoutCompleted)
            }
            .padding(.bottom)
            .padding(.horizontal, 8)
        }
        .onAppear {
            viewModel.startWorkout(with: routine)
        }
        .onDisappear() {
            dismiss()
        }
        .sheet(isPresented: $viewModel.showRecord) {
            if let routineHistory = viewModel.routineHistory {
                HistoryDetailView(routineHistory: routineHistory)
            } else {
                Text("No record available")
            }
        }
        .onChange(of: viewModel.isWorkoutCompleted) {
            if viewModel.isWorkoutCompleted {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    viewModel.showRecord = true
                }
            }
        }
        .navigationTitle("Workout")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        
    }
}

//#Preview {
//    WorkoutView()
//}
