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
    // FIXME: некорректно отображаются цвета пар в кастомном расписании, изменяются после обновления.
    // Убрать дублирующиеся обработки типов недели, привести к одному стандарту
    static public func stringToWeekType(text: String) throws -> WeekType {
        switch text {
        case WeekType.blue.rawValue:
            return .blue
        case WeekType.red.rawValue:
            return .red
        case let universal where universal == WeekType.both.rawValue || universal == "Общая":
            return .both
        default:
            print("Ошибка конвертации! Текст \(text)")
            throw WeekTypeErrors.convertationError
        }
    }

}

// Добавить типы занятия: лекции, практики, и тд
struct Lesson {
    let id: String? // добавим id для обеспечения совместимости с Firebase
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

    //
    internal init(id: String?=nil, title: String, startTime: String?, endTime: String?,
                  lessonNumber: String?, teacher: String?, lessonType: String, groups: [String],
                  building: String, room: String?, weekType: WeekType, weekDay: String? = nil) {
        self.id = id
        self.title = title
        self.startTime = startTime
        self.endTime = endTime
        self.lessonNumber = lessonNumber
        self.teacher = teacher
        self.lessonType = lessonType
        self.groups = groups
        self.building = building
        self.room = room
        self.weekType = weekType
        self.weekDay = weekDay
    }
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
