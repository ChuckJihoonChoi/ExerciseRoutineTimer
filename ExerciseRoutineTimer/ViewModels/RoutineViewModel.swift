//
//  RoutineViewModel.swift
//  FlexPlan
//
//  Created by Nguyet Nga Nguyen on 5/2/25.
//
import Foundation
import SwiftData

@Observable
class RoutineViewModel {
    var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    func addRoutine(name: String) {
        let newRoutine = Routine(
            name: name,
            restBetweenModules: 60,
            voiceEnabled: true,
            vibrationEnabled: true,
            createdAt: .now,
            lastExecutedAt: nil
        )
        modelContext.insert(newRoutine)
    }
    
    func updateRoutine(_ routine: Routine, name: String, rest: Int, voice: Bool, vibration: Bool) {
        routine.name = name
        routine.restBetweenModules = rest
        routine.voiceEnabled = voice
        routine.vibrationEnabled = vibration
        routine.lastExecutedAt = .now
        try? modelContext.save()
    }

    func duplicateRoutine(_ routine: Routine) {
        let copiedRoutine = Routine(
            name: "\(routine.name) Copy",
            restBetweenModules: routine.restBetweenModules,
            voiceEnabled: routine.voiceEnabled,
            vibrationEnabled: routine.vibrationEnabled,
            createdAt: .now,
            lastExecutedAt: nil
        )

        for module in routine.modules {
            let copiedModule = Module(
                name: module.name,
                sets: module.sets,
                repititions: module.repititions,
                weight: module.weight,
                workSeconds: module.workSeconds,
                restSeconds: module.restSeconds,
                note: module.note,
                createdAt: .now,
                orderIndex: module.orderIndex,
                routine: copiedRoutine
            )
            modelContext.insert(copiedModule)
        }

        modelContext.insert(copiedRoutine)
    }
}





