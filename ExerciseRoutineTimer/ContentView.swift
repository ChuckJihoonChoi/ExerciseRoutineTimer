//
//  ContentView.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/3/25.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {

            WorkoutView()
                .tabItem {
                    Label("Workout", systemImage: "figure.strengthtraining.traditional")
                }

            RoutineView()
                .tabItem {
                    Label("Routine", systemImage: "list.bullet")
                }

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
        }
    }
}
#Preview {
    ContentView()
}
