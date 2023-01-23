//
//  FirebaseAPI.swift
//  GuapTimeTable
//
//  Created by Denis on 14.01.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
protocol FirebaseAPIProtocol {
    func getTimeTableFromFirebase(_ group: String?, completionHandler: @escaping (Week) -> Void)
}

class FirebaseApi: FirebaseAPIProtocol {
    let database = Firestore.firestore()
    static let shared = FirebaseApi()
    private let weekDayNumbers = [
        "Понедельник": 0,
        "Вторник": 1,
        "Среда": 2,
        "Четверг": 3,
        "Пятница": 4,
        "Суббота": 5,
        "Воскресенье": 6
    ]

    private func convertDocumentToWeekFormat(queryDocuments: [FirestoreLesson]) -> Week {
        var lessons: [Lesson] = []
        var days: Set<String> = []
        var dayStorage: [Day] = []

        for queryDocument in queryDocuments {
            var weekType: WeekType = .both
            if let temp = try? WeekType.stringToWeekType(text: queryDocument.weekType) {weekType = temp}
            days.insert(queryDocument.weekDay) // добавляем в множество дни недели, чтобы по ним разбить список всех занятий
            let lesson = Lesson(title: queryDocument.title, startTime: queryDocument.startTime,
                endTime: queryDocument.endTime, lessonNumber: queryDocument.lessonNumber,
                teacher: queryDocument.teacher, lessonType: queryDocument.lessonType,
                groups: queryDocument.groups, building: queryDocument.building, room: queryDocument.room, weekType: weekType, weekDay: queryDocument.weekDay)
            lessons.append(lesson)
        }
        for dayTitle in days {
            let day = Day(dayTitle: dayTitle, lessons: lessons.filter { $0.weekDay == dayTitle })
            dayStorage.append(day)
        }
        dayStorage.sort(by: { (weekDayNumbers[$0.dayTitle] ?? 7) < (weekDayNumbers[$1.dayTitle] ?? 7) })
        return Week(days: dayStorage, currentWeekType: .both)
    }

    public func getTimeTableFromFirebase(_ group: String?, completionHandler: @escaping (Week) -> Void) {
        // TODO: убрать привязку к тестовой группе, добавить возможность выбирать расписание для группы
        let docRef = self.database.collection("/groups/4230M/Lessons")
        var lessonsDocs: [FirestoreLesson] = []
        docRef.getDocuments { snapshot, error in
            guard let data = snapshot?.documents, error == nil else {
                // TODO: перенести обработку ошибок в UI слой
                print(error!.localizedDescription)
                return
            }
            for document in data {
                do {
                    let doc = try document.data(as: FirestoreLesson.self)
                    lessonsDocs.append(doc)
                } catch {
                    print(error.localizedDescription)
                }
            }

            let week = self.convertDocumentToWeekFormat(queryDocuments: lessonsDocs)
            completionHandler(week)
        }
    }

    public func addLessonToFireStore(lesson: Lesson) {
        let doc = self.database.collection("/groups/4230M/Lessons")
        let firestoreLessonFormat = FirestoreLesson(startTime: lesson.startTime ?? "err",
            weekDay: lesson.weekDay ?? "err", title: lesson.title,
            lessonNumber: lesson.lessonNumber ?? "err", weekType: lesson.weekType.rawValue,
            endTime: lesson.endTime!, building: lesson.building, room: lesson.room ?? "err",
            teacher: lesson.teacher ?? "err", groups: lesson.groups, lessonType: lesson.lessonType)
        do {
            try doc.addDocument(from: firestoreLessonFormat)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
