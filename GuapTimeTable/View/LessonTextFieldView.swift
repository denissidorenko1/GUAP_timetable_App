//
//  LessonTextFieldView.swift
//  GuapTimeTable
//
//  Created by Denis on 19.01.2023.
//

import Foundation
import UIKit
class LessonTextFieldView: UITextField {
    public var associatedValue: [String]

    init(values: [String], frame: CGRect) {
        self.associatedValue = values
        super.init(frame: frame)

    }

    convenience init(values: [String]) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.associatedValue = values
    }

    override init(frame: CGRect) {
        self.associatedValue = ["ОШИБКА!"]
        Logger.log(type: .warning, message: "Использован инициализатор без установки значения")
        super.init(frame: frame)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
