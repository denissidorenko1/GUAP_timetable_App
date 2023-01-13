//
//  AddNewLessonViewController.swift
//  GuapTimeTable
//
//  Created by Denis on 01.11.2022.
//

import Foundation
import UIKit
import SwiftSoup

protocol SaveableToCoreData {
    func saveToPersistentStorage(_ initialModel: LessonCoreData?, _ newModel: LessonCoreData)
}

class ChangeLessonViewController: UIViewController {
    private let weekTypes = ["Красная", "Синяя", "Универсальная"]
    private let buildings = ["БМ", "Гастелло", "Типанова", "Удаленка"]
    private let lessonTypes = ["Лекция", "Практика", "Лабораторная", "Курсовая", "Другое"]
    private let lessonNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    private let weekDays = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]

    public var saveDelegate: SaveableToCoreData?
    private var isAddingNew: Bool = false
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    convenience init(isAddingNew: Bool) {
        self.init()
        self.isAddingNew = isAddingNew
    }

    private var subjectTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Название \nпредмета"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .init(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private var teacherTitle: UILabel = {
        let label = UILabel()
        label.text = "Преподаватель"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .init(red: 0.19, green: 0.29, blue: 0.39, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private var buildingTitle: UILabel = {
        let label = UILabel()
        label.text = "Корпус"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .init(red: 0.13, green: 0.4, blue: 0.9, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private var roomTitle: UILabel = {
        let label = UILabel()
        label.text = "Аудитория"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .init(red: 0.7, green: 0.1, blue: 0.4, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private var groupTitle: UILabel = {
        let label = UILabel()
        label.text = "Группы"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .init(red: 0.8, green: 0.2, blue: 0.7, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private var subjectTypeTitle: UILabel = {
        let label = UILabel()
        label.text = "Тип пары"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .init(red: 0.5, green: 0.6, blue: 0.2, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private var dayTitle: UILabel = {
        let label = UILabel()
        label.text = "День недели"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private var subjectNumberTitle: UILabel = {
        let label = UILabel()
        label.text = "Номер пары"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .init(red: 0.4, green: 0.2, blue: 0.9, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private var weekTypeTitle: UILabel = {
        let label = UILabel()
        label.text = "Тип недели"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .init(red: 0.7, green: 0.4, blue: 0.3, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private var subjectField: UITextField = {
        let field = UITextField()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private var teacherField: UITextField = {
        let field = UITextField()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private var buildingField: UITextField = {
        let field = UITextField()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        let picker = UIPickerView()
//        picker.delegate =
//        field.inputView = picker
        return field
    }()

    private var roomField: UITextField = {
        let field = UITextField()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private var groupField: UITextField = {
        let field = UITextField()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private var subjectTypeField: UITextField = {
        let field = UITextField()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private var dayField: UITextField = {
        let field = UITextField()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private var subjectNumberField: UITextField = {
        let field = UITextField()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private var weekTypeField: UITextField = {
        let field = UITextField()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .systemPink
        self.title = "Добавить новую пару"
        self.weekTypeField.text = self.weekTypes.first
        self.subjectTypeField.text = self.lessonTypes.first
        self.dayField.text = self.weekDays.first
        self.subjectNumberField.text = String(self.lessonNumbers.first ?? 1)
        self.buildingField.text = self.buildings.first
        navigationController?.navigationBar.prefersLargeTitles = true
        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveData))
        barButton.tintColor = .blue
        navigationItem.rightBarButtonItem = barButton
        navigationItem.rightBarButtonItem?.tintColor = .label
        addSubviewsToView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
    }

    @objc func saveData() {
//        print("saveData button pressed")
//        print(self.weekTypeField.text)
//        if isAddingNew {
//            var newModel = LessonCoreData(context: self.context!)
//            newModel.weekType = self.weekTypeField.text
//
//            saveDelegate?.saveToPersistentStorage(nil, newModel)
//        }
    }

    func fillCoreData(data: LessonCoreData) {
        self.subjectField.text = data.subjectTitle
        self.teacherField.text = data.teacher
        self.buildingField.text = data.building
        self.roomField.text = data.room
        self.groupField.text = data.groups?.joined(separator: ", ")
        self.subjectTypeField.text = data.lessonType
        self.dayField.text = data.weekDay
        self.subjectNumberField.text = String(data.lessonNumber)
        self.weekTypeField.text = String(data.weekType)
    }

    func addSubviewsToView() {
        view.addSubview(subjectTitle)
        view.addSubview(teacherTitle)
        view.addSubview(buildingTitle)
        view.addSubview(roomTitle)
        view.addSubview(groupTitle)
        view.addSubview(subjectTypeTitle)
        view.addSubview(dayTitle)
        view.addSubview(weekTypeTitle)
        view.addSubview(subjectNumberTitle)

        view.addSubview(subjectField)
        view.addSubview(teacherField)
        view.addSubview(buildingField)
        view.addSubview(roomField)
        view.addSubview(groupField)
        view.addSubview(subjectTypeField)
        view.addSubview(dayField)
        view.addSubview(weekTypeField)
        view.addSubview(subjectNumberField)
    }

    func applyConstraints() {
        let verticalTitleConstraints = [
            subjectTitle.topAnchor.constraint(equalTo: navigationController?
                                                .navigationBar.bottomAnchor ?? view.topAnchor, constant: 10),
            teacherTitle.topAnchor.constraint(equalTo: subjectTitle.bottomAnchor, constant: 10),
            buildingTitle.topAnchor.constraint(equalTo: teacherTitle.bottomAnchor, constant: 10),
            roomTitle.topAnchor.constraint(equalTo: buildingTitle.bottomAnchor, constant: 10),
            groupTitle.topAnchor.constraint(equalTo: roomTitle.bottomAnchor, constant: 10),
            subjectTypeTitle.topAnchor.constraint(equalTo: groupTitle.bottomAnchor, constant: 10),
            dayTitle.topAnchor.constraint(equalTo: subjectTypeTitle.bottomAnchor, constant: 10),
            subjectNumberTitle.topAnchor.constraint(equalTo: dayTitle.bottomAnchor, constant: 10),
            weekTypeTitle.topAnchor.constraint(equalTo: subjectNumberTitle.bottomAnchor, constant: 10)
        ]

        let verticalFieldConstraints = [
            subjectField.centerYAnchor.constraint(equalTo: subjectTitle.centerYAnchor, constant: 0),
            teacherField.centerYAnchor.constraint(equalTo: teacherTitle.centerYAnchor, constant: 0),
            buildingField.centerYAnchor.constraint(equalTo: buildingTitle.centerYAnchor, constant: 0),
            roomField.centerYAnchor.constraint(equalTo: roomTitle.centerYAnchor, constant: 0),
            groupField.centerYAnchor.constraint(equalTo: groupTitle.centerYAnchor, constant: 0),
            subjectTypeField.centerYAnchor.constraint(equalTo: subjectTypeTitle.centerYAnchor, constant: 0),
            dayField.centerYAnchor.constraint(equalTo: dayTitle.centerYAnchor, constant: 0),
            subjectNumberField.centerYAnchor.constraint(equalTo: subjectNumberTitle.centerYAnchor, constant: 0),
            weekTypeField.centerYAnchor.constraint(equalTo: weekTypeTitle.centerYAnchor, constant: 0)
        ]

        let horizontalTitleConstraints = [
            subjectTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            teacherTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buildingTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            roomTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            groupTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            subjectTypeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dayTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            subjectNumberTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            weekTypeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ]

        let margin: CGFloat = 0
        let horizontalFieldConstraints = [
            subjectField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: margin),
            teacherField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: margin),
            buildingField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: margin),
            roomField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: margin),
            groupField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: margin),
            subjectTypeField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: margin),
            dayField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: margin),
            subjectNumberField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: margin),
            weekTypeField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: margin),

            subjectField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            teacherField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buildingField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            roomField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            groupField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            subjectTypeField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dayField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            subjectNumberField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weekTypeField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]

        NSLayoutConstraint.activate(verticalTitleConstraints)
        NSLayoutConstraint.activate(horizontalTitleConstraints)
        NSLayoutConstraint.activate(verticalFieldConstraints)
        NSLayoutConstraint.activate(horizontalFieldConstraints)
    }
}
