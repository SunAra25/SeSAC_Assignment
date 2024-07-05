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
        return sortPin(realm.objects(TodoTable.self))
    }
    
    func fetchTodayTodo() -> Results<TodoTable> {
        return sortPin(realm.objects(TodoTable.self).where { $0.deadline == Date().withoutTime() })
    }
    
    func fetchTodo(selectedDate date: Date) -> Results<TodoTable> {
        return sortPin(realm.objects(TodoTable.self).where { $0.deadline == date.withoutTime() })
    }
    
    func fetchScheduledTodo() -> Results<TodoTable> {
        return sortPin(realm.objects(TodoTable.self).filter("deadline > %@", Date().withoutTime()! as NSDate))
    }
    
    func fetchFlaggedTodo() -> Results<TodoTable> {
        return sortPin(realm.objects(TodoTable.self).where { $0.isFlag })
    }
    
    func fetchCompletedTodo() -> Results<TodoTable> {
        return sortPin(realm.objects(TodoTable.self).where { $0.isDone })
    }
    
    func sortPin(_ table: Results<TodoTable>) -> Results<TodoTable> {
        return table.sorted(byKeyPath: "isPin", ascending: false)
    }
    
    func sortDeadline() -> Results<TodoTable> {
        return sortPin(realm.objects(TodoTable.self).sorted(byKeyPath: "deadline", ascending: true))
    }
    
    func sortTitle() -> Results<TodoTable> {
        return sortPin(realm.objects(TodoTable.self).sorted(byKeyPath: "title", ascending: true))
    }
    
    func filterPriority() -> Results<TodoTable> {
        return sortPin(realm.objects(TodoTable.self).where { $0.priority == "낮음" })
    }
    
    func itemCompleted(_ item: TodoTable) {
        try! realm.write {
            item.isDone.toggle()
            NotificationCenter.default.post(Notification(name: NSNotification.Name("UpdateTodoTable")))
        }
    }
    
    func itemFlagged(_ item: TodoTable) {
        try! realm.write {
            item.isFlag.toggle()
            NotificationCenter.default.post(Notification(name: NSNotification.Name("UpdateTodoTable")))
        }
    }
    
    func itemPinned(_ item: TodoTable) {
        try! realm.write {
            item.isPin.toggle()
        }
    }
    
    @discardableResult
    func createItem(_ item: (title: String, content: String?, tag: String?, deadline: Date?, priority: String?)) -> ObjectId {
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
