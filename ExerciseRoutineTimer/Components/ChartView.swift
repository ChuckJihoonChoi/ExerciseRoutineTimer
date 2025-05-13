 //
//  ChartView.swift
//  FlexPlan1
//
//  Created by Thuy Minh Luu on 09/05/2025.
//
import SwiftUI
import Charts
import SwiftData

struct ChartView: View {
    let workouts: [RoutineHistory] // Get filtered Routine History List

    var body: some View {
        Chart {
            ForEach(Array(workouts.enumerated()), id: \.element.id) { index, history in
                let sessionLabel = "\(index + 1)"
                let duration = history.totalSeconds

                BarMark(
                    x: .value("Session", sessionLabel),
                    y: .value("Duration", duration)
                )
                .foregroundStyle(Color.blue.gradient)
                .cornerRadius(6)
                .annotation(position: .top) {
                    VStack(spacing: 2) {
                        Text(formatDuration(duration))
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        Text(formatDateOnly(history.createdAt))
                            .font(.caption2)
                            .foregroundColor(.gray)
                        Text(formatTimeOnly(history.createdAt))
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) {
                AxisValueLabel()
            }
        }
        .chartXAxis {
            AxisMarks {
                AxisValueLabel()
            }
        }
    }

    private func formatDuration(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    private func formatDateOnly(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    private func formatTimeOnly(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

}


