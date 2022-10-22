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
    
    private func setFrames() {
        currentDayLabel.frame = CGRect(x: 0, y: self.center.y/2, width: 190, height: 20)
        currentWeekLabel.frame = CGRect(x: 190, y: self.center.y/2, width: 150, height: 20)
        
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
        setFrames()
        setFonts()
        self.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 20, height: 50) // дважды устанавливаем frame, сомнительно
        
        
    }
}
