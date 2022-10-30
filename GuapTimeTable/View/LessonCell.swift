//
//  LessonCellView.swift
//  Test
//
//  Created by Denis on 13.10.2022.
//

import Foundation
import UIKit

final class LessonCell: UITableViewCell {
    private let startTime = UILabel()
    private let endTime = UILabel()
    private let lessonNumber = UILabel()
    private let lessonType = UILabel()
    private let subjectName = UILabel()
    private let room = UILabel()
    private let teacher = UILabel()
    private let groups = UILabel()

    static let identifier = "LessonCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addLabelsToView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setViewAppearance()
        setFontsOfLabels()
        setConstraints()
        self.backgroundColor = .clear
    }

    private func setViewAppearance() {
        contentView.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 20, height: 70)
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.35
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.backgroundColor = .darkGray
    }

    private func addLabelsToView() {
        contentView.addSubview(startTime)
        contentView.addSubview(endTime)
        contentView.addSubview(lessonNumber)
        contentView.addSubview(lessonType)
        contentView.addSubview(subjectName)
        contentView.addSubview(room)
        contentView.addSubview(teacher)
        contentView.addSubview(groups)
        contentView.layer.addSublayer(drawLine())
    }

    private func setFontsOfLabels() {
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

    private func getLessonType(abbr: String?) -> String {
        switch abbr {
        case "ЛР":
            return "Лабораторная работа"
        case "ПР":
            return "Практическая работа"
        case "Л":
            return "Лекция"
        case "КП":
            return "Курсовой проект"
        case "КР":
            return "Курсовая работа"
        default:
            return "" // есть еще какой-то тип пар, вроде
        }
    }

    public func setData(timeTable: Week?, indexPath: IndexPath) {
        self.room.text = timeTable?.days[indexPath.section].lessons[indexPath.item].room
        self.lessonNumber.text = timeTable?.days[indexPath.section].lessons[indexPath.item].lessonNumber
        self.lessonType.text = getLessonType(abbr: timeTable?
                                                .days[indexPath.section].lessons[indexPath.item].lessonType)
        self.teacher.text = timeTable?.days[indexPath.section].lessons[indexPath.item].teacher
        self.groups.text = timeTable?.days[indexPath.section].lessons[indexPath.item].groups.joined(separator: ", ")
        self.subjectName.text = timeTable?.days[indexPath.section].lessons[indexPath.item].title
        self.endTime.text = timeTable?.days[indexPath.section].lessons[indexPath.item].endTime
        self.startTime.text = timeTable?.days[indexPath.section].lessons[indexPath.item].startTime
        switch timeTable?.days[indexPath.section].lessons[indexPath.item].weekType {
        case .red:
            self.lessonNumber.textColor = .red
        case .blue:
            self.lessonNumber.textColor = .blue
        default:
            // ничего не делать, неделя универсальная
            break
        }
    }

    private func drawLine() -> CAShapeLayer {
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

    private func setConstraints() {
        startTime.translatesAutoresizingMaskIntoConstraints = false
        endTime.translatesAutoresizingMaskIntoConstraints = false
        lessonNumber.translatesAutoresizingMaskIntoConstraints = false
        lessonType.translatesAutoresizingMaskIntoConstraints = false
        subjectName.translatesAutoresizingMaskIntoConstraints = false
        room.translatesAutoresizingMaskIntoConstraints = false
        teacher.translatesAutoresizingMaskIntoConstraints = false
        groups.translatesAutoresizingMaskIntoConstraints = false

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
            lessonNumber.bottomAnchor.constraint(equalTo: endTime.topAnchor, constant: 0)
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
            room.topAnchor.constraint(equalTo: subjectName.bottomAnchor, constant: 0)
        ]
        let groupConstraints = [
            groups.leadingAnchor.constraint(equalTo: room.trailingAnchor, constant: 10),
            groups.topAnchor.constraint(equalTo: subjectName.bottomAnchor, constant: 0),
            groups.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ]
        room.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        groups.setContentHuggingPriority(.defaultLow, for: .horizontal)

        let teacherConstraints = [
            teacher.topAnchor.constraint(equalTo: groups.bottomAnchor),
            teacher.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 75),
            teacher.topAnchor.constraint(equalTo: room.bottomAnchor, constant: 0),
            teacher.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            teacher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ]

        NSLayoutConstraint.activate([startTimeConstraints, endTimeConstraints, lessonNumberConstraints,
                                     lessonTypeConstraints, subjectNameConstraints, roomConstraints,
                                     groupConstraints, teacherConstraints].flatMap {$0})
    }

}
