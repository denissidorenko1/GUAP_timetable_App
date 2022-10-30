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
    let id: String?
    let group: String?
}

struct Room {
    let id: String
    let room: String
}

struct Teacher {
    let id: String
    let name: String
}

struct Building {
    let id: String
    let addres: String
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
