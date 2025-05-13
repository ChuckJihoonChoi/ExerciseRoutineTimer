//
//  StatisticView.swift
//  ExerciseRoutineTimer
//
//  Created by Thuy Minh Luu on 7/5/2025.
//
import SwiftUI
import SwiftData

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
