//
//  WorkoutViewModel.swift
//  ExerciseRoutineTimer
//
//  Created by JH's macbook on 5/2/25.
//
//

import Foundation
import SwiftData
import Combine
import AVFoundation
import UIKit

class WorkoutViewModel: ObservableObject {

    private let synthesizer = AVSpeechSynthesizer()

    var modelContext: ModelContext
    private let recordManager: WorkoutRecordManager

    @Published var currentRoutine: Routine?
    @Published var currentModuleIndex: Int = 0
    @Published var currentSet: Int = 1
    @Published var isRestPhase: Bool = false
    @Published var isRestBetweenMod: Bool = false
    
    @Published var remainingTime: Int = 0
    @Published var totalElapsedTime: Int = 0
    @Published var showHistory: Bool = false
    @Published var showRecord: Bool = false

    private var timer: Timer?
    private var elapsedTimer: Timer?
    private var phaseStartTime: Date? // Start Timer for tracking time
    @Published var isWorkoutCompleted: Bool = false
    @Published var currentPhaseDuration: Int = 0

    var routineHistory: RoutineHistory? {
        recordManager.currentRoutineHistory
    }

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.recordManager = WorkoutRecordManager(modelContext: modelContext)
    }

    var currentModule: Module? {
        guard let routine = currentRoutine else { return nil }
        let sorted = routine.modules.sorted(by: { $0.orderIndex < $1.orderIndex })
        return sorted.indices.contains(currentModuleIndex) ? sorted[currentModuleIndex] : nil
    }

    var totalElapsedTimeString: String {
        let minutes = totalElapsedTime / 60
        let seconds = totalElapsedTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func startWorkout(with routine: Routine) {
        currentRoutine = routine
        currentModuleIndex = 0
        currentSet = 1
        isRestPhase = false
        isRestBetweenMod = false
        totalElapsedTime = 0
        
        recordManager.createRoutineHistory(for: routine)
        
        startElapsedTimer()
        startCurrentModule()
    }

    private func startElapsedTimer() {
        elapsedTimer?.invalidate()
        elapsedTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.totalElapsedTime += 1
        }
    }

    private func startCurrentModule() {
        guard let module = currentModule else {
            finishWorkout()
            return
        }
        speak("\(module.name) Set \(currentSet) Start")
        
        remainingTime = module.workSeconds
        currentPhaseDuration = module.workSeconds
        isRestPhase = false
        isRestBetweenMod = false
        phaseStartTime = Date() // Record start time
        startTimer()
    }

    private func startRestPhase(for duration: Int) {
        remainingTime = duration
        currentPhaseDuration = duration
        isRestPhase = true
        phaseStartTime = Date() // Record start time
        startTimer()
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.remainingTime -= 1
            if self.remainingTime <= 0 {
                if self.currentRoutine?.vibrationEnabled == true {
                    self.vibrate()
                }
                self.advancePhase()
            }
        }
    }
    // Phase change - Each set of (Workout / Rest) & Rest Between two module
    private func advancePhase() {
        timer?.invalidate()
        
        // Actual elapsed time save
         let elapsed = Int(Date().timeIntervalSince(phaseStartTime ?? Date()))
         if isRestPhase {
             saveRestRecord(seconds: elapsed)
         } else {
             saveSetRecord(seconds: elapsed)
         }
        
        if isRestPhase {
            // isRestPhase = change to next set of workout
            currentSet += 1
            if let module = currentModule, currentSet <= module.sets {
                remainingTime = module.workSeconds
                isRestPhase = false
                isRestBetweenMod = false
                phaseStartTime = Date() // start new work phase
                startTimer()
                
                speak("\(module.name) Set \(currentSet) Start")
                
            } else {
                moveToNextModuleIfNeeded()
            }
        } else {    // !isRestPhase = change to rest or finish module
            if let module = currentModule {
                if currentSet < module.sets {
                    startRestPhase(for: module.restSeconds)
                } else {
                    if let routine = currentRoutine {
                        // Check if it s the last Module
                        let sorted = routine.modules.sorted(by: { $0.orderIndex < $1.orderIndex })
                        if currentModuleIndex == sorted.count - 1 {
                            moveToNextModuleIfNeeded() // Last module : Exit
                        } else {
                            currentPhaseDuration = module.restSeconds
                            isRestBetweenMod = true
                            startRestPhase(for: routine.restBetweenModules)
                        }
                    } else {
                        finishWorkout()
                    }
                }
            }
        }
    }

    private func moveToNextModuleIfNeeded() {
        currentModuleIndex += 1
        currentSet = 1

        guard let routine = currentRoutine else {
            finishWorkout()
            return
        }

        let sorted = routine.modules.sorted(by: { $0.orderIndex < $1.orderIndex })
        if currentModuleIndex < sorted.count {
            isRestPhase = false
            isRestBetweenMod = false
            startCurrentModule()
        } else {
            finishWorkout()
        }
    }
    // Skip action(if user wants to skip)
    func skipCurrentPhase() {
        for voice in AVSpeechSynthesisVoice.speechVoices() {
            print("🗣️ Available: \(voice.name) - \(voice.language)")
        }
        timer?.invalidate()
        let elapsed = Int(Date().timeIntervalSince(phaseStartTime ?? Date()))
        if isRestPhase {
            saveRestRecord(seconds: elapsed)
        } else {
            saveSetRecord(seconds: elapsed)
        }
        advancePhase()
    }

    // Set record save : only save workout time
    private func saveSetRecord(seconds: Int) {
        if let module = currentModule {
            recordManager.addWorkSet(to: module, setIndex: currentSet - 1, workSeconds: seconds) // Do -1 to currentSet
        }
    }

    // Rest record Save : update only rest time
    private func saveRestRecord(seconds: Int) {
        if let module = currentModule {
            recordManager.updateRestSeconds(for: module, setIndex: currentSet - 1, restSeconds: seconds)
        }
    }

    func finishWorkout() {
        timer?.invalidate()
        elapsedTimer?.invalidate()
        timer = nil
        elapsedTimer = nil
        // To protect to access currentModuleIndex, set the maximum value in currentModuleIndex
        currentModuleIndex = Int.max
        currentRoutine = nil
        isWorkoutCompleted = true
        
        recordManager.updateTotalSeconds(totalElapsedTime)
    }
    
    // Voice
    private func speak(_ message: String) {
        // speak only when voiceEnabled of the module is true
        guard currentRoutine?.voiceEnabled == true else { return }

        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Samantha-compact")
        utterance.rate = 0.45

        synthesizer.speak(utterance)
    }
    // Vibration
    private func vibrate() {
        // vibrate only when vibrationEnabled of the module is true
        guard currentRoutine?.vibrationEnabled == true else { return }

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}


