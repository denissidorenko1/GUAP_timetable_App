//
//  ViewController.swift
//  Test
//
//  Created by Denis on 18.09.2022.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {
    // При задержке и многократном нажатии на кнопку, будет многократно отправлен запрос, и придет сразу несколько фактов, которые перекроют друг друга. Чтобы избежать этого, добавим костыль, блокирующий вызов функции если она еще не завершилась

    @IBOutlet var label: UILabel!
    @IBAction func getFact(sender: UIButton) {
            makeRequest()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //requestTimeTable(group: data.groups.groupList.randomElement(), teacher: nil, building: nil, room: nil)
//        var lol: SelectData? = nil
//        getSelectData() { data in
////            print(data.buildings.buildingList.randomElement()!)
//            lol = data
//
//        }
//        sleep(3)
//        print(lol?.groups.groupList.randomElement())
        let group = Group(id: "326", group: "")
        requestTimeTable(group: group, teacher: nil, building: nil, room: nil)
    }
    
    
    private func requestTimeTable(group: Group?, teacher: Teacher?, building: Building?, room: Room? ) {
        
        let link = "\(Constants.baseURL)?g=\(group?.id ?? "")&p=\(teacher?.id ?? "")&b=\(building?.id ?? "")&r=\(room?.id ?? "")"
        var request = URLRequest(url: URL(string: link)!)
        request.allHTTPHeaderFields = ["authToken": "nil"]
        request.httpMethod = "GET"
        let _ = URLSession.shared.dataTask(with: request) {data, response, error in
            if let data = data {
                do {
                    var html = String(data: data, encoding: .utf8) ?? ""
                    // разбиение дней по тегу <h3>
                    let dayTag = "day"
                    let timeTag = "time"
                    html = html.replacingOccurrences(of: "<h3>", with: "</\(dayTag)><h3>")
                    html = html.replacingOccurrences(of: "</h3>", with: "</h3><\(dayTag)>")
                    html = html.replaceFirst(of: "</\(dayTag)>", with: "")
//                    html = html.replaceLast(of: "</div></div>", with: "</\(dayTag)></div></div>")
                    
                    // разбиение пар и времени по тегу <h4>
                    html = html.replacingOccurrences(of: "<h4>", with: "</\(timeTag)><h4>")
                    html = html.replacingOccurrences(of: "</h4>", with: "</h4><\(timeTag)>")
                    html = html.replaceFirst(of: "</\(timeTag)>", with: "")
//                    html = html.replaceLast(of: "</div></div>", with: "</\(timeTag)><></div></div>")
                    
                    html = html.replaceLast(of: "</div></div>", with: "</\(timeTag)></\(dayTag)></div></div>")
                    
//                    print(html)
                    
                    let doc: Document = try SwiftSoup.parse(html)
                    let result = try doc.getElementsByClass("result").first()!
                    // разбиение по дням недели
                    let days = try result.getElementsByTag("\(dayTag)")
                    for day in days{
                        print("************")
                        // разбиение по времени пар
                        let times = try day.getElementsByTag("\(timeTag)")
                        for time in times {
                            print("&&&&&&&&&&&")
                            // разбиение по занятием на паре
                            let lessons = try time.getElementsByClass("study")
                            for lesson in lessons {
                                print("^^^^^^^^^^^")
                                print(lesson)
                            }
                        }
                    }
                } catch Exception.Error(let type, let message) {
                    print(type, message)
                } catch {
                    print("error parsing timetable")
                }
            }
            
        }.resume()
    }

    private func getSelectData(completion: @escaping (SelectData)->()) {
        // https://guap.ru/rasp/
        var request = URLRequest(url: URL(string: "\(Constants.baseURL)")!)
        request.allHTTPHeaderFields = ["authToken": "nil"]
        request.httpMethod = "GET"
        var groups = Groups()
        var teachers = Teachers()
        var rooms = Rooms()
        var buildings = Buildings()
        let _ = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let html = String(data: data, encoding: .utf8)!
                    let doc: Document = try SwiftSoup.parse(html)
                    let selects = try doc.select("select")
                    for (index,select) in selects.enumerated()  {
                        let options = try select.select("option")
                        for option in options {
                            let value = try option.attr("value")
                            let text = try option.text()
                            switch index{
                            case 0:
                                let gr = Group(id: value, group: text)
                                groups.groupList.append(gr)
                            case 1:
                                let tchr = Teacher(id: value, name: text)
                                teachers.teacherList.append(tchr)
                            case 2:
                                let bldng = Building(id: value, addres: text)
                                buildings.buildingList.append(bldng)
                            case 3:
                                let rm = Room(id: value, room: text)
                                rooms.roomList.append(rm)
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
    
    
    private func makeRequest() {
        
        
        var request = URLRequest(url: URL(string: "https://catfact.ninja/fact")!)
        request.allHTTPHeaderFields = ["authToken": "nil"]
        request.httpMethod = "GET"
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            let task = URLSession.shared.dataTask(with: request) {data, response, error in
                if let data = data, let fact = try? JSONDecoder().decode(CatFact.self, from: data) {
//                    sleep(2) // имитация задержки
                    DispatchQueue.main.async {
                        self.label.text = fact.fact
                        // впилить сюда completion
                    }
                }
            }
            task.resume()
        }
    }
}


extension String {
  
  public func replaceFirst(of pattern:String, with replacement:String) -> String {
      if let range = self.range(of: pattern){
      return self.replacingCharacters(in: range, with: replacement)
    }else {return self}
  }
    
    public func replaceLast(of pattern:String, with replacement:String) -> String {
        if let range = self.range(of: pattern, options: .backwards){
        return self.replacingCharacters(in: range, with: replacement)
      }else {return self}
    }
    
    
  
  public func replaceAll(of pattern:String,
                         with replacement:String,
                         options: NSRegularExpression.Options = []) -> String{
    do{
      let regex = try NSRegularExpression(pattern: pattern, options: [])
      let range = NSRange(0..<self.utf16.count)
      return regex.stringByReplacingMatches(in: self, options: [],
                                            range: range, withTemplate: replacement)
    }catch{
      NSLog("replaceAll error: \(error)")
      return self
    }
  }
  
}
