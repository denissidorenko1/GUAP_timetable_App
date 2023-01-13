//
//  LessonCoreData+CoreDataProperties.swift
//  GuapTimeTable
//
//  Created by Denis on 11.11.2022.
//
//

import Foundation
import CoreData
import UIKit

extension LessonCoreData {
    @nonobjc public class func fetchRequest(fetchFaults: Bool = false) -> NSFetchRequest<LessonCoreData> {
        let request = NSFetchRequest<LessonCoreData>(entityName: "LessonCoreData")
        if fetchFaults { request.returnsObjectsAsFaults = false }
        return request
    }

    @nonobjc public class func deleteAllRequest() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "LessonCoreData")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.execute(deleteRequest)
            try (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.save()
        } catch {
//            print("There was an error")
        }
    }

    @NSManaged public var building: String?
    @NSManaged public var groups: [String]?
    @NSManaged public var lessonNumber: Int64
    @NSManaged public var lessonType: String?
    @NSManaged public var subjectTitle: String?
    @NSManaged public var teacher: String?
    @NSManaged public var weekDay: String?
    @NSManaged public var weekType: Int64
    @NSManaged public var room: String?

}

extension LessonCoreData: Identifiable {

}
