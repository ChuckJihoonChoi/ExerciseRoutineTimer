//
//  Module.swift
//  FlexPlanDraft
//
//  Created by JH's macbook on 5/2/25.
//
import Foundation
import SwiftData

@Model
class Module {
    var id: UUID
    var name: String
    var sets: Int
    var weight: Int
    var workSeconds: Int
    var restSeconds: Int
    var note: String
    var createdAt: Date

    init(id: UUID = UUID(), name: String, sets: Int, weight: Int,
         workSeconds: Int, restSeconds: Int, note: String = "", createdAt: Date = .now) {
        self.id = id
        self.name = name
        self.sets = sets
        self.weight = weight
        self.workSeconds = workSeconds
        self.restSeconds = restSeconds
        self.note = note
        self.createdAt = createdAt
    }
}



