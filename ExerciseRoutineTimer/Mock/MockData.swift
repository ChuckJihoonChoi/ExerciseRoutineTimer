//
//  MockData.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/3/25.
//

import Foundation

// MARK: - Module Mock Data
extension Module {
    static let mock1 = Module(
        name: "Push-ups",
        sets: 3,
        weight: 0,
        workSeconds: 30,
        restSeconds: 20,
        note: "No equipment"
    )
    
    static let mock2 = Module(
        name: "Dumbbell Rows",
        sets: 4,
        weight: 15,
        workSeconds: 45,
        restSeconds: 30,
        note: "Use moderate weight"
    )
    
    static let mock3 = Module(
        name: "Plank",
        sets: 2,
        weight: 0,
        workSeconds: 60,
        restSeconds: 45,
        note: "Hold form"
    )
}

// MARK: - Routine Mock Data
extension Routine {
    static let mock1 = Routine(
        name: "Upper Body Routine",
        moduleIds: [Module.mock1.id, Module.mock2.id],
        restBetweenModules: 60,
        voiceEnabled: true,
        vibrationEnabled: true
    )

    static let mock2 = Routine(
        name: "Core Training",
        moduleIds: [Module.mock3.id],
        restBetweenModules: 30,
        voiceEnabled: false,
        vibrationEnabled: true
    )

    static let mock3 = Routine(
        name: "Full Body Blast",
        moduleIds: [Module.mock1.id, Module.mock2.id, Module.mock3.id],
        restBetweenModules: 90,
        voiceEnabled: true,
        vibrationEnabled: false
    )
}

// MARK: - RoutineHistory Mock Data
extension RoutineHistory {
    static let mock1 = RoutineHistory(
        routineId: Routine.mock1.id,
        routineName: Routine.mock1.name,
        totalSeconds: 600
    )

    static let mock2 = RoutineHistory(
        routineId: Routine.mock2.id,
        routineName: Routine.mock2.name,
        totalSeconds: 450
    )

    static let mock3 = RoutineHistory(
        routineId: Routine.mock3.id,
        routineName: Routine.mock3.name,
        totalSeconds: 900
    )
}

// MARK: - ModuleHistory Mock Data
extension ModuleHistory {
    static let mock1 = ModuleHistory(
        routineHistoryId: RoutineHistory.mock1.id,
        moduleName: Module.mock1.name,
        executedSets: 3,
        executedWeight: 0,
        executedWorkSeconds: 30,
        executedRestSeconds: 20,
        note: "Stable pace"
    )

    static let mock2 = ModuleHistory(
        routineHistoryId: RoutineHistory.mock2.id,
        moduleName: Module.mock3.name,
        executedSets: 2,
        executedWeight: 0,
        executedWorkSeconds: 60,
        executedRestSeconds: 45,
        note: "Core shaking"
    )

    static let mock3 = ModuleHistory(
        routineHistoryId: RoutineHistory.mock3.id,
        moduleName: Module.mock2.name,
        executedSets: 4,
        executedWeight: 15,
        executedWorkSeconds: 45,
        executedRestSeconds: 30,
        note: "Heavy but doable"
    )
}

