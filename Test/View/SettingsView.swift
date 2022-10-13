//
//  SettingsView.swift
//  Test
//
//  Created by Denis on 10.10.2022.
//

import Foundation
import UIKit

class SettingsView: UIViewController {
    
    static var cellSize: CGFloat = 70
    
    
    var testTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(LessonCell.self, forCellReuseIdentifier: LessonCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        self.title = "Тест"
        navigationController?.navigationBar.prefersLargeTitles = true
        testTableView.delegate = self
        testTableView.dataSource = self
        testTableView.backgroundColor = .green
        
        
        
    }
    override func loadView() {
        super.loadView()
        view.addSubview(testTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        testTableView.frame = view.bounds
        testTableView.backgroundColor = .black
    }
    
}


extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LessonCell.identifier, for: indexPath)
        cell.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
      cell.backgroundColor = .clear
        cell.tintColor = .clear
    }
}
