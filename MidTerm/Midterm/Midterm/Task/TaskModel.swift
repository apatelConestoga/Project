//
//  TaskModel.swift
//  Midterm
//
//  Created by Adeesh on 2024-06-28.
//

import Foundation

enum TaskStatus: Codable {
    case pending
    case completed
    case ongoing
}

class TaskColor:Codable {
    var color: String?
    var isSeleted: Bool? = false
    
    init(color: String? = nil, isSeleted: Bool? = nil) {
        self.color = color
        self.isSeleted = isSeleted
    }
}

struct Task: Codable {
    var title: String?
    var taskDescription: String?
    var strDate: String?
    var dateValue: Date?
    var color: TaskColor?
    var image: String?
    var status: TaskStatus? = .pending
}
