//
//  LessonCell.swift
//  Test
//
//  Created by Denis on 13.10.2022.
//

import Foundation
import UIKit

class LessonCell: UITableViewCell{
    var startTime = UILabel()
    var endTime = UILabel()
    var lessonNumber = UILabel()
    var lessonType = UILabel()
    var subjectName = UILabel()
    var room = UILabel()
    var teacher = UILabel()
    
    static let identifier = "LessonCell"
    
    func lol() {
        startTime.text = "12:10"
        endTime.text = "13:40"
        lessonNumber.text = "2"
        lessonType.text = "Лекция"
        subjectName.text = "Системный анализ"
        room.text = "32-08"
        teacher.text = "Колесникова Светлана Васильевна"
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(startTime)
        contentView.addSubview(endTime)
        contentView.addSubview(lessonNumber)
        contentView.addSubview(lessonType)
        contentView.addSubview(subjectName)
        contentView.addSubview(room)
        contentView.addSubview(teacher)
        contentView.backgroundColor = .purple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
