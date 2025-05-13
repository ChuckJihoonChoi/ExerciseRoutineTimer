//
//  RoutineView.swift
//  ExerciseRoutineTimer
//
//  Created by Nguyet Nga Nguyen on 5/2/25.
//
import SwiftUI
import SwiftData

struct RoutineView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var routines: [Routine] = []
    @State private var newRoutineName = ""
    @State private var showingAddAlert = false
    @State private var selectedRoutine: Routine? = nil
    @State private var isDetailActive: Bool = false
    
    @State private var routineViewModel: RoutineViewModel
    init(modelContext: ModelContext) {
        self._routineViewModel = State(wrappedValue: RoutineViewModel(modelContext: modelContext))
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(routines.sorted(by: { $0.createdAt > $1.createdAt })) { routine in
                        NavigationLink {
                            ModuleView(routine: routine, modelContext: modelContext) // Actual Model View Connection
                        } label: {
                            RoutineItemView(routine: routine, source: .routineView)
                        }
                    }
                    .onDelete(perform: deleteRoutine)
                }

                // Floating + button to add a new routine
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
            .navigationTitle("Routines")
            .onAppear {
                fetchRoutines()
            }
            .alert("New Routine", isPresented: $showingAddAlert) {
                TextField("Routine name", text: $newRoutineName)
                Button("Add") {
                    addRoutine()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Enter the name for your routine.")
            }
        }
    }

    // Fetch all routines from SwiftData
    private func fetchRoutines() {
        routines = routineViewModel.fetchAllRoutines()
    }

    // Add a new routine using the ViewModel and refresh the list
    private func addRoutine() {
        guard !newRoutineName.isEmpty else { return }
        routineViewModel.addRoutine(name: newRoutineName)
        fetchRoutines()
        newRoutineName = ""
    }

    // Delete selected routines using the ViewModel and refresh
    private func deleteRoutine(at offsets: IndexSet) {
        for index in offsets {
            let routine = routines[index]
            routineViewModel.deleteRoutine(routine)
        }
        fetchRoutines()
    }
}

//#Preview {
//    RoutineView()
//}
