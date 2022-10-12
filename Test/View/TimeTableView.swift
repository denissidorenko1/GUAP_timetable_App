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
        sleep(4)
        return wk
    }()
    var timeTableTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(LessonTableViewCell.self, forCellReuseIdentifier: LessonTableViewCell.identifier)
        return table
    }()
    
    private func getTimeTable() {
        RequestModule.shared.requestTimeTable(group: Group(id: "326", group: ""), teacher: nil, building: nil, room: nil) {[weak self] data in
            self?.timeTable = data
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        self.title = "Расписание"
        navigationController?.navigationBar.prefersLargeTitles = true
        
//        navigationItem.largeTitleDisplayMode = .always
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
        timeTableTableView.backgroundColor = .purple
    }
}

extension TimeTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return timeTable?.days.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return timeTable?.days[section].dayTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(timeTable)
//        return timeTable?.days.count ?? 0
        // тут ошибка
//        tableView.cellForRow(at: IndexPath(row: section, section: 0))?.textLabel?.text = timeTable?.days[section].dayTitle
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // мб сюда впилить лейбл с названием
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = timeTable?.days[indexPath.row].dayTitle
//        return cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LessonTableViewCell.identifier, for: indexPath) as? LessonTableViewCell else {return UITableViewCell()}
        cell.largeContentTitle = "kek"
//        cell.textLabel?.text = timeTable?.days[indexPath.section].dayTitle
//        cell.numberOfSections?(in: cell)
        let pairCount = timeTable?.days[indexPath.section].lessons.count ?? 1
        print(pairCount)
        cell.count = pairCount
//        cell.collectionView(LessonTableViewCell().collectionView, numberOfItemsInSection: pairCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let size = timeTable?.days[indexPath.section].lessons.count else { return 500} 
//        print(size)
//        print(indexPath.section)
        return CGFloat(size) * SettingsView.cellSize + 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
}
