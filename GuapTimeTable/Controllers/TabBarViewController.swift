//
//  ViewController.swift
//  Test
//
//  Created by Denis on 18.09.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    let timeTableView = TimeTableViewController()
    let deadLineView = DeadLineViewController()
    let settingsView = SettingsViewController()
    let customTimeTableView = CustomTimeTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupNavigation()
    }

    private func setupAppearance() {
        view.backgroundColor = .systemPink
        tabBar.tintColor = .label
    }

    private func setupNavigation() {
        // назначаем вью, которое будем обновлять при изменении настроек
        settingsView.responsiveTableView = timeTableView
        let vc1 = UINavigationController(rootViewController: timeTableView)
        let vc2 = UINavigationController(rootViewController: deadLineView)
        let vc3 = UINavigationController(rootViewController: settingsView)
        let vc4 = UINavigationController(rootViewController: customTimeTableView)
        vc1.title = "Расписание"
        vc2.title = "Дедлайны"
        vc3.title = "Настройки"
        vc4.title = "Кастом"

        vc1.tabBarItem.image = UIImage(systemName: "calendar")
        vc2.tabBarItem.image = UIImage(systemName: "alarm.fill")
        vc3.tabBarItem.image = UIImage(systemName: "gear")
        vc4.tabBarItem.image = UIImage(systemName: "gyroscope")
        setViewControllers([vc1, vc4, vc2, vc3], animated: true)
    }
}
