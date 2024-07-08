//
//  Todo.swift
//  Reminder
//
//  Created by 아라 on 7/2/24.
//

import RealmSwift
import Foundation

class TodoTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted(indexed: true) var title: String
    @Persisted var content: String?
    @Persisted var isDone: Bool
    @Persisted var isFlag: Bool
    @Persisted var isPin: Bool
    @Persisted var deadline: Date?
    @Persisted var priority: String?
    
    @Persisted (originProperty: "todoList") var main: LinkingObjects<TagTable>
    
    convenience init(title: String, content: String? = nil, deadline: Date? = nil, priority: String? = nil) {
        self.init()
        self.title = title
        self.content = content
        self.isDone = false
        self.isFlag = false
        self.isPin = false
        self.deadline = deadline
        self.priority = priority
    }
}

class TagTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted(indexed: true) var title: String
    @Persisted var todoList: List<TodoTable>
    
    convenience init(title: String) {
        self.init()
        self.title = title
        self.todoList = List<TodoTable>()
    }
}
