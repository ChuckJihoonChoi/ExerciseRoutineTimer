//
//  HistoryView.swift
//  ExerciseRoutineTimer
//
//  Created by Thuy Minh Luu on 7/5/2025.
//
import SwiftUI
import SwiftData

struct HistoryView: View {
    @StateObject private var viewModel: HistoryViewModel
    @Binding var selectedTab: Int   // For updating view if user access this tab
    @State private var selectedHistory: RoutineHistory? = nil   //Value to open a routine detail

    init(modelContext: ModelContext, selectedTab: Binding<Int>) {
        _viewModel = StateObject(wrappedValue: HistoryViewModel(modelContext: modelContext))
        _selectedTab = selectedTab
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Workout History")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top)

                    routineFilterView

                    HStack(spacing: 20) {
                        StatisticView(
                            title: "Total Time",
                            value: viewModel.formatTotalTime(seconds: viewModel.totalWorkoutTime)
                        )
                        StatisticView(
                            title: "Average Time",
                            value: viewModel.formatTotalTime(seconds: viewModel.averageWorkoutDuration)
                        )
                    }
                    .padding(.vertical)
                    
                    let recentWorkouts = viewModel.getRecentWorkouts()
                    ChartView(workouts: recentWorkouts)
                        .frame(height: 250)
                        .padding(.vertical)

                    // Extract the workout list as a typed constant
                    let workouts: [RoutineHistory] = viewModel.getRecentWorkouts()

                    // Call function-based view
                    workoutListView(workouts: workouts)
                        .padding(.top)
                }
                .padding()
            }
            .navigationTitle("History")
            .onChange(of: selectedTab) {
                if selectedTab == 1 {
                    viewModel.refresh()
                }
            }
            // Sheet presentation for HistoryDetailView
            .sheet(item: $selectedHistory) { history in
                HistoryDetailView(routineHistory: history)
            }
        }
    }

    private var routineFilterView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Routine")
                .font(.subheadline)
                .foregroundColor(.secondary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.availableRoutine, id: \.self) { routine in
                        FilterButton(
                            title: routine,
                            isSelected: viewModel.selectedRoutineFilter == routine,
                            color: .blue
                        ) {
                            viewModel.selectRoutineFilter(routine)
                        }
                    }
                }
            }
        }
    }

    private func workoutListView(workouts: [RoutineHistory]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Workout Sessions")
                .font(.headline)

            // Use Button to trigger sheet presentation on tap
            ForEach(Array(workouts.enumerated()), id: \.element.id) { index, history in
                Button {
                    selectedHistory = history
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(formatDate(history.createdAt))
                        }
                        Spacer()
                        Text(history.formattedDuration)
                            .font(.system(.body, design: .monospaced))
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
            }
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

//#Preview {
//    HistoryView()
//}
