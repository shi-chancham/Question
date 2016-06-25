import UIKit

class Question {
    
    var subject: String
    var unit: String
    var content: String
    var name: String
    
    init(subject: String, unit: String, content: String, name: String) {
        self.subject = subject
        self.unit = unit
        self.content = content
        self.name = name
    }
}