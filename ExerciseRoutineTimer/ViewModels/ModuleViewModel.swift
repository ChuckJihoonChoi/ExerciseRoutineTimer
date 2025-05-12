//
//  ModuleViewModel.swift
//  FlexPlanDraft
//
//  Created by Nguyet Nga Nguyen on 5/2/25.
//
import Foundation
import SwiftData

@Observable
class ModuleViewModel: ObservableObject {
    var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func addModule(to routine: Routine, name: String, sets: Int, repititions: Int, weight: Int, workSeconds: Int, restSeconds: Int, note: String = "") {
        let module = Module(
            name: name,
            sets: sets,
            repititions: repititions,
            weight: weight,
            workSeconds: workSeconds,
            restSeconds: restSeconds,
            note: note,
            createdAt: .now,
            orderIndex: routine.modules.count,
            routine: routine
        )
        modelContext.insert(module)
    }

    func removeModule(_ module: Module) {
        modelContext.delete(module)
    }
    
    func updateModule(_ module: Module, name: String, sets: Int, repititions: Int, weight: Int, work: Int, rest: Int, note: String) {
        module.name = name
        module.sets = sets
        module.repititions = repititions
        module.weight = weight
        module.workSeconds = work
        module.restSeconds = rest
        module.note = note
        try? modelContext.save()
    }

}
