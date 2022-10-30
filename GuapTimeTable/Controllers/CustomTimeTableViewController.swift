//
//  CustomTimeTableView.swift
//  Test
//
//  Created by Denis on 25.10.2022.
//

import Foundation
import UIKit

final class CustomTimeTableView: UIViewController {

    private var customTimeTable: Week?
    private var customTimeTableTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        // пока удалим пустую ячейку, случаи пустого расписания обработаем позже
        // регистрация пустой ячейки
//        table.register(EmptyDataCell.self, forCellReuseIdentifier: EmptyDataCell.identifier)
        // регистрация ячейки с данными
        table.register(LessonCell.self, forCellReuseIdentifier: LessonCell.identifier)
        return table
    }()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Кастом"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self, action: #selector(addNewLessonButton))
        navigationItem.rightBarButtonItem?.tintColor = .label
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
    }
}

// MARK: - TableViewDelegate, TableViewDataSource
extension CustomTimeTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = customTimeTableTableView.dequeueReusableCell(
            withIdentifier: LessonCell.identifier) as? LessonCell else {
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Тест"
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
