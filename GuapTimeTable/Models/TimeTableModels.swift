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
    var title: String // название пары
    var startTime: String? // время начала пары
    var endTime: String? // время окончания пары
    var lessonNumber: String? // Порядковый номер пары
    var teacher: String? // бывают пары без преподов
    var lessonType: String
    var groups: [String]
    var building: String
    var room: String?
    var weekType: WeekType
}

struct Day {
    var dayTitle: String
    var lessons: [Lesson] = []
}

struct Week {
    var days: [Day] = []
    // отражает текущую неделю расписания, для навигации по расписанию
    var currentWeekType: WeekType = .both
}
