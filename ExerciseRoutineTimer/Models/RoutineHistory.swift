//
//  RoutineHistory.swift
//
//  Created by Thuy Minh Luu on 7/5/2025.
//

import Foundation

struct WorkoutSession: Identifiable {
    let id = UUID()
    let date: Date
    let totalSeconds: Double
    let routineType: String
    
    var workoutSessions: [WorkoutSession] = []
    
    
    var sessionNumber: Int = 0
    
    var durationInMinutes: Double {
        return totalSeconds / 60.0
    }
    
    var formattedDuration: String {
        let hours = Int(totalSeconds) / 3600
        let minutes = (Int(totalSeconds) % 3600) / 60
        let seconds = Int(totalSeconds) % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
}

extension WorkoutSession {
    static func sampleData() -> [WorkoutSession] {
        var samples = [
            WorkoutSession(date: Date().addingTimeInterval(-24 * 24 * 3600), totalSeconds: 1800, routineType: "Leg Day"),
            WorkoutSession(date: Date().addingTimeInterval(-23 * 24 * 3600), totalSeconds: 1800, routineType: "Leg Day"),
            WorkoutSession(date: Date().addingTimeInterval(-22 * 24 * 3600), totalSeconds: 1800, routineType: "Leg Day"),
            WorkoutSession(date: Date().addingTimeInterval(-21 * 24 * 3600), totalSeconds: 2100, routineType: "Arm Day"),
            WorkoutSession(date: Date().addingTimeInterval(-20 * 24 * 3600), totalSeconds: 1500, routineType: "Full Body"),
            WorkoutSession(date: Date().addingTimeInterval(-19 * 24 * 3600), totalSeconds: 2400, routineType: "Cardio"),
            WorkoutSession(date: Date().addingTimeInterval(-18 * 24 * 3600), totalSeconds: 3000, routineType: "Chest Day"),
            WorkoutSession(date: Date().addingTimeInterval(-17 * 24 * 3600), totalSeconds: 1950, routineType: "Arm Day"),
            WorkoutSession(date: Date().addingTimeInterval(-16 * 24 * 3600), totalSeconds: 1800, routineType: "Leg Day"),
            WorkoutSession(date: Date().addingTimeInterval(-15 * 24 * 3600), totalSeconds: 1800, routineType: "Leg Day"),
            WorkoutSession(date: Date().addingTimeInterval(-14 * 24 * 3600), totalSeconds: 1800, routineType: "Leg Day"),
            WorkoutSession(date: Date().addingTimeInterval(-13 * 24 * 3600), totalSeconds: 2100, routineType: "Arm Day"),
            WorkoutSession(date: Date().addingTimeInterval(-12 * 24 * 3600), totalSeconds: 1500, routineType: "Full Body"),
            WorkoutSession(date: Date().addingTimeInterval(-11 * 24 * 3600), totalSeconds: 2400, routineType: "Cardio"),
            WorkoutSession(date: Date().addingTimeInterval(-10 * 24 * 3600), totalSeconds: 3000, routineType: "Chest Day"),
            WorkoutSession(date: Date().addingTimeInterval(-9 * 24 * 3600), totalSeconds: 1950, routineType: "Arm Day"),
            WorkoutSession(date: Date().addingTimeInterval(-8 * 24 * 3600), totalSeconds: 1800, routineType: "Leg Day"),
            WorkoutSession(date: Date().addingTimeInterval(-7 * 24 * 3600), totalSeconds: 1800, routineType: "Leg Day"),
            WorkoutSession(date: Date().addingTimeInterval(-6 * 24 * 3600), totalSeconds: 1800, routineType: "Leg Day"),
            WorkoutSession(date: Date().addingTimeInterval(-5 * 24 * 3600), totalSeconds: 2100, routineType: "Arm Day"),
            WorkoutSession(date: Date().addingTimeInterval(-4 * 24 * 3600), totalSeconds: 1500, routineType: "Full Body"),
            WorkoutSession(date: Date().addingTimeInterval(-3 * 24 * 3600), totalSeconds: 2400, routineType: "Cardio"),
            WorkoutSession(date: Date().addingTimeInterval(-2 * 24 * 3600), totalSeconds: 3000, routineType: "Chest Day"),
            WorkoutSession(date: Date().addingTimeInterval(-1 * 24 * 3600), totalSeconds: 1950, routineType: "Arm Day"),
            WorkoutSession(date: Date(), totalSeconds: 2700, routineType: "Leg Day")

        ]
        
        for i in 0..<samples.count {
            samples[i].sessionNumber = i + 1
        }
        
        return samples
    }
}

