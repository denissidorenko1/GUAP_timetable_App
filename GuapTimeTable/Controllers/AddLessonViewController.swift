//
//  AddLessonViewController.swift
//  GuapTimeTable
//
//  Created by Denis on 19.01.2023.
//

import Foundation
import UIKit

// TODO: разбить на слои контроллера и вью
class AddLessonViewController: UIViewController {
    private let weekTypes = ["Красная", "Синяя", "Универсальная"]
    private let buildings = ["БМ", "Гастелло", "Типанова", "Удаленка"]
    private let lessonTypes = ["Лекция", "Практика", "Лабораторная", "Курсовая", "Другое"]
    private let lessonNumbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private let weekDays = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]

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

    private var picker: LessonPickerView = {
        let picker = LessonPickerView(data: [], frame: CGRect(x: 1000, y: 0, width: 0, height: 0))
        return picker
    }()

    private var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        return toolBar
    }()

    private func configureToolbar() {
        self.toolBar.sizeToFit()
        let saveButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(self.hidePicker))
        self.toolBar.setItems([.flexibleSpace(), saveButton], animated: true)
        self.toolBar.isUserInteractionEnabled = true
    }

    override func loadView() {
        super.loadView()
        picker.delegate = self
        picker.dataSource = self

        dayField.delegate = self
        buildingField.delegate = self
        weekTypeField.delegate = self
        subjectTypeField.delegate = self
        subjectNumberField.delegate = self

        self.weekTypeField.associatedValue = weekTypes
        self.subjectTypeField.associatedValue = lessonTypes
        self.dayField.associatedValue = weekDays
        self.subjectNumberField.associatedValue = lessonNumbers
        self.buildingField.associatedValue = buildings

        configureToolbar()

        view.backgroundColor = .systemPink
        self.title = "Добавить новую пару"
        self.weekTypeField.text = self.weekTypes.first
        self.subjectTypeField.text = self.lessonTypes.first
        self.dayField.text = self.weekDays.first
        self.subjectNumberField.text = lessonNumbers.first
        self.buildingField.text = self.buildings.first
        navigationController?.navigationBar.prefersLargeTitles = true
        let barButton = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(saveData))
        navigationItem.rightBarButtonItem = barButton
        navigationItem.rightBarButtonItem?.tintColor = .label
        addSubviewsToView()
    }

    @objc func saveData() {
        // по нажатию отправлять данные на сервер
    }

    @objc func hidePicker() {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyConstraints()
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
        view.addSubview(lessonStartTime)
        view.addSubview(lessonEndTime)

        view.addSubview(subjectField)
        view.addSubview(teacherField)
        view.addSubview(buildingField)
        view.addSubview(roomField)
        view.addSubview(groupField)
        view.addSubview(subjectTypeField)
        view.addSubview(dayField)
        view.addSubview(weekTypeField)
        view.addSubview(subjectNumberField)
        view.addSubview(lessonStartField)
        view.addSubview(lessonEndField)
        view.addSubview(picker)
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
            subjectTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            teacherTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buildingTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            roomTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            groupTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            subjectTypeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            dayTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            subjectNumberTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            weekTypeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lessonStartTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lessonEndTime.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
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
            lessonStartField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: margin),
            lessonEndField.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: margin),

            subjectField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            teacherField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buildingField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            roomField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            groupField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            subjectTypeField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dayField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            subjectNumberField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            weekTypeField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            lessonStartField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            lessonEndField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ]

        NSLayoutConstraint.activate(verticalTitleConstraints)
        NSLayoutConstraint.activate(horizontalTitleConstraints)
        NSLayoutConstraint.activate(verticalFieldConstraints)
        NSLayoutConstraint.activate(horizontalFieldConstraints)
    }
}

// TODO: убрать логику подальше
extension AddLessonViewController: UIPickerViewDelegate {
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return picker.data[row]

    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        picker.textfield?.text = picker.data[row]
    }
}

extension AddLessonViewController: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return picker.data.count
    }

}

extension AddLessonViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let field = textField as? LessonTextFieldView else {return} // проверяем что поле является классом LessonTextFieldView
        field.inputView = picker
        field.inputAccessoryView = toolBar

        picker.data = field.associatedValue // заполняем пикер данными
        picker.textfield = field // связываем текстфилд с пикером, чтобы при изменении выбора пикера можно было менять текст в поле
        picker.reloadAllComponents() // после смены picker.data данные в ячейках остаются старые, поэтому требуется перезагрузить их
        picker.selectRow(0, inComponent: 0, animated: true) // перематываем пикер на первую строку данных
    }
}
