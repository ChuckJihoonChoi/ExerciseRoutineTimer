//
//  HistoryViewModel.swift
//  ExerciseRoutineTimer
//
//  Created by Thuy Minh Luu on 7/5/2025.
//
import Foundation
import SwiftData
import Combine

class HistoryViewModel: ObservableObject {
    var modelContext: ModelContext

    @Published var selectedRoutineFilter: String? = nil

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        if let first = try? modelContext.fetch(FetchDescriptor<RoutineHistory>()).first {
             selectedRoutineFilter = first.routineName
         }
    }

    // List for filtered routine name
    var availableRoutine: [String] {
        do {
            let descriptor = FetchDescriptor<RoutineHistory>()
            let all = try modelContext.fetch(descriptor)
            let names = Set(all.map { $0.routineName })
            return names.sorted()
        } catch {
            print("Error fetching availableRoutine: \(error)")
            return []
        }
    }

    // Show latest 7 of routine
    func getRecentWorkouts() -> [RoutineHistory] {
        do {
            let descriptor = FetchDescriptor<RoutineHistory>(
                sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
            )
            let all = try modelContext.fetch(descriptor)
            let filtered = selectedRoutineFilter != nil
                ? all.filter { $0.routineName == selectedRoutineFilter }
                : all
            return Array(filtered.prefix(7))
        } catch {
            print("Failed to fetch histories: \(error)")
            return []
        }
    }

    var totalWorkoutTime: Double {
        getRecentWorkouts().reduce(0) { $0 + Double($1.totalSeconds) }
    }

    var averageWorkoutDuration: Double {
        let workouts = getRecentWorkouts()
        guard !workouts.isEmpty else { return 0 }
        let total = workouts.reduce(0) { $0 + Double($1.totalSeconds) }
        return total / Double(workouts.count)
    }

    func formatTotalTime(seconds: Double) -> String {
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60

        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else {
            return "\(minutes)m"
        }
    }

    // Routine Selection Filter Change
    func selectRoutineFilter(_ routineName: String?) {
        selectedRoutineFilter = routineName
    }
        
    // Refresh for updating new result
    func refresh() {
        selectedRoutineFilter = selectedRoutineFilter
    }
}
