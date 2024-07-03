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
    @Persisted var tag: TagTable?
    @Persisted var isDone: Bool
    @Persisted var isImportant: Bool
    @Persisted var deadline: String?
    @Persisted var priority: String?
    
    convenience init(title: String, content: String? = nil, tag: TagTable? = nil, deadline: String? = nil, priority: String? = nil) {
        self.init()
        self.title = title
        self.content = content
        self.tag = tag
        self.isDone = false
        self.isImportant = false
        self.deadline = deadline
        self.priority = priority
    }
}

class TagTable: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted(indexed: true) var title: String
    
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
