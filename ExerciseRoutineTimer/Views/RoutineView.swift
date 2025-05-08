//
//  RoutineView.swift
//  FlexPlanDraft
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

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(routines.sorted(by: { $0.createdAt > $1.createdAt })) { routine in
                        NavigationLink {
                            ModuleView(routine: routine) // ✅ 실제 디테일 뷰 연결
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
        do {
            routines = try modelContext.fetch(FetchDescriptor<Routine>(sortBy: [SortDescriptor(\.createdAt)]))
        } catch {
            print("❌ Failed to fetch routines: \(error.localizedDescription)")
        }
    }

    // Add a new routine and refresh the list
    private func addRoutine() {
        guard !newRoutineName.isEmpty else { return }

        let routine = Routine(
            name: newRoutineName,
            restBetweenModules: 60,
            voiceEnabled: true,
            vibrationEnabled: true,
            createdAt: .now,
            lastExecutedAt: nil
        )
        modelContext.insert(routine)
        fetchRoutines()
        newRoutineName = ""
    }

    // Delete selected routines and refresh
    private func deleteRoutine(at offsets: IndexSet) {
        for index in offsets {
            let routine = routines[index]
            modelContext.delete(routine)
        }
        fetchRoutines()
    }
}

//#Preview {
//    RoutineView()
//}
