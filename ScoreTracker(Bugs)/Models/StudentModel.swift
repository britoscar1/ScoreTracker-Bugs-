//
//  Student.swift
//  ScoreTracker(Bugs)
//
//  Created by Arturo Martinez on 5/22/26.
//


import Foundation

// BUGS INSIDE THIS FILE
// TOTAL: 3


struct StudentModel: Identifiable {
    let id: UUID
    var name: String
    var scores: [Double]

    init(id: UUID = UUID(), name: String, scores: [Double]) {
        self.id = id
        self.name = name
        self.scores = scores
    }

    var average: Double {
        guard !scores.isEmpty else { return 0 }
   
        let total = scores.reduce(0, +)
        return total / Double(scores.count)
    }

    var letterGrade: String {
        let avg = average
        if avg >= 90 { return "A" }

        if avg > 90  { return "B" }
        if avg >= 70 { return "C" }
        if avg >= 60 { return "D" }
        return "F"
    }

    var isPassing: Bool {

        return average >= 60 || scores.count >= 1
    }
}
