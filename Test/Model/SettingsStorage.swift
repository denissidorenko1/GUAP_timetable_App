//
//  SettingsStorage.swift
//  Test
//
//  Created by Denis on 27.10.2022.
//

import Foundation
class SettingsStorage {
    static let shared = SettingsStorage()
    private let defaults = UserDefaults.standard
    
    private let groupTitle = "SavedGroupTitle"
    private let groupId = "SavedGroupId"
    
    
    public func saveGroupToStorage(group: Group?){
        guard let group = group else {
            return
        }
        defaults.set(group.group, forKey: groupTitle)
        defaults.set(group.id, forKey: groupId)
    }
    
    // будет ли правильным возвращать группу с пустыми значениями в случае отсутствия группы в хранилище,
    // или лучше возращать опциональное значение, и обрабатывать его в уже по месту?
    public func getStoredGroup() -> Group{
        return Group(id: defaults.string(forKey: groupId) ?? "",
                          group: defaults.string(forKey: groupTitle) ?? "")
    }
    
    
}
