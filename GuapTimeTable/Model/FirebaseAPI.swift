//
//  FirebaseAPI.swift
//  GuapTimeTable
//
//  Created by Denis on 14.01.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol FirebaseTimetableAPIProtocol {
    func getLessons(_ group: String, completionHandler: @escaping (Week) -> Void)
    func addLesson(_ group: String, lesson: Lesson)
    func deleteLesson(_ group: String, id: String)
    func checkIfExists(group: String)
}

final class FirebaseApi: FirebaseTimetableAPIProtocol {
    let database = Firestore.firestore()
    static let shared = FirebaseApi()

    private func convertDocumentToWeekFormat(queryDocuments: [FirestoreLesson]) -> Week {
        var lessons: [Lesson] = []
        var days: Set<String> = []
        var dayStorage: [Day] = []

        let weekDayNumbers = [
            "Понедельник": 0,
            "Вторник": 1,
            "Среда": 2,
            "Четверг": 3,
            "Пятница": 4,
            "Суббота": 5,
            "Воскресенье": 6
        ]

        for queryDocument in queryDocuments {
            var weekType: WeekType = .both
            if let temp = try? WeekType.stringToWeekType(text: queryDocument.weekType) {weekType = temp}
            // добавляем в множество дни недели, чтобы по ним разбить список всех занятий
            days.insert(queryDocument.weekDay)
            let lesson = Lesson(id: queryDocument.id, title: queryDocument.title, startTime: queryDocument.startTime,
                endTime: queryDocument.endTime, lessonNumber: queryDocument.lessonNumber,
                teacher: queryDocument.teacher, lessonType: queryDocument.lessonType,
                groups: queryDocument.groups, building: queryDocument.building, room: queryDocument.room,
                weekType: weekType, weekDay: queryDocument.weekDay)
            lessons.append(lesson)
        }
        for dayTitle in days {
            let day = Day(dayTitle: dayTitle, lessons: lessons.filter { $0.weekDay == dayTitle })
            dayStorage.append(day)
        }
        // сортировка пар по дням недели
        dayStorage.sort(by: { (weekDayNumbers[$0.dayTitle] ?? 7) < (weekDayNumbers[$1.dayTitle] ?? 7) })
        return Week(days: dayStorage, currentWeekType: .both)
    }

    public func getLessons(_ group: String="4230M", completionHandler: @escaping (Week) -> Void) {
        let docRef = self.database.collection("/groups/\(group)/Lessons")
        var lessonsDocs: [FirestoreLesson] = []
        docRef.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                // TODO: перенести обработку ошибок в UI слой
                print(error!.localizedDescription)
                return
            }
            for document in documents {
                do {
                    var doc = try document.data(as: FirestoreLesson.self)
                    // FIXME: ID документа не декодируется автоматически, исправь потом
                    doc.id = document.documentID
                    lessonsDocs.append(doc)
                } catch {
                    print(error.localizedDescription)
                }
            }
            let week = self.convertDocumentToWeekFormat(queryDocuments: lessonsDocs)
            completionHandler(week)
        }
    }

    public func addLesson(_ group: String="4230M", lesson: Lesson) {
        let doc = self.database.collection("/groups/\(group)/Lessons")
        let firestoreLessonFormat = FirestoreLesson(startTime: lesson.startTime ?? "err",
            weekDay: lesson.weekDay ?? "err", title: lesson.title,
            lessonNumber: lesson.lessonNumber ?? "err", weekType: lesson.weekType.rawValue,
            endTime: lesson.endTime!, building: lesson.building, room: lesson.room ?? "err",
            teacher: lesson.teacher ?? "err", groups: lesson.groups, lessonType: lesson.lessonType)
        do {
            // TODO: addDocument возвращает docRef с необходимыми парами, значит, после добавления можно избежать вызова getLessons чтобы обновить расписание
            _ = try doc.addDocument(from: firestoreLessonFormat)
        } catch let error {
            print(error.localizedDescription)
        }
    }

    public func deleteLesson(_ group: String="4230M", id: String) {
        self.database.collection("/groups/\(group)/Lessons").document(id).delete { err in
            if let err = err {
                // TODO: перенести обработку ошибок в UI слой
                print("Error removing document: \(err.localizedDescription)")
            }
        }
    }

    // метод проверки группы на существование. Должен вызываться при попытке ввести номер группы
    public func checkIfExists(group: String) {
        fatalError("Не реализовано")
    }

}
