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
    private var groupSettingText = UILabel(frame: CGRect(x: 10, y: 140, width: UIScreen.main.bounds.width - 120, height: 50))
    private var groupSettingGroup = UITextField(frame: CGRect(x: UIScreen.main.bounds.width - 120, y: 140, width: 100, height: 50))
    private var groupSettingsData: Group?
    private var picker = UIPickerView()
    private var GroupToSave: Group?
    
    weak var responsiveTableView: TimeTableViewController?
    
    func setupPicker(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        groupSettingGroup.inputView = picker
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolBar.sizeToFit()
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(self.done))
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(self.cancel))
        toolBar.setItems([cancelButton, .flexibleSpace(),saveButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        groupSettingGroup.inputAccessoryView = toolBar
    }
    
    
    override func loadView() {
        super.loadView()
        groupSettingText.text = "Номер группы:"
        groupSettingGroup.text = SettingsStorage.shared.getStoredGroup().group
        self.view.addSubview(groupSettingText)
        self.view.addSubview(groupSettingGroup)
        
        picker.dataSource = self
        picker.delegate = self
        
        RequestModule.shared.getSelectData(){[weak self] data in
            self?.dataArray = data.groups.groupList
        }
    }
    
    @objc func done() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        SettingsStorage.shared.saveGroupToStorage(group: GroupToSave)
        self.responsiveTableView?.getTimeTable()
        view.endEditing(true)
        generator.notificationOccurred(.success)
    }
    
    @objc func cancel(){
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        view.endEditing(true)
        generator.impactOccurred()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        self.title = "Настройки"
        setupPicker()
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
}


extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = dataArray[row].group
        return row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row,component)
        groupSettingGroup.text = dataArray[row].group
        GroupToSave = dataArray[row]
    }
    
}