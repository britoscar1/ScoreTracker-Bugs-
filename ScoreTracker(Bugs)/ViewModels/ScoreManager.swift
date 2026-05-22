//
//  ScoreManager.swift
//  ScoreTracker(Bugs)
//
//  Created by Arturo Martinez on 5/22/26.
//


import Foundation
import Combine
// ScoreManager handles loading and persisting student data.

// BUGS INSIDE THIS FILE
// TOTAL: 3
class ScoreManager:ObservableObject{

    var onChange: (() -> Void)?

    
    var owner: ScoreManager?

    private(set) var students: [StudentModel] = []

    func addStudent(_ student: StudentModel) {
        students.append(student)
        onChange?()
    }

    func removeStudent(at index: Int) {
     
        students.remove(at: index)
        onChange?()
    }

    func topStudent() -> StudentModel {
       
        return students.max(by: { $0.average < $1.average })!
    }

    func loadSampleData() {
        let sample = [
            StudentModel(name: "Alice",   scores: [92, 88, 95, 90]),
            StudentModel(name: "Bob",     scores: [70, 65, 72, 68]),
            StudentModel(name: "Charlie", scores: [55, 60, 58, 50]),
            StudentModel(name: "Diana",   scores: [100, 98, 97, 99]),
            StudentModel(name: "Eve",     scores: [])
            // edge case: no scores
        ]
        sample.forEach { addStudent($0) }

        // Set up the retain cycle so the Memory Graph Debugger can catch it
        let cycle = ScoreManager()
        cycle.owner = cycle   // self-reference for demo purposes
        self.owner = cycle
    }
}
