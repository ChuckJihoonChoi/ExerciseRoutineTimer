//
//  ModuleItemView.swift
//  ExerciseRoutineTimer
//
//  Created by Nguyet Nga Nguyen on 5/2/25.
//
import SwiftUI
import SwiftData

struct ModuleItemView: View {
    @Bindable var module: Module
    var onDelete: (() -> Void)? = nil
    var canEdit: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title + Delete
            HStack {
                Text(module.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                if let onDelete = onDelete, canEdit {
                    Button(role: .destructive) {
                        onDelete()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .frame(width: 30, height: 30)
                            .background(Color(.systemGray5))
                            .clipShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }

            // Sets & Workout Time & Weight & Rest Time
            HStack(spacing: 16) {
                verticalNumberField(title: "Sets", value: $module.sets)
                verticalNumberField(title: "Repititions", value: $module.repititions)
                verticalNumberField(title: "Weight", value: $module.weight, suffix: "kg")
            }
            HStack(spacing: 16) {
                verticalNumberField(title: "Workout Time", value: $module.workSeconds, suffix: "s")
                verticalNumberField(title: "Rest Time", value: $module.restSeconds, suffix: "s")
            }

            // Note
            HStack(spacing: 12) {
                Image(systemName: "text.page")
                    .foregroundColor(.blue)
                    .frame(width: 30, height: 30)
                    .background(Color(.systemGray5))
                    .clipShape(Rectangle())

                if canEdit {
                    TextField("Note", text: $module.note)
                        .textFieldStyle(.roundedBorder)
                        .font(.body)
                } else {
                    Text(module.note)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 10)
    }

    @ViewBuilder
    private func verticalNumberField(
        title: String,
        value: Binding<Int>,
        suffix: String = ""
    ) -> some View {
        if canEdit {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                HStack(spacing: 4) {
                    TextField(title, value: value, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .frame(width: 45)
                        .textFieldStyle(.roundedBorder)
                    if !suffix.isEmpty {
                        Text(suffix)
                            .foregroundColor(.gray)
                    }
                }
            }
        } else {
            Label("\(title): \(value.wrappedValue)\(suffix)", systemImage: "circle.fill")
                .font(.subheadline)
        }
    }
}




