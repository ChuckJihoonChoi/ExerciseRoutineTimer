//
//  ExerciseRoutineTimerApp.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/3/25.
//
import SwiftUI
import SwiftData

@main
struct ExerciseRoutineTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Routine.self, Module.self, RoutineHistory.self, ModuleHistory.self])
    }
}


