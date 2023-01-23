//
//  AddLessonView.swift
//  GuapTimeTable
//
//  Created by Denis on 23.01.2023.
//

import Foundation
import UIKit
class AddLessonView: UIView {
    private weak var delegate: UIViewController?
    private let weekTypes = ["Красная", "Синяя", "Универсальная"]
    private let buildings = ["БМ", "Гастелло", "Типанова", "Удаленка"]
    private let lessonTypes = ["Лекция", "Практика", "Лабораторная", "Курсовая", "Другое"]
    private let lessonNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private let weekDays = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]

    // TODO: Возможно, лучшей идеей будет убрать лейблы, и вписывать название ячейки прямо в Field
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

    private var lessonStartTime: UILabel = {
        let label = UILabel()
        label.text = "Время начала"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .init(red: 0.7, green: 0.4, blue: 0.3, alpha: 0.5)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    private var lessonEndTime: UILabel = {
        let label = UILabel()
        label.text = "Время окончания"
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

    private var buildingField: LessonTextFieldView = {
        let field = LessonTextFieldView()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
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

    private var subjectTypeField: LessonTextFieldView = {
        let field = LessonTextFieldView()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private var dayField: LessonTextFieldView = {
        let field = LessonTextFieldView()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private var subjectNumberField: LessonTextFieldView = {
        let field = LessonTextFieldView()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private var weekTypeField: LessonTextFieldView = {
        let field = LessonTextFieldView()
        field.text = "Нет"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.1, green: 0.9, blue: 0.7, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private var lessonStartField: UITextField = {
        let field = UITextField()
        field.text = "9:30"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.2, green: 0.96, blue: 0.3, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private var lessonEndField: UITextField = {
        let field = UITextField()
        field.text = "12:00"
        field.textAlignment = .center
        field.backgroundColor = .init(red: 0.3, green: 0.4, blue: 0.2, alpha: 0.5)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame

        addSubviewsToView()
        applyConstraints()
    }

    convenience init(frame: CGRect, parent: UIViewController) {
        self.init(frame: frame)
        self.frame = frame
        self.delegate = parent
        addSubviewsToView()
        applyConstraints()
        setDelegates()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviewsToView() {
        self.addSubview(subjectTitle)
        self.addSubview(teacherTitle)
        self.addSubview(buildingTitle)
        self.addSubview(roomTitle)
        self.addSubview(groupTitle)
        self.addSubview(subjectTypeTitle)
        self.addSubview(dayTitle)
        self.addSubview(weekTypeTitle)
        self.addSubview(subjectNumberTitle)
        self.addSubview(lessonStartTime)
        self.addSubview(lessonEndTime)

        self.addSubview(subjectField)
        self.addSubview(teacherField)
        self.addSubview(buildingField)
        self.addSubview(roomField)
        self.addSubview(groupField)
        self.addSubview(subjectTypeField)
        self.addSubview(dayField)
        self.addSubview(weekTypeField)
        self.addSubview(subjectNumberField)
        self.addSubview(lessonStartField)
        self.addSubview(lessonEndField)
    }

    func setDelegates() {
        dayField.delegate = delegate as? UITextFieldDelegate
        buildingField.delegate = delegate as? UITextFieldDelegate
        weekTypeField.delegate = delegate as? UITextFieldDelegate
        subjectTypeField.delegate = delegate as? UITextFieldDelegate
        subjectNumberField.delegate = delegate as? UITextFieldDelegate

        self.weekTypeField.associatedValue = weekTypes
        self.subjectTypeField.associatedValue = lessonTypes
        self.dayField.associatedValue = weekDays
        self.subjectNumberField.associatedValue = lessonNumbers
        self.buildingField.associatedValue = buildings
    }

    func applyConstraints() {
        let verticalTitleConstraints = [
            subjectTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            teacherTitle.topAnchor.constraint(equalTo: subjectTitle.bottomAnchor, constant: 10),
            buildingTitle.topAnchor.constraint(equalTo: teacherTitle.bottomAnchor, constant: 10),
            roomTitle.topAnchor.constraint(equalTo: buildingTitle.bottomAnchor, constant: 10),
            groupTitle.topAnchor.constraint(equalTo: roomTitle.bottomAnchor, constant: 10),
            subjectTypeTitle.topAnchor.constraint(equalTo: groupTitle.bottomAnchor, constant: 10),
            dayTitle.topAnchor.constraint(equalTo: subjectTypeTitle.bottomAnchor, constant: 10),
            subjectNumberTitle.topAnchor.constraint(equalTo: dayTitle.bottomAnchor, constant: 10),
            weekTypeTitle.topAnchor.constraint(equalTo: subjectNumberTitle.bottomAnchor, constant: 10),
            lessonStartTime.topAnchor.constraint(equalTo: weekTypeTitle.bottomAnchor, constant: 10),
            lessonEndTime.topAnchor.constraint(equalTo: lessonStartTime.bottomAnchor, constant: 10)
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
            weekTypeField.centerYAnchor.constraint(equalTo: weekTypeTitle.centerYAnchor, constant: 0),
            lessonStartField.centerYAnchor.constraint(equalTo: lessonStartTime.centerYAnchor, constant: 0),
            lessonEndField.centerYAnchor.constraint(equalTo: lessonEndTime.centerYAnchor, constant: 0)
        ]

        let horizontalTitleConstraints = [
            subjectTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            teacherTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            buildingTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            roomTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            groupTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            subjectTypeTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            dayTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            subjectNumberTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            weekTypeTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            lessonStartTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            lessonEndTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ]

        let margin: CGFloat = 0
        let horizontalFieldConstraints = [
            subjectField.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: margin),
            teacherField.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: margin),
            buildingField.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: margin),
            roomField.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: margin),
            groupField.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: margin),
            subjectTypeField.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: margin),
            dayField.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: margin),
            subjectNumberField.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: margin),
            weekTypeField.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: margin),
            lessonStartField.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: margin),
            lessonEndField.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: margin),

            subjectField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            teacherField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            buildingField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            roomField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            groupField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            subjectTypeField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            dayField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            subjectNumberField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            weekTypeField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            lessonStartField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            lessonEndField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ]

        NSLayoutConstraint.activate(verticalTitleConstraints)
        NSLayoutConstraint.activate(horizontalTitleConstraints)
        NSLayoutConstraint.activate(verticalFieldConstraints)
        NSLayoutConstraint.activate(horizontalFieldConstraints)
    }
}
