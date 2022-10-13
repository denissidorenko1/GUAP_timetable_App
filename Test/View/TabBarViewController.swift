//
//  ViewController.swift
//  Test
//
//  Created by Denis on 18.09.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        
        let vc1 = UINavigationController(rootViewController: TimeTableView())
        let vc2 = UINavigationController(rootViewController: SettingsView())
        let vc3 = UINavigationController(rootViewController: UIViewController())
        
        vc1.title = "Расписание"
        vc2.title = "Дедлайны"
        vc3.title = "Настройки"
        
        vc1.tabBarItem.image = UIImage(systemName: "calendar")
        vc2.tabBarItem.image = UIImage(systemName: "alarm.fill")
        vc3.tabBarItem.image = UIImage(systemName: "gear")
        setViewControllers([vc1, vc2, vc3], animated: true)
        
        tabBar.tintColor = .label
    }
}

