//
//  LessonPickerView.swift
//  GuapTimeTable
//
//  Created by Denis on 19.01.2023.
//

import Foundation
import UIKit

// кастомный пикер. Нужен для того, чтобы использовать один пикер на все поля ввода. Хранит данные в поле data для их отображения при вызове пикера
// ссылается на текстфилд чтобы обновить его текст при подтверждении выбора
class LessonPickerView: UIPickerView {
    public var data: [String]
    public weak var textfield: LessonTextFieldView?
    init(data: [String], frame: CGRect) {
        self.data = data
        super.init(frame: frame)

    }

    convenience init(data: [String]) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.data = data
    }

    override init(frame: CGRect) {
        self.data = ["ОШИБКА!"]
        Logger.log(type: .warning, message: "Использован инициализатор без установки значения")
        super.init(frame: frame)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
