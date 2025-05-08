//
//  HistoryView.swift
//  ExerciseRoutineTimer
//

//
//
//  HistoryView.swift
//  test2
//
//  Created by Thuy Minh Luu on 7/5/2025.
//

import SwiftUI
import Charts

struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Workout History")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.top)
                
                Spacer()
                
//                Text("Last 7 Workout Sessions")
//                    .font(.subheadline)
//                    .foregroundColor(.secondary)
                
                VStack (alignment: .leading, spacing: 10){
                    Text ("Routine")
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
                                    viewModel.selectedRoutineFilter = routine
                                }
                            }
                        }
                    }
                }
                
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
                
                ChartView(viewModel: viewModel)
                    .frame(height: 250)
                    .padding(.vertical)
                
                workoutListView
                    .padding(.top)
                
                Spacer()
            }
            .padding()
            .navigationTitle("History")
            .onAppear {
                viewModel.loadWorkoutData()
            }
        }
    }
    
    private var workoutListView: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Workout Sessions")
                .font(.headline)
            
            ForEach(viewModel.getRecentWorkouts()) { workout in
                HStack{
                    VStack(alignment: .leading) {
//                        Text("Session \(workout.sessionNumber)")
//                            .font(.headline)
                        
                        Text("\(formatDate(workout.date))")
                    }
                    
                    Spacer()
                    
                    Text(workout.formattedDuration)
                        .font(.system(.body, design: .monospaced))
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

// Filter button component
struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(isSelected ? .bold : .regular)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? color.opacity(0.3) : Color.gray.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? color : Color.gray.opacity(0.2), lineWidth: 1)
                )
        }
        .foregroundColor(isSelected ? color : .primary)
    }}

struct ChartView: View {
    @ObservedObject var viewModel: HistoryViewModel
    
    var body: some View {
        Chart {
            ForEach(viewModel.getRecentWorkouts()) { workout in
                BarMark(
                    x: .value("Session", " \(workout.sessionNumber)"),
                    y: .value("Duration", workout.durationInMinutes)
                )
                .foregroundStyle(Color.blue.gradient)
                .cornerRadius(6)
                .annotation(position: .top) {
                    Text("\(Int(workout.durationInMinutes))m")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                AxisGridLine()
                AxisValueLabel {
                    if let minutes = value.as(Double.self) {
                        Text("\(Int(minutes)) min")
                    }
                }
            }
        }
        .chartXAxis() {
            AxisMarks {
                AxisValueLabel()
            }
        }
    }
}

struct StatisticView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    HistoryView()
}
