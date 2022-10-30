//
//  Models.swift
//  Test
//
//  Created by Denis on 07.10.2022.
//

import Foundation

struct Constants {
    static let baseURL = "https://guap.ru/rasp/"
}

struct Group {
    var id: String
    var group: String
}

struct Room {
    var id: String
    var room: String
}

struct Teacher {
    var id: String
    var name: String
}

struct Building {
    var id: String
    var addres: String
}

struct Buildings {
    var buildingList: [Building] = []
}

struct Teachers {
    var teacherList: [Teacher] = []
}

struct Rooms {
    var roomList: [Room] = []
}

struct Groups {
    var groupList: [Group] = []
}

class SelectData {
    let groups: Groups
    let rooms: Rooms
    let teachers: Teachers
    let buildings: Buildings

    init(groups: Groups, rooms: Rooms, teachers: Teachers, buildings: Buildings) {
        self.groups = groups
        self.rooms = rooms
        self.teachers = teachers
        self.buildings = buildings
    }
}
