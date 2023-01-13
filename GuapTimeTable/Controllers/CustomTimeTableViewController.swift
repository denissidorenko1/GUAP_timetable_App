//
//  CustomTimeTableView.swift
//  Test
//
//  Created by Denis on 25.10.2022.
//

import Foundation
import UIKit
import CoreData
final class CustomTimeTableView: UIViewController, SaveableToCoreData {

    let weekDays: [String] = ["Понедельник", "Вторник", "Среда", "Четверг",
                                       "Пятница", "Суббота", "Воскресенье"]

    private var customTimeTableTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        // пока удалим пустую ячейку, случаи пустого расписания обработаем позже
        // регистрация пустой ячейки
//        table.register(EmptyDataCell.self, forCellReuseIdentifier: EmptyDataCell.identifier)
        // регистрация ячейки с данными
        table.register(LessonCell.self, forCellReuseIdentifier: LessonCell.identifier)
        return table
    }()

    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var coreDataTimeTable: [LessonCoreData]? = {
        do {
            return try (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext.fetch(LessonCoreData.fetchRequest(fetchFaults: false))
        } catch {
        }
        return []
    }()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Кастом"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addNewLessonButton))
        navigationItem.rightBarButtonItem?.tintColor = .label
        addTestData()
        fetchData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customTimeTableTableView)
        self.customTimeTableTableView.delegate = self
        self.customTimeTableTableView.dataSource = self
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        customTimeTableTableView.frame = view.bounds
    }

    @objc func addNewLessonButton() {
        // добавить переход на экран заполнения расписания
        show(ChangeLessonViewController(), sender: nil)
    }

    func addTestData() {
        LessonCoreData.deleteAllRequest()
        let data = LessonCoreData(context: self.context!)
        let data2 = LessonCoreData(context: self.context!)
        let data3 = LessonCoreData(context: self.context!)
        let data4 = LessonCoreData(context: self.context!)
        data.weekDay = "Понедельник"
        data.subjectTitle = "Программирование"
        data.building = "БМ"
        data.groups = ["4230M"]
        data.lessonNumber = 3
        data.lessonType = "Лекция"
        data.room = "5240"
        data.teacher = "Соловьева"
        data.weekType = 1

        context?.insert(data)
        do {
            try context?.save()
        } catch {}

        data2.weekDay = "Вторник"
        data2.subjectTitle = "Физра"
        data2.building = "БМ"
        data2.groups = ["4230M"]
        data2.lessonNumber = 3
        data2.lessonType = "Лекция"
        data2.room = "5240"
        data2.teacher = "Соловьева"
        data2.weekType = 1

        context?.insert(data2)
        do {
            try context?.save()
        } catch {}

        data3.weekDay = "Среда"
        data3.subjectTitle = "Программирование"
        data3.building = "БМ"
        data3.groups = ["4230M"]
        data3.lessonNumber = 2
        data3.lessonType = "Лекция"
        data3.room = "5240"
        data3.teacher = "Соловьева"
        data3.weekType = 2

        context?.insert(data3)
        do {
            try context?.save()
        } catch {}

        data4.weekDay = "Понедельник"
        data4.subjectTitle = "Программирование задниц"
        data4.building = "БМ"
        data4.groups = ["4230M"]
        data4.lessonNumber = 1
        data4.lessonType = "Лекция"
        data4.room = "5240"
        data4.teacher = "Соловьева"
        data4.weekType = 1

        context?.insert(data4)
        do {
            try context?.save()
        } catch {}
    }

    func fetchData() {
        do {
            self.coreDataTimeTable = try context?.fetch(LessonCoreData.fetchRequest())
//            print(coreDataTimeTable?.count)
//            print(coreDataTimeTable)
        } catch {
        }
    }

    func saveToPersistentStorage(_ initialModel: LessonCoreData?, _ newModel: LessonCoreData) {
        guard let initialModel = initialModel else {
//            return
            context?.insert(newModel)
            try? context?.save()
            return
        }
        context?.delete(initialModel)
        context?.insert(newModel)
        try? context?.save()
        customTimeTableTableView.reloadData()
    }

}

// MARK: - TableViewDelegate
extension CustomTimeTableView: UITableViewDelegate {
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
        let action = UIContextualAction(style: .normal, title: "Редактировать") { [weak self] (_, _, completionHandler) in
            let lesson = ChangeLessonViewController()
            let weekDayTitles = self?.coreDataTimeTable!.map { $0.weekDay! }
            let filteredWeekDays = self?.weekDays.filter {element in
                return weekDayTitles!.contains(element)
            }
            lesson.saveDelegate = self
            let lessonsInADay = self?.coreDataTimeTable?.filter {$0.weekDay == filteredWeekDays?[indexPath.section]}
            lesson.fillCoreData(data: lessonsInADay![indexPath.row])
            self?.show(lesson, sender: nil)
            completionHandler(true)
        }
        action.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [action])

    }

}

// MARK: - TableViewDataSource
extension CustomTimeTableView: UITableViewDataSource {
    /*  Other responsibilities of the data source object include:
            Reporting the number of sections and rows in the table.
            Providing cells for each row of the table.
            Providing titles for section headers and footers.
            Configuring the table’s index, if any.
            Responding to user- or table-initiated updates that require changes to the underlying data.
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let weekDayTitles = coreDataTimeTable!.map {lesson in
            return lesson.weekDay
        }
        let filtered = self.weekDays.filter {element in
            return weekDayTitles.contains(element)
        }
        return filtered[section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = customTimeTableTableView.dequeueReusableCell(
            withIdentifier: LessonCell.identifier) as? LessonCell else {
            return UITableViewCell()
        }
        let weekDayTitles = coreDataTimeTable!.map { $0.weekDay! }
        let filteredWeekDays = self.weekDays.filter {element in
            return weekDayTitles.contains(element)
        }
        let lessonsInADay = self.coreDataTimeTable?.filter {$0.weekDay == filteredWeekDays[indexPath.section]}
        cell.setDataFromCoreData(data: lessonsInADay![indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // количество пар в дне
        let weekDayTitles = coreDataTimeTable!.map { $0.weekDay! }
        let filteredWeekDays = self.weekDays.filter {element in
            return weekDayTitles.contains(element)
        }
        let lessonsInADay = self.coreDataTimeTable?.filter {$0.weekDay == filteredWeekDays[section]}
        return lessonsInADay?.count ?? 0

    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // это можно сократить
        // количество дней в расписании
        let weekDays = coreDataTimeTable!.map {lesson in
            return lesson.weekDay
        }
        return weekDays.unique().count
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: [Iterator.Element: Bool] = [:]
        return self.filter { seen.updateValue(true, forKey: $0) == nil }
    }
}
