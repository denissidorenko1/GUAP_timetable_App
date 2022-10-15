//
//  TimeTableView.swift
//  Test
//
//  Created by Denis on 10.10.2022.
//

import Foundation
import UIKit

class TimeTableView: UIViewController {
    
    public var timeTable: Week? = { () -> Week? in
        var wk: Week?
        RequestModule.shared.requestTimeTable(group: Group(id: "326", group: "")) { data in
            wk = data
        }
        sleep(1)
        return wk
    }()
    var timeTableTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(EmptyDataCell.self, forCellReuseIdentifier: EmptyDataCell.identifier) // регистрация пустой ячейки
        table.register(LessonCell.self, forCellReuseIdentifier: LessonCell.identifier)
        return table
    }()
    
    private func getTimeTable() {
        RequestModule.shared.requestTimeTable(group: Group(id: "326", group: ""), teacher: nil, building: nil, room: nil) {[weak self] data in
            self?.timeTable = data
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Расписание"
        navigationController?.navigationBar.prefersLargeTitles = true
        timeTableTableView.delegate = self
        timeTableTableView.dataSource = self
        
    }
    
    override func loadView() {
        super.loadView()
        DispatchQueue.main.async {[weak self] in
            self?.getTimeTable()
        }
        view.addSubview(timeTableTableView)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeTableTableView.frame = view.bounds
        timeTableTableView.backgroundColor = .systemBackground
        self.timeTableTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
}

extension TimeTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return timeTable?.days.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return timeTable?.days[section].dayTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeTable?.days[section].lessons.count ?? 1
    }
    
    func getLessonType(abbr :String?) -> String{
        switch abbr{
        case "ЛР":
            return "Лабораторная работа"
        case "ПР":
            return "Практическая работа"
        case "Л":
            return "Лекция"
        case "КП":
            return "Курсовая"
        default:
            return ""
        }
    }
    
    
    // это ужасно, переписать в другой модуль
    // стало еще хуже
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch timeTable{
        // если расписание не получено или пустое, вернуть пустую ячейку
        case nil:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmptyDataCell.identifier, for: indexPath) as? EmptyDataCell {
                return cell
            }
        // по умолчанию возвращаем заполненную ячейку с данными
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.identifier, for: indexPath) as? LessonCell else {
                        print("Default cell is returned")
                        return UITableViewCell()}
            cell.room.text = timeTable?.days[indexPath.section].lessons[indexPath.item].room
            cell.lessonNumber.text = timeTable?.days[indexPath.section].lessons[indexPath.item].lessonNumber
            cell.lessonType.text = getLessonType(abbr: timeTable?.days[indexPath.section].lessons[indexPath.item].lessonType)
            cell.teacher.text = timeTable?.days[indexPath.section].lessons[indexPath.item].teacher
            cell.groups.text = timeTable?.days[indexPath.section].lessons[indexPath.item].groups.joined(separator: " ")
            cell.subjectName.text = timeTable?.days[indexPath.section].lessons[indexPath.item].title
            cell.endTime.text = timeTable?.days[indexPath.section].lessons[indexPath.item].endTime
            cell.startTime.text = timeTable?.days[indexPath.section].lessons[indexPath.item].startTime
            switch timeTable?.days[indexPath.section].lessons[indexPath.item].weekType {
            case .red:
                cell.lessonNumber.textColor = .red
            case .blue:
                cell.lessonNumber.textColor = .blue
            default:
                // ничего не делать, неделя универсальная
                break
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}
