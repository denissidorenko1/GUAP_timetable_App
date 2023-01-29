//
//  CustomTimeTableView.swift
//  Test
//
//  Created by Denis on 25.10.2022.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol UpdateableFromFireStore: AnyObject {
    func updateFireStoreAfterChange()
}

final class CustomTimeTableView: UIViewController, UpdateableFromFireStore {
    private var customTimeTable: Week?
    private var customTimeTableTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        // пока удалим пустую ячейку, случаи пустого расписания обработаем позже
        // регистрация пустой ячейки
        table.register(EmptyDataCell.self, forCellReuseIdentifier: EmptyDataCell.identifier)
        // регистрация ячейки с данными
        table.register(LessonCell.self, forCellReuseIdentifier: LessonCell.identifier)
        return table
    }()

    private func loadFirebase() {
        FirebaseApi.shared.getLessons { timeTable in
            self.customTimeTable = timeTable
            DispatchQueue.main.async {
                self.customTimeTableTableView.reloadData()
            }

        }
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Кастом"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addNewLessonButton))
        navigationItem.rightBarButtonItem?.tintColor = .label
        loadFirebase()
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
        show(AddLessonViewController(sender: self), sender: nil)
    }

    func updateFireStoreAfterChange() {
        FirebaseApi.shared.getLessons { timeTable in
            self.customTimeTable = timeTable
            DispatchQueue.main.async {
                self.customTimeTableTableView.reloadData()
            }
        }
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

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, completionHandler) in
            FirebaseApi.shared.deleteLesson(id: self.customTimeTable?.days[indexPath.section].lessons[indexPath.row].id ?? "")
            self.loadFirebase()
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
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
        return self.customTimeTable?.days[section].dayTitle ?? "Ошибка"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = customTimeTableTableView.dequeueReusableCell(withIdentifier: LessonCell.identifier) as? LessonCell else {
            return UITableViewCell()
        }
        cell.setData(timeTable: self.customTimeTable, indexPath: indexPath)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.customTimeTable?.days.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.customTimeTable?.days[section].lessons.count ?? 0
    }
}
