//
//  TableHeaderView.swift
//  Test
//
//  Created by Denis on 22.10.2022.
//

import Foundation
import UIKit

class TableHeaderView: UIView { // переименовать
    
    let currentWeekLabel = UILabel()
    let currentDayLabel = UILabel()
    var currentWeekType: WeekType?
    
    
    private func setLabelText() {
        currentDayLabel.text = "Сегодня \(getCurrentDay()),"
        currentWeekLabel.text = currentWeekType == .blue ? "синяя неделя" : "красная неделя"
        currentWeekLabel.textColor = currentWeekType == .blue ? .blue : .red
    }
    
    private func setConstraints(){
        currentWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        currentDayLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            // вертикаль
            currentDayLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            currentWeekLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            // горизонталь
            currentDayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            currentDayLabel.trailingAnchor.constraint(equalTo: currentWeekLabel.leadingAnchor, constant: -10),
            currentWeekLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        constraints.last!.priority = UILayoutPriority(5)
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setFonts() {
        currentDayLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        currentWeekLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
    }
    
    // получаем текущий день недели из календаря
    private func getCurrentDay() -> String{
        // числа 1-7 соответствуют дню недели
        switch Calendar.current.component(.weekday, from: Date()) {
        case 1:
            return "воскресенье"
        case 2:
            return "понедельник"
        case 3:
            return "вторник"
        case 4:
            return "среда"
        case 5:
            return "четверг"
        case 6:
            return "пятница"
        case 7:
            return "суббота"
        default:
            fatalError("Выход значения за пределы допустимого диапазона")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(currentDayLabel)
        self.addSubview(currentWeekLabel)
        setLabelText()
        setFonts()
        setConstraints()
        self.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 20, height: 50) // дважды устанавливаем frame, сомнительно
        
        
    }
}
