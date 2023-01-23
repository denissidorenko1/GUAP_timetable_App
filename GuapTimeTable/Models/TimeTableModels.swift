//
//  TimeTableModels.swift
//  Test
//
//  Created by Denis on 07.10.2022.
//

import Foundation

enum WeekTypeErrors: Error {
    case convertationError
}
enum WeekType: String {
    case red = "Красная"
    case blue = "Синяя"
    case both = "Универсальная"

    static public func stringToWeekType(text: String) throws -> WeekType {
        switch text {
        case WeekType.blue.rawValue:
            return .blue
        case WeekType.red.rawValue:
            return .red
        case WeekType.both.rawValue:
            return .both
        default:
            print("Ошибка конвертации!")
            throw WeekTypeErrors.convertationError
        }
    }

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
    var weekDay: String? // добавлен день недели в пару чтобы сортировать ответы от firestore
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
