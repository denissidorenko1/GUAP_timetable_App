//
//  SettingsViewController.swift
//  Test
//
//  Created by Denis on 10.10.2022.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    private var dataArray: [Group] = []
    private var groupSettingsData: Group?
    private var picker = UIPickerView()
    private var groupToSave: Group?
    private let generator = UINotificationFeedbackGenerator()
    weak var responsiveTableView: TimeTableViewController?

    private var groupSettingText: UILabel = {
        let label = UILabel()
        label.text = "Номер группы:"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    private var groupSettingGroup: UITextField = {
        let field = UITextField()
        field.text = SettingsStorage.shared.getStoredGroup().group ?? "-нет-"
        field.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return field
    }()

    override func loadView() {
        super.loadView()
        self.view.addSubview(groupSettingText)
        self.view.addSubview(groupSettingGroup)

        picker.dataSource = self
        picker.delegate = self

        RequestModule.shared.getSelectData { [weak self] data in
            self?.dataArray = data.groups.groupList
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.title = "Настройки"
        setupPicker()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }

    func setConstraints() {
        groupSettingText.translatesAutoresizingMaskIntoConstraints = false
        groupSettingGroup.translatesAutoresizingMaskIntoConstraints = false

        let horizontalConstraints = [
            groupSettingText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            groupSettingText.trailingAnchor.constraint(equalTo: groupSettingGroup.leadingAnchor, constant: -110),
            groupSettingGroup.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ]
        groupSettingText.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        groupSettingGroup.setContentHuggingPriority(.defaultLow, for: .horizontal)

        let verticalConstraints = [
            // Приемлимо ли делать force unwrapping навконтроллера, если это происходит во viewDidLayoutSubviews,
            // и навконтроллер не является nil?
            groupSettingText.topAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!, constant: 10),
            groupSettingGroup.centerYAnchor.constraint(equalTo: groupSettingText.centerYAnchor, constant: 0)
        ]

        NSLayoutConstraint.activate([horizontalConstraints, verticalConstraints].flatMap {$0})
    }

    func setupPicker() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        groupSettingGroup.inputView = picker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(self.done))
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(self.cancel))
        toolBar.setItems([cancelButton, .flexibleSpace(), saveButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        groupSettingGroup.inputAccessoryView = toolBar
    }

    @objc func done() {
        generator.prepare()
        SettingsStorage.shared.saveGroupToStorage(group: groupToSave)
        self.responsiveTableView?.getTimeTable()
        view.endEditing(true)
        generator.notificationOccurred(.success)
    }

    @objc func cancel() {
        generator.prepare()
        view.endEditing(true)
        generator.notificationOccurred(.error)
        groupSettingGroup.text = SettingsStorage.shared.getStoredGroup().group ?? "-нет-"
    }
}

// MARK: - PickerViewDelegate, PickerViewDataSource
extension SettingsViewController: UIPickerViewDelegate {
    /*
     The delegate of a UIPickerView object must adopt this protocol and implement at least some of
     its methods to provide the picker view with the data it needs to construct itself.

     The delegate implements the required methods of this protocol to return height, width, row title,
     and the view content for the rows in each component.
     It must also provide the content for each component’s row, either as a string or a view.
     The delegate implements other optional methods to respond to new selections or deselections of component rows.
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = dataArray[row].group
        return row
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        groupSettingGroup.text = dataArray[row].group
        groupToSave = dataArray[row]
    }
}

extension SettingsViewController: UIPickerViewDataSource {
    /*
     The data source provides the picker view with the number of components,
     and the number of rows in each component, for displaying the picker view data.
     Both methods in this protocol are required.
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
