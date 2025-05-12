//
//  Module.swift
//  FlexPlan
//
//  Created by Nguyet Nga Nguyen on 5/2/25.
//
import Foundation
import SwiftData

@Model
class Module {
    var id: UUID
    var name: String
    var sets: Int
    var repititions: Int
    var weight: Int
    var workSeconds: Int
    var restSeconds: Int
    var note: String
    var createdAt: Date
    var orderIndex: Int
    
    // Relation between routine and this module
    @Relationship var routine: Routine?
    
    init(id: UUID = UUID(), name: String, sets: Int, repititions: Int, weight: Int,
         workSeconds: Int, restSeconds: Int, note: String = "", createdAt: Date = .now, orderIndex: Int, routine: Routine? = nil) {
        self.id = id
        self.name = name
        self.sets = sets
        self.repititions = repititions
        self.weight = weight
        self.workSeconds = workSeconds
        self.restSeconds = restSeconds
        self.note = note
        self.createdAt = createdAt
        self.orderIndex = orderIndex
        self.routine = routine
    }
}


