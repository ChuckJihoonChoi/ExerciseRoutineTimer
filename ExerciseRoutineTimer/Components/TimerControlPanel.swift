//
//  TimerControlPanel.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/2/25.
//
import SwiftUI

struct TimerControlPanel: View {
    @ObservedObject var viewModel: WorkoutViewModel
    var restBetweenModules: Int
    
    var progress: Double {
        guard let module = viewModel.currentModule else { return 0.0 }
        let total: Int
        if viewModel.isRestPhase {
            total = viewModel.isRestBetweenMod ? restBetweenModules : module.restSeconds
        } else {
            total = module.workSeconds
        }
        
        return total > 0 ? 1.0 - Double(viewModel.remainingTime) / Double(total) : 0.0
    }

    var body: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 20)

            // Process Circle (reverse to clock orientation, start from 12)
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(viewModel.isRestPhase ? Color.blue : Color.green,
                        style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)

            // Remaining time
            VStack {
                Text(viewModel.isRestPhase ? "Resting" : "Working")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("\(viewModel.remainingTime)s")
                    .font(.largeTitle.bold())
            }
        }
        .frame(width: 220, height: 220)
    }
}
