import UIKit

class Question {
    
    var id: String
    var subject: String
    var unit: String
    var content: String
    var name: String
    var comment: [String: [String: String]]
    
    init(id: String, subject: String, unit: String, content: String, name: String, comment: [String: [String: String]]) {
        self.id = id
        self.subject = subject
        self.unit = unit
        self.content = content
        self.name = name
        self.comment = comment
    }
}