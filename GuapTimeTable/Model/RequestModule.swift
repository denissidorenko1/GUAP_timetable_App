//
//  RequestModule.swift
//  Test
//
//  Created by Denis on 10.10.2022.
//

import Foundation
import SwiftSoup

class RequestModule {
    static var shared = RequestModule()

    // TODO: - произвести рефакторинг, переписать на completion, мб тесты сделать, перенести в другой файл
    public func requestTimeTable(group: Group? = nil, teacher: Teacher? = nil,
                                 building: Building? = nil, room: Room? = nil,
                                 completion: @escaping (Week) -> Void) {
        var weekStruct = Week()
        let link = "\(Constants.baseURL)?g=\(group?.id ?? "")&p=\(teacher?.id ?? "")&b=\(building?.id ?? "")&r=\(room?.id ?? "")"
        let request = URLRequest(url: URL(string: link)!)
//        request.allHTTPHeaderFields = ["authToken": "nil"]
//        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) {data, _, _ in
            if let data = data {
                do {
                    var dayStruct = Day(dayTitle: "undefined")
                    var lssn: Lesson?
                    var dayTitle: String?
                    var html = String(data: data, encoding: .utf8) ?? ""
                    // разбиение дней по тегу <h3>
                    let dayTag = "day"
                    let timeTag = "time"
                    html = html.replacingOccurrences(of: "<h3>", with: "</\(dayTag)><\(dayTag)><h3>")
                    html = html.replaceFirst(of: "</\(dayTag)>", with: "")
                    // разбиение пар и времени по тегу <h4>
                    html = html.replacingOccurrences(of: "<h4>", with: "</\(timeTag)><\(timeTag)><h4>")
                    html = html.replaceLast(of: "</div></div>", with: "</\(timeTag)></\(dayTag)></div></div>")

                    let doc: Document = try SwiftSoup.parse(html)
                    let result = try doc.getElementsByClass("result").first()!

                    let thisWeekType = try doc.getElementsByTag("em").first()?.className()
                    switch thisWeekType {
                    case "dn":
                        weekStruct.currentWeekType = .blue
                    case "up":
                        weekStruct.currentWeekType = .red
                    default:
                        weekStruct.currentWeekType = .both
                    }
                    // разбиение по дням недели
                    let days = try result.getElementsByTag("\(dayTag)")
                    for day in days {
                        dayTitle = try day.getElementsByTag("h3").first()?.text()
                        // разбиение по времени пар
                        let times = try day.getElementsByTag("\(timeTag)")
                        for time in times {
                            let timeStamp = try time.getElementsByTag("h4").first()?.text()
                            guard let timeStamp = timeStamp else {
                                return
                            }
                            var startTime: String?
                            var endTime: String?
                            var lessonNumber: String?

                            if timeStamp.contains("–") { // если содержит, значит, существует дата
                                let leftBracketIndex = timeStamp.firstIndex(of: "(")!
                                let rightBracketIndex = timeStamp.lastIndex(of: ")")!
                                var newStr = String(timeStamp[leftBracketIndex..<rightBracketIndex])
                                newStr = newStr.replacingOccurrences(of: "(", with: "")
                                startTime = String(newStr.split(separator: "–").first ?? "")
                                endTime = String(newStr.split(separator: "–").last ?? "")
                                lessonNumber = String(timeStamp.prefix(1))
                            }

                            // разбиение по занятием на паре
                            let lessons = try time.getElementsByClass("study")
                            for lesson in lessons {

                                let lessonType = try lesson.getElementsByTag("b").last()?.text()

                                let dnWeek = try lesson.getElementsByClass("dn").first()
                                let upWeek = try lesson.getElementsByClass("up").first()
                                var weekType = WeekType.both
                                switch (dnWeek, upWeek) {
                                case (nil, nil): // оба nil, значит, проводятся в любой тип недели
                                    weekType = WeekType.both
                                case (nil, _): // нижняя неделя nil, значит верхняя
                                    weekType = WeekType.red
                                case (_, nil): // верхняя неделя nil, значит нижняя
                                    weekType = WeekType.blue
                                default:
                                    fatalError("Switch statement has default case, which is not possible")
                                }
                                let pairPlace = try lesson.getElementsByTag("span").first()!
                                    .text().components(separatedBy: " – ")
                                let title = pairPlace[1]
                                let building = pairPlace[2].components(separatedBy: ",").first
                                let room = pairPlace[2].components(separatedBy: ". ").last
                                let groups = try lesson.getElementsByClass("groups").text().components(separatedBy: ";")
                                let teacher = try lesson.getElementsByClass("preps").first()?
                                    .text().replacingOccurrences(of: "Преподаватель: ", with: "")
                                lssn = Lesson(title: title, startTime: startTime, endTime: endTime,
                                              lessonNumber: lessonNumber, teacher: teacher,
                                              lessonType: lessonType ?? "", groups: groups,
                                              building: building ?? "undef",
                                              room: room ?? "undef", weekType: weekType)
                                dayStruct.lessons.append(lssn!)
                            }
                        }
                        dayStruct.dayTitle = dayTitle ?? "undefined"
                        weekStruct.days.append(dayStruct)
                        dayStruct.lessons = []
                    }
                    completion(weekStruct)
                } catch Exception.Error(let type, let message) {
                    print(type, message)
                } catch {
                    print("error parsing timetable")
                }
            }

        }.resume()
    }

    public func getSelectData(completion: @escaping (SelectData) -> Void) {
        var request = URLRequest(url: URL(string: "\(Constants.baseURL)")!)
        request.allHTTPHeaderFields = ["authToken": "nil"]
        request.httpMethod = "GET"
        var groups = Groups()
        var teachers = Teachers()
        var rooms = Rooms()
        var buildings = Buildings()
        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                do {
                    let html = String(data: data, encoding: .utf8)!
                    let doc: Document = try SwiftSoup.parse(html)
                    let selects = try doc.select("select")
                    for (index, select) in selects.enumerated() {
                        let options = try select.select("option")
                        for option in options {
                            let value = try option.attr("value")
                            let text = try option.text()
                            switch index {
                            case 0:
                                groups.groupList.append(Group(id: value, group: text))
                            case 1:
                                teachers.teacherList.append(Teacher(id: value, name: text))
                            case 2:
                                buildings.buildingList.append(Building(id: value, addres: text))
                            case 3:
                                rooms.roomList.append(Room(id: value, room: text))
                            default:
                                fatalError("Default")
                            }
                            }
                        }
                    completion(SelectData(groups: groups, rooms: rooms, teachers: teachers, buildings: buildings))
                } catch Exception.Error(let type, let message) {
                    print(type, message)
                } catch {
                    print("unknown error")
                }
            }
        }.resume()
    }
}
