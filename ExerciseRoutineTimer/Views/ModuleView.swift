//  ModuleView.swift
//  FlexPlanDraft
//
//  Created by Nguyet Nga Nguyen on 5/2/25.
//

import SwiftUI
import SwiftData

struct ModuleView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var routine: Routine

    @State private var showingAddAlert = false
    @State private var newModuleName = ""
    @State private var forceRefresh = false
    @State private var showingDeleteAlert = false
    @State private var navigateToWorkout = false

    @State private var moduleViewModel: ModuleViewModel
    @State private var routineViewModel: RoutineViewModel

    init(routine: Routine, modelContext: ModelContext) {
        self._moduleViewModel = State(wrappedValue: ModuleViewModel(modelContext: modelContext))
        self._routineViewModel = State(wrappedValue: RoutineViewModel(modelContext: modelContext))
        self.routine = routine
    }


    var sortedModules: [Module] {
        routine.modules.sorted { $0.orderIndex < $1.orderIndex }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .leading) {
                    ZStack(alignment: .topTrailing) {
                        VStack(alignment: .leading, spacing: 8) {
                            // Routine name and delete button
                            HStack {
                                Text(routine.name)
                                    .font(.title2)
                                    .bold()

                                Spacer()

                                Button(role: .destructive) {
                                    showingDeleteAlert = true
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .imageScale(.large)
                                        .background(Color(.systemGray5))
                                        .clipShape(Rectangle())
                                        .shadow(radius: 4)
                                        .padding()
                                }
                                .buttonStyle(.plain)
                            }
                            Text("Rest Time: \(routine.restBetweenModules) sec")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }
                    Divider()

                    // Start workout button
                    Button(action: {
                        navigateToWorkout = true
                    }) {
                        Text("Start Workout")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(sortedModules.isEmpty)
                    .padding(.horizontal)
                    .navigationDestination(isPresented: $navigateToWorkout) {
                        WorkoutView(routine: routine, modelContext: modelContext)
                    }

                    // Module list
                    if sortedModules.isEmpty {
                        Text("No modules added yet.")
                            .foregroundColor(.secondary)
                            .padding()
                        Spacer()
                    } else {
                        List {
                            ForEach(sortedModules) { module in
                                ModuleItemView(
                                    module: module,
                                    onDelete: {
                                        moduleViewModel.removeModule(module)
                                        if let index = routine.modules.firstIndex(where: { $0.id == module.id }) {
                                            routine.modules.remove(at: index)
                                        }
                                        forceRefresh.toggle()
                                    },
                                    canEdit: true
                                )
                            }
                        }
                        .id(forceRefresh)
                    }
                }

                // Floating add module button
                Button(action: {
                    showingAddAlert = true
                }) {
                    Image(systemName: "plus")
                        .font(.title)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                        .padding()
                }
            }
            .navigationTitle("Routine Details")
            .navigationBarTitleDisplayMode(.inline)
            .alert("New Module", isPresented: $showingAddAlert) {
                TextField("Module name", text: $newModuleName)
                Button("Add") {
                    if !newModuleName.isEmpty {
                        moduleViewModel.addModule(
                            to: routine,
                            name: newModuleName,
                            sets: 3,
                            repititions: 15,
                            weight: 0,
                            workSeconds: 30,
                            restSeconds: 15,
                            note: "-"
                        )
                        newModuleName = ""
                        forceRefresh.toggle()
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Enter the name for your module.")
            }
            .alert("Delete Routine", isPresented: $showingDeleteAlert) {
                Button("Delete", role: .destructive) {
                    routineViewModel.deleteRoutine(routine)
                    dismiss()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to delete this routine? This action cannot be undone.")
            }
        }
    }
}
