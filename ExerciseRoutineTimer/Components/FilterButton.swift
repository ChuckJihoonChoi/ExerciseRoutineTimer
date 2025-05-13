//
//  FilterButton.swift
//  ExerciseRoutineTimer
//
//  Created by Thuy Minh Luu on 7/5/2025.
//

import SwiftUI
import SwiftData

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

