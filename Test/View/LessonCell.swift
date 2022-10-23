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
    var groups = UILabel()
    
    static let identifier = "LessonCell"
    
    func setFontsOfLabels() {
        startTime.font = startTime.font.withSize(16)
        endTime.font = endTime.font.withSize(16)
        lessonNumber.font = lessonNumber.font.withSize(20)
        lessonType.font = lessonType.font.withSize(14)
        subjectName.font = subjectName.font.withSize(16)
        room.font = room.font.withSize(14)
        lessonType.textColor = .orange
        teacher.font = teacher.font.withSize(14)
        groups.font = groups.font.withSize(14)
        
        
        startTime.translatesAutoresizingMaskIntoConstraints = false
        endTime.translatesAutoresizingMaskIntoConstraints = false
        lessonNumber.translatesAutoresizingMaskIntoConstraints = false
        lessonType.translatesAutoresizingMaskIntoConstraints = false
        subjectName.translatesAutoresizingMaskIntoConstraints = false
        room.translatesAutoresizingMaskIntoConstraints = false
        teacher.translatesAutoresizingMaskIntoConstraints = false
        groups.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func drawLine() ->CAShapeLayer{
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 65, y: 8))
        path.addLine(to: CGPoint(x: 65, y: 62))

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.lightGray.cgColor // сделать свой цвет, чтобы при смене темы менялся тоже
        shapeLayer.lineWidth = 3
        shapeLayer.lineCap = .round
        shapeLayer.backgroundColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.systemPink.cgColor
        return shapeLayer
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
        contentView.addSubview(groups)
        contentView.layer.addSublayer(drawLine())
        contentView.backgroundColor = .darkGray
    }
    
    // мб переписать на констрейнты?
    private func setFramesOfLabels(){
        startTime.frame = CGRect(x: 15, y: 5, width: 55, height: 20)
        endTime.frame = CGRect(x: 15, y: 45, width: 55, height: 20)
        lessonNumber.frame = CGRect(x: 30, y: 25, width: 30, height: 20)
        lessonType.frame = CGRect(x: 75, y: 2, width: contentView.frame.width - 80, height: 20)
        subjectName.frame = CGRect(x: 75, y: 18, width: contentView.frame.width - 80, height: 20)
        room.frame = CGRect(x: 75, y: 35, width: 80, height: 20)
        groups.frame = CGRect(x: 135, y: 35, width: 220, height: 20)
        teacher.frame = CGRect(x: 75, y: 50, width: contentView.frame.width - 80, height: 20)
        
    }
    
    private func setConstraints(){
        let startTimeConstraints = [
            startTime.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            startTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            startTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        let endTimeConstraints = [
            endTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            endTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            endTime.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ]
        
        let lessonNumberConstraints = [
            lessonNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            lessonNumber.topAnchor.constraint(equalTo: startTime.bottomAnchor, constant: 0),
            lessonNumber.bottomAnchor.constraint(equalTo: endTime.topAnchor, constant: 0),
        ]
        
        let lessonTypeConstraints = [
            lessonType.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            lessonType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 75),
            lessonType.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ]
        
        let subjectNameConstraints = [
            subjectName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 75),
            subjectName.topAnchor.constraint(equalTo: lessonType.bottomAnchor, constant: 0),
            subjectName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ]
        
        let roomConstraints = [
            room.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 75),
            room.topAnchor.constraint(equalTo: subjectName.bottomAnchor, constant: 0),
        ]
        let groupConstraints = [
            groups.leadingAnchor.constraint(equalTo: room.trailingAnchor, constant: 10),
            groups.topAnchor.constraint(equalTo: subjectName.bottomAnchor, constant: 0),
            // уезжает за ячейку группа, если пара на кафедре вне расписания
            groups.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ]
        groupConstraints[0].priority = UILayoutPriority(700)
        groupConstraints[2].priority = UILayoutPriority(2)
        
        
        let teacherConstraints = [
            teacher.topAnchor.constraint(equalTo: groups.bottomAnchor),
            teacher.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 75),
            teacher.topAnchor.constraint(equalTo: room.bottomAnchor, constant: 0),
            teacher.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            teacher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]
        
        
        NSLayoutConstraint.activate(startTimeConstraints)
        NSLayoutConstraint.activate(endTimeConstraints)
        NSLayoutConstraint.activate(lessonNumberConstraints)
        NSLayoutConstraint.activate(lessonTypeConstraints)
        NSLayoutConstraint.activate(subjectNameConstraints)
        NSLayoutConstraint.activate(roomConstraints)
        NSLayoutConstraint.activate(groupConstraints)
        NSLayoutConstraint.activate(teacherConstraints)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 20, height: 70)
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.35
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        setFontsOfLabels()
//        setFramesOfLabels()
        setConstraints()
        self.backgroundColor = .clear
    }
    
}
