//
//  TimeTableView.swift
//  Test
//
//  Created by Denis on 10.10.2022.
//

import Foundation
import UIKit

final class TimeTableViewController: UIViewController {

    private var timeTable: Week?
    private var timeTableTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        // регистрация пустой ячейки
        table.register(EmptyDataCell.self, forCellReuseIdentifier: EmptyDataCell.identifier)
        // регистрация ячейки с данными
        table.register(LessonCell.self, forCellReuseIdentifier: LessonCell.identifier)
        return table
    }()

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

    // загружаем расписание, когда загружено - обновляем таблицу
    public func getTimeTable() {
        // TODO: убрать self из capture list, он не нужен
        RequestModule.shared.requestTimeTable(group: SettingsStorage.shared.getStoredGroup()) {[weak self] data in
            self?.timeTable = data
            DispatchQueue.main.async {
                self?.timeTableTableView.reloadData()
                self?.setHeaderView() // при получении информации настроим хедер, ведь там тип недели
            }
        }
    }

    func setHeaderView() {
        let header = TableHeaderView()
        header.getWeekType(week: timeTable?.currentWeekType)
        timeTableTableView.tableHeaderView = header
    }
}

// MARK: - TableViewDelegate
extension TimeTableViewController: UITableViewDelegate {
    /*
     Use the methods of this protocol to manage the following features:
        Create and manage custom header and footer views.
        Specify custom heights for rows, headers, and footers.
        Provide height estimates for better scrolling support.
        Indent row content.
        Respond to row selections.
        Respond to swipes and other actions in table rows.
        Support editing the table’s content.
     */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Раскрыть") { [weak self] (_, _, completionHandler) in
            let modalView = LessonModalViewController()
            // если данных нет, то попытка заполнить модальное окно пустыми данными приведет к runtime error
            if self?.timeTable == nil || self?.timeTable?.days.count == 0 {
            } else {
                modalView.setData(timeTable: self?.timeTable, indexPath: indexPath)
            }
            self?.present(modalView, animated: true, completion: nil)
            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }
}

// MARK: - TableViewDataSource
extension TimeTableViewController: UITableViewDataSource {
/*  Other responsibilities of the data source object include:
        Reporting the number of sections and rows in the table.
        Providing cells for each row of the table.
        Providing titles for section headers and footers.
        Configuring the table’s index, if any.
        Responding to user- or table-initiated updates that require changes to the underlying data.
 */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // когда данных нет, отправляем ошибку заголовка, чтобы таблица не прыгала при обновлении
        if timeTable?.days.count == 0 {
            return "Ошибка запроса"
        } else if timeTable == nil {
            return "Ошибка сети"
        } else {
            return timeTable?.days[section].dayTitle
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if timeTable?.days.count == 0 {return 1} else {
            return timeTable?.days[section].lessons.count ?? 1
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let timeTable = timeTable else { return 1}
        return timeTable.days.count == 0 ? 1 : timeTable.days.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let optionalZero: Int? = 0
        switch timeTable {
        // если расписание не получено (нет сети), вернуть пустую ячейку
        case nil:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmptyDataCell.identifier,
                                                        for: indexPath) as? EmptyDataCell {
                cell.setErrorExplanations(error: .noInternet)
                return cell
            }
        // если запрос прошел, но ответ пуст, вернуть пустую ячейку
        case let temp where temp?.days.count == optionalZero:
            if let cell = tableView.dequeueReusableCell(withIdentifier: EmptyDataCell.identifier,
                                                        for: indexPath) as? EmptyDataCell {
                cell.setErrorExplanations(error: .wrongQuery)
                return cell
            }
        // по умолчанию возвращаем заполненную ячейку с данными
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.identifier,
                                                           for: indexPath) as? LessonCell else {
                        return UITableViewCell()}
            cell.setData(timeTable: timeTable, indexPath: indexPath)
            return cell
        }
        return UITableViewCell()
    }
}
