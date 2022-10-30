//
//  LessonModalViewController.swift
//  Test
//
//  Created by Denis on 22.10.2022.
//

import Foundation
import UIKit

// переписать на UIPresentationController, чтобы можно было показывать модальное окно только наполовину
class LessonModalViewController: UIViewController {

    let headerTitle = UILabel()
    var lessonType = UILabel()
    var subjectName = UILabel()
    var room = UILabel()
    var teacher = UILabel()
    var groups = UILabel()

    var building = UILabel()

    func setLabelText() {
        headerTitle.text = "Подробное расписание"
        teacher.numberOfLines = 0
        subjectName.numberOfLines = 0
        groups.numberOfLines = 0
    }

    func configureConstraints() {
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        lessonType.translatesAutoresizingMaskIntoConstraints = false
        subjectName.translatesAutoresizingMaskIntoConstraints = false
        room.translatesAutoresizingMaskIntoConstraints = false
        teacher.translatesAutoresizingMaskIntoConstraints = false
        groups.translatesAutoresizingMaskIntoConstraints = false
        building.translatesAutoresizingMaskIntoConstraints = false

        let headerConstraints = [
            headerTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            headerTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            headerTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ]

        let subjectConstraints = [
            subjectName.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 20),
            subjectName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            subjectName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ]

        let teacherConstraints = [
            teacher.topAnchor.constraint(equalTo: subjectName.bottomAnchor, constant: 20),
            teacher.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            teacher.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ]

        let buildingConstraints = [
            building.topAnchor.constraint(equalTo: teacher.bottomAnchor, constant: 20),
            building.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20)
        ]
        // проблема: если здания нет, то аудитория отображается с отступом от несуществующего здания
        // решение: если текст пуст, отступ 0
        let roomConstraints = [
            room.leftAnchor.constraint(equalTo: building.rightAnchor, constant: building.text == "" ? 0 : 10),
            room.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            room.centerYAnchor.constraint(equalTo: building.centerYAnchor)
        ]

        let groupConstraints = [
            groups.topAnchor.constraint(equalTo: building.bottomAnchor, constant: 20),
            groups.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            groups.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ]

        let lessonTypeConstraints = [
            lessonType.topAnchor.constraint(equalTo: groups.bottomAnchor, constant: 20),
            lessonType.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            lessonType.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ]

        // лейбл здания и аудитория стоят на одной высоте, требуется изменить приоритет для верного отображения
        roomConstraints[0].priority = UILayoutPriority(500)

        NSLayoutConstraint.activate(headerConstraints)
        NSLayoutConstraint.activate(subjectConstraints)
        NSLayoutConstraint.activate(teacherConstraints)
        NSLayoutConstraint.activate(buildingConstraints)
        NSLayoutConstraint.activate(roomConstraints)
        NSLayoutConstraint.activate(groupConstraints)
        NSLayoutConstraint.activate(lessonTypeConstraints)
    }

    func addLabelsToView() {
        view.addSubview(headerTitle)
        view.addSubview(lessonType)
        view.addSubview(subjectName)
        view.addSubview(room)
        view.addSubview(teacher)
        view.addSubview(groups)
        view.addSubview(building)
    }

    func setLabelFonts() {
        headerTitle.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        subjectName.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        building.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        room.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        lessonType.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        teacher.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        groups.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }

    override func loadView() {
        super.loadView()
        setLabelText()
        setLabelFonts()
        addLabelsToView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureConstraints()
    }
}
