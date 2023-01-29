//
//  AddLessonViewController.swift
//  GuapTimeTable
//
//  Created by Denis on 19.01.2023.
//

import Foundation
import UIKit

class AddLessonViewController: UIViewController {
    weak private var delegate: UpdateableFromFireStore?

    private var picker: LessonPickerView = {
        let picker = LessonPickerView(data: [], frame: CGRect(x: 1000, y: 0, width: 0, height: 0))
        return picker
    }()

    private var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        return toolBar
    }()

    private var lessonView: AddLessonView?

    convenience init(sender: UpdateableFromFireStore) {
        self.init()
        self.delegate = sender
    }

    override func loadView() {
        super.loadView()
        picker.delegate = self
        picker.dataSource = self
        configureToolbar()
        let barButton = UIBarButtonItem(title: "Добавить", style: .done, target: self, action: #selector(saveData))
        navigationItem.rightBarButtonItem = barButton
        setStyles()
        addSubviewsToView()
    }

    @objc func saveData() {
        let lesson = lessonView!.retrieveFieldValues()
        FirebaseApi.shared.addLesson(lesson: lesson)
        self.delegate?.updateFireStoreAfterChange()
        navigationController?.popViewController(animated: true)

    }

    @objc func hidePicker() {
        view.endEditing(true)
    }

    private func setStyles() {
        view.backgroundColor = .systemPink
        self.title = "Добавить новую пару"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem?.tintColor = .label
    }

    private func setLessonView() -> AddLessonView? {
        // FIXME: переписать это фрагмент
        self.lessonView = AddLessonView(frame: CGRect(x: 0, y: navigationController!.navigationBar.frame.height+50,
            width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), parent: self)
        return self.lessonView
    }

    private func addSubviewsToView() {
        // FIXME: исправить кривую работу при повороте экрана
        view.addSubview(setLessonView()!)
        view.addSubview(picker)
    }

    private func configureToolbar() {
        self.toolBar.sizeToFit()
        let saveButton = UIBarButtonItem(title: "Готово",
            style: .plain, target: self, action: #selector(self.hidePicker))
        self.toolBar.setItems([.flexibleSpace(), saveButton], animated: true)
        self.toolBar.isUserInteractionEnabled = true
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
        guard let field = textField as? LessonTextFieldView else {return}
        field.inputView = picker
        field.inputAccessoryView = toolBar
        // заполняем пикер данными
        picker.data = field.associatedValue
        // связываем текстфилд с пикером, чтобы при изменении выбора пикера можно было менять текст в поле
        picker.textfield = field
        // после смены picker.data данные в ячейках остаются старые, поэтому требуется перезагрузить их
        picker.reloadAllComponents()
        picker.selectRow(0, inComponent: 0, animated: true) // перематываем пикер на первую строку данных
    }
}
