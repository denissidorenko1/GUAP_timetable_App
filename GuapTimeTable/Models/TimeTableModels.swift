//
//  TimeTableModels.swift
//  Test
//
//  Created by Denis on 07.10.2022.
//

import Foundation

enum WeekType {
    case red
    case blue
    case both
}
// Добавить типы занятия: лекции, практики, и тд
struct Lesson {
    let title: String // название пары
    let startTime: String? // время начала пары
    let endTime: String? // время окончания пары
    let lessonNumber: String? // Порядковый номер пары
    let teacher: String? // бывают пары без преподов
    let lessonType: String
    let groups: [String]
    let building: String
    let room: String?
    let weekType: WeekType
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
