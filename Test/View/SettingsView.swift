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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    
    var testTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(LessonCell.self, forCellReuseIdentifier: LessonCell.identifier)
        return table
    }()
    
    
}
