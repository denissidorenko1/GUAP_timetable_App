import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// MARK: - FirestoreLesson
struct FirestoreLesson: Codable {
//    @DocumentID var id: String?

    let startTime: String
    let weekDay: String
    let title: String
    let lessonNumber: String
    let weekType: String
    let endTime: String
    let building: String
    let room: String
    let teacher: String
    let groups: [String]
    let lessonType: String

    // нужно перечислять все поля в CodingKeys
    enum CodingKeys: String, CodingKey {
        case weekDay = "WeekDay"
        case weekType = "WeekType"
        case startTime
        case title
        case endTime
        case building
        case room
        case teacher
        case groups
        case lessonNumber
        case lessonType
    }
}
