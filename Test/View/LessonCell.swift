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
        addDataToLabels()
        setFontsOfLabels()
        setFramesOfLabels()
        self.backgroundColor = .clear
    }
    
}
