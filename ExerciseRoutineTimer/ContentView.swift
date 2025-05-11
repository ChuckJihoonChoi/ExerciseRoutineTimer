//
//  ContentView.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/3/25.
//
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            RoutineView(modelContext: modelContext)
                .tabItem {
                    Label("Routine", systemImage: "figure.strengthtraining.traditional")
                }
                .tag(0)

            HistoryView(modelContext: modelContext, selectedTab: $selectedTab)
                .tabItem {
                    Label("History", systemImage: "clock")
                }
                .tag(1)
        }
    }

}


//#Preview {
//    ContentView()
//}
