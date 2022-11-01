//
//  SettingsStorage.swift
//  Test
//
//  Created by Denis on 27.10.2022.
//

import Foundation
class SettingsStorage {
    // Вопрос: можно ли использовать Singleton при работе с UserDefaults, если сам UserDefaults - Singleton?
    // Ведь даже если реализовать данный класс не через Singleton, остается неявная зависимость в виде UserDefaults
    static let shared = SettingsStorage()
    private let defaults = UserDefaults.standard
    private let groupTitle = "SavedGroupTitle"
    private let groupId = "SavedGroupId"

    // препятствуем создание множества экземпляров класса, сделав инициализатор приватным
    // теперь доступ к классу может происходить только через статическую переменную
    private init() { }

    public func saveGroupToStorage(group: Group?) {
        guard let group = group else {
            return
        }
        defaults.set(group.group, forKey: groupTitle)
        defaults.set(group.id, forKey: groupId)
    }

    public func getStoredGroup() -> Group {
        return Group(id: defaults.string(forKey: groupId),
                          group: defaults.string(forKey: groupTitle))
    }
}
