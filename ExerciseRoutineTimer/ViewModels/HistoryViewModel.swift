//
//  HistoryViewModel.swift
//  test2
//
//  Created by Thuy Minh Luu on 7/5/2025.
//

import Foundation
import SwiftData
import Combine
import SwiftUI

class HistoryViewModel: ObservableObject {
    @Published var workoutSessions: [WorkoutSession] = []
   
    @Published var selectedRoutineFilter: String? = nil
    
    var availableRoutine: [String] {
        Set(workoutSessions.map { $0.routineType}).sorted()
    }
    
    private let maxSessions = 7

    init() {
        loadWorkoutData()
        
        if let mostRecentSession = workoutSessions.sorted(by:{ $0.date > $1.date }).first {
            selectedRoutineFilter = mostRecentSession.routineType
        } else {
            selectedRoutineFilter = nil
        }
    }
    
    func loadWorkoutData() {
        self.workoutSessions = WorkoutSession.sampleData()
//        updateSessionNumbers()
    }
    
    var filteredWorkouts: [WorkoutSession] {
        if let filter = selectedRoutineFilter {
            return workoutSessions.filter{ $0.routineType == filter }
        } else {
            return workoutSessions
        }
    }
    
    func getFilteredWorkouts() -> [WorkoutSession] {
        let recent = filteredWorkouts.suffix(7)
        return Array(recent.reversed())
    }
    
    func selectRoutineFilter(_ routineType: String) {
        selectedRoutineFilter = routineType
    }
    
    func addWorkoutSession(_ session: WorkoutSession) {
        workoutSessions.append(session)
        
        if workoutSessions.count > maxSessions {
            workoutSessions.removeFirst()
        }
        
//        updateSessionNumbers()
    }
    
//    private func updateSessionNumbers() {
//        let sortedSessions = workoutSessions.sorted(by: {$0.date < $1.date })
//
//        for i in 0..<sortedSessions.count {
//            workoutSessions[i].sessionNumber = i + 1
//        }
//    }
    
    func getRecentWorkouts () -> [WorkoutSession] {
        let recent = filteredWorkouts.suffix(7)
        let sorted = Array(recent.sorted(by: {$0.date < $1.date }))
        for (index, var session) in sorted.enumerated() {
            session.sessionNumber = index + 1
        }
        return sorted.reversed()
    }
    
    var averageWorkoutDuration: Double {
        let workoutSessions = getFilteredWorkouts()
        guard !workoutSessions.isEmpty else { return 0 }
        let total = workoutSessions.reduce(0) { $0 + $1.totalSeconds }
        return total / Double(workoutSessions.count)
    }
    
    var totalWorkoutTime: Double {
        let workoutSessions = getFilteredWorkouts()
        return workoutSessions.reduce(0) { $0 + $1.totalSeconds }
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
}
