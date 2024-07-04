//
//  TodoRepository.swift
//  Reminder
//
//  Created by 아라 on 7/4/24.
//

import Foundation
import RealmSwift

final class TodoRepository {
    private let realm = try! Realm()
    
    func fetchAllTodo() -> Results<TodoTable> {
        return realm.objects(TodoTable.self)
    }
    
    func fetchTodayTodo() -> Results<TodoTable> {
        return realm.objects(TodoTable.self).where { $0.deadline == Date().toString() }
    }
    
    func fetchScheduledTodo() -> Results<TodoTable> {
        return realm.objects(TodoTable.self).where { !$0.isDone }
    }
    
    func fetchFlaggedTodo() -> Results<TodoTable> {
        return realm.objects(TodoTable.self).where { $0.isImportant }
    }
    
    func fetchCompletedTodo() -> Results<TodoTable> {
        return realm.objects(TodoTable.self).where { $0.isDone }
    }
}
