//
//  LessonModalView.swift
//  Test
//
//  Created by Denis on 22.10.2022.
//

import Foundation
import UIKit

// переписать на UIPresentationController, чтобы можно было показывать модальное окно только наполовину
class LessonModalView: UIViewController {
    
    let headerTitle = UILabel()
    var lessonType = UILabel()
    var subjectName = UILabel()
    var room = UILabel()
    var teacher = UILabel()
    var groups = UILabel()
    
    var building = UILabel()
    
    func setLabelText(){
        headerTitle.text = "Подробное расписание"
        lessonType.text = "Лабораторная работа"
        subjectName.text = "Прикладная математика"
        room.text = "52-30"
        teacher.text = "Богданов Д.В. - доцент, канд. техн. наук, доцент"
        groups.text = "4230M, 4231M, 4232M"
        building.text = "Б.Морская 67"
        
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        lessonType.translatesAutoresizingMaskIntoConstraints = false
        subjectName.translatesAutoresizingMaskIntoConstraints = false
        room.translatesAutoresizingMaskIntoConstraints = false
        teacher.translatesAutoresizingMaskIntoConstraints = false
        groups.translatesAutoresizingMaskIntoConstraints = false
        building.translatesAutoresizingMaskIntoConstraints = false
        
        
        headerTitle.backgroundColor = .red
        lessonType.backgroundColor = .blue
        subjectName.backgroundColor = .systemPink
        room.backgroundColor = .cyan
        teacher.backgroundColor = .brown
        groups.backgroundColor = .green
        building.backgroundColor = .purple
    }
    
    
    func configureConstraints(){
        
        let headerConstraints = [
            headerTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            headerTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            headerTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ]
        
        let subjectConstraints = [
            subjectName.topAnchor.constraint(equalTo: headerTitle.bottomAnchor, constant: 20),
            subjectName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            subjectName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20)
        ]
        
        let teacherConstraints = [
            teacher.topAnchor.constraint(equalTo: subjectName.bottomAnchor, constant: 20),
            teacher.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            teacher.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ]
        // область здания занимает много места, попробовать поменять приоритеты
        let buildingConstraints = [
            building.topAnchor.constraint(equalTo: teacher.bottomAnchor, constant: 20),
            building.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        ]
        
        let roomConstraints = [
            room.leftAnchor.constraint(equalTo: building.rightAnchor, constant: 10),
            room.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            room.centerYAnchor.constraint(equalTo: building.centerYAnchor),
        ]
        
        let groupConstraints = [
            groups.topAnchor.constraint(equalTo: building.bottomAnchor, constant: 20),
            groups.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            groups.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ]
        
        let lessonTypeConstraints = [
            lessonType.topAnchor.constraint(equalTo: groups.bottomAnchor, constant: 20),
            lessonType.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            lessonType.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
        ]
        
        NSLayoutConstraint.activate(headerConstraints)
        NSLayoutConstraint.activate(subjectConstraints)
        NSLayoutConstraint.activate(teacherConstraints)
        NSLayoutConstraint.activate(buildingConstraints)
        NSLayoutConstraint.activate(roomConstraints)
        NSLayoutConstraint.activate(groupConstraints)
        NSLayoutConstraint.activate(lessonTypeConstraints)
    }
    
    func addLabelsToView(){
        view.addSubview(headerTitle)
        view.addSubview(lessonType)
        view.addSubview(subjectName)
        view.addSubview(room)
        view.addSubview(teacher)
        view.addSubview(groups)
        view.addSubview(building)
    }
    
    func setLabelFonts(){
        headerTitle.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
    }
    
    override func loadView() {
        super.loadView()
        setLabelText()
        setLabelFonts()
        addLabelsToView()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureConstraints()
    }
}

