import Foundation

class Template : Codable, Equatable {
    var shortCut : String
    var expansion : String
    
    init(shortCut : String, expansion : String) {
        self.shortCut = shortCut
        self.expansion = expansion
    }
    
    public static func ==(lhs: Template, rhs: Template) -> Bool {
        return lhs.shortCut + lhs.expansion == rhs.shortCut + rhs.expansion
    }
}
