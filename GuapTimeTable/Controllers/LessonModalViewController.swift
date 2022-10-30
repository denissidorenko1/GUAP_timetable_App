//
//  LessonModalViewController.swift
//  Test
//
//  Created by Denis on 22.10.2022.
//

import Foundation
import UIKit

// переписать на UIPresentationController, чтобы можно было показывать модальное окно только наполовину
final class LessonModalViewController: UIViewController {
    private let headerTitle = UILabel()
    private let lessonType = UILabel()
    private let subjectName = UILabel()
    private let room = UILabel()
    private let teacher = UILabel()
    private let groups = UILabel()
    private let building = UILabel()

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

        NSLayoutConstraint.activate([headerConstraints, subjectConstraints, teacherConstraints,
                                    buildingConstraints, roomConstraints, groupConstraints,
                                    lessonTypeConstraints].flatMap {$0})
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

    private func getLessonType(abbr: String?) -> String {
        switch abbr {
        case "ЛР":
            return "Лабораторная работа"
        case "ПР":
            return "Практическая работа"
        case "Л":
            return "Лекция"
        case "КП":
            return "Курсовой проект"
        case "КР":
            return "Курсовая работа"
        default:
            return "" // есть еще какой-то тип пар, вроде
        }
    }

    public func setData(timeTable: Week?, indexPath: IndexPath) {
        self.room.text = timeTable?.days[indexPath.section].lessons[indexPath.item].room
        self.lessonType.text =  getLessonType(abbr: timeTable?.days[indexPath.section]
                                                            .lessons[indexPath.item].lessonType)
        self.teacher.text = timeTable?.days[indexPath.section].lessons[indexPath.item].teacher
        self.groups.text = timeTable?.days[indexPath.section]
            .lessons[indexPath.item].groups.joined(separator: ", ")
        self.subjectName.text = timeTable?.days[indexPath.section].lessons[indexPath.item].title
        self.building.text = timeTable?.days[indexPath.section].lessons[indexPath.item].building
    }

}
