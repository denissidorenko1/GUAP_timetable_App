//
//  TimeTableView.swift
//  Test
//
//  Created by Denis on 10.10.2022.
//

import Foundation
import UIKit

class TimeTableViewController: UIViewController {
    
    public var timeTable: Week?
    
    var timeTableTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(EmptyDataCellView.self, forCellReuseIdentifier: EmptyDataCellView.identifier) // регистрация пустой ячейки
        table.register(LessonCellView.self, forCellReuseIdentifier: LessonCellView.identifier) // регистрация ячейки с данными
        return table
    }()
    
    
    // загружаем расписание, когда загружено - обновляем таблицу
    public func getTimeTable() {
        RequestModule.shared.requestTimeTable(group: SettingsStorage.shared.getStoredGroup()) {[weak self] data in
            self?.timeTable = data
            DispatchQueue.main.async {
                self?.timeTableTableView.reloadData()
                self?.setHeaderView() // при получении информации настроим хедер, ведь там тип недели
            }
        }
    }
    
    let header = TableHeaderView(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 20, height: 50))
    
    func setHeaderView(){
        header.currentWeekType = timeTable?.currentWeekType // передаем тип недели
        timeTableTableView.tableHeaderView = header
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
        getTimeTable()
        setHeaderView()
        view.addSubview(timeTableTableView)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeTableTableView.frame = view.bounds
        timeTableTableView.backgroundColor = .systemBackground
        self.timeTableTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
}

extension TimeTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let timeTable = timeTable else { return 1}
        return timeTable.days.count == 0 ? 1 : timeTable.days.count
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // когда данных нет, отправляем ошибку заголовка, чтобы таблица не прыгала при обновлении
        if timeTable?.days.count == 0 {return "Ошибка запроса"}
        else if timeTable == nil {return "Ошибка сети" }
        else{
            return timeTable?.days[section].dayTitle
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if timeTable?.days.count == 0 {return 1} else {
            return timeTable?.days[section].lessons.count ?? 1
        }
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
            return "Курсовой проект"
        case "КР":
            return "Курсовая работа"
        default:
            return "" // есть еще какой-то тип пар, вроде
        }
    }
    
    
    // это ужасно, переписать в другой модуль
    // стало еще хуже
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let optionalZero: Int? = 0
        switch timeTable{
        // если расписание не получено (нет сети), вернуть пустую ячейку
        case nil:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmptyDataCellView.identifier, for: indexPath) as? EmptyDataCellView {
                cell.explanation.text = "Похоже, отсутствует подключение к сети"
                return cell
            }
        // если запрос прошел, но ответ пуст, вернуть пустую ячейку
        case let temp where temp?.days.count == optionalZero:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmptyDataCellView.identifier, for: indexPath) as? EmptyDataCellView {
                cell.explanation.text = "Похоже, группа не выбрана или не существует"
                return cell
            }
        // по умолчанию возвращаем заполненную ячейку с данными
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LessonCellView.identifier, for: indexPath) as? LessonCellView else {
                        return UITableViewCell()}
            cell.room.text = timeTable?.days[indexPath.section].lessons[indexPath.item].room
            cell.lessonNumber.text = timeTable?.days[indexPath.section].lessons[indexPath.item].lessonNumber
            cell.lessonType.text = getLessonType(abbr: timeTable?.days[indexPath.section].lessons[indexPath.item].lessonType)
            cell.teacher.text = timeTable?.days[indexPath.section].lessons[indexPath.item].teacher
            cell.groups.text = timeTable?.days[indexPath.section].lessons[indexPath.item].groups.joined(separator: ", ")
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Раскрыть") { [weak self] (_, _, completionHandler) in
            let modalView = LessonModalViewController()
            // может, это можно сделать лучше?
            // если данных нет, то попытка заполнить модальное окно пустыми данными приведет к runtime error
            if self?.timeTable == nil || self?.timeTable?.days.count == 0 {}
            else {
                modalView.room.text = self?.timeTable?.days[indexPath.section].lessons[indexPath.item].room
                modalView.lessonType.text =  self?.getLessonType(abbr: self?.timeTable?.days[indexPath.section].lessons[indexPath.item].lessonType)
                modalView.teacher.text = self?.timeTable?.days[indexPath.section].lessons[indexPath.item].teacher
                modalView.groups.text = self?.timeTable?.days[indexPath.section].lessons[indexPath.item].groups.joined(separator: ", ")
                modalView.subjectName.text = self?.timeTable?.days[indexPath.section].lessons[indexPath.item].title
                modalView.building.text = self?.timeTable?.days[indexPath.section].lessons[indexPath.item].building
            }
            self?.present(modalView, animated: true, completion: nil)
            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    
}
