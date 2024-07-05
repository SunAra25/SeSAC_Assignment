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
    
    func sortDeadline() -> Results<TodoTable> {
        return realm.objects(TodoTable.self).sorted(byKeyPath: "deadline", ascending: true)
    }
    
    func sortTitle() -> Results<TodoTable> {
        return realm.objects(TodoTable.self).sorted(byKeyPath: "title", ascending: true)
    }
    
    func filterPriority() -> Results<TodoTable> {
        return realm.objects(TodoTable.self).where { $0.priority == "낮음" }
    }
    
    func itemCompleted(_ item: TodoTable) {
        try! realm.write {
            item.isDone.toggle()
            NotificationCenter.default.post(Notification(name: NSNotification.Name("UpdateTodoTable")))
        }
    }
    
    @discardableResult
    func createItem(_ item: (title: String, content: String?, tag: String?, deadline: String?, priority: String?)) -> ObjectId {
        var tagTable: TagTable?
        
        if let tag = item.tag {
            if realm.objects(TagTable.self).contains(where: { $0.title == tag }) {
                tagTable = realm.objects(TagTable.self).first(where: {$0.title == tag})
            } else {
                tagTable = TagTable(title: tag)
            }
        }
        
        let item = TodoTable(title: item.title, content: item.content, tag: tagTable, deadline: item.deadline, priority: item.priority)
        
        try! realm.write {
            realm.add(item)
            NotificationCenter.default.post(Notification(name: NSNotification.Name("UpdateTodoTable")))
        }
        
        return item._id
    }
    
    func deleteItem(_ item: TodoTable) {
        try! realm.write {
            realm.delete(item)
            NotificationCenter.default.post(Notification(name: NSNotification.Name("UpdateTodoTable")))
        }
    }
}
