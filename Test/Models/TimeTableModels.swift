//
//  TimeTableModels.swift
//  Test
//
//  Created by Denis on 07.10.2022.
//

import Foundation

enum WeekType{
    case red
    case blue
    case both
}
// Добавить типы занятия: лекции, практики, и тд
struct Lesson {
    var title: String
    var time: String
    var teacher: String?
    var groups: [String]
    var building: String
    var room: String
    var weekType: WeekType
}

struct Day {
    var lessons: [Lesson] = []
}

struct Week {
    var days: [Day] = []
}
