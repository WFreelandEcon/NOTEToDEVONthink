import Foundation

class Template : Codable {
    var shortCut : String
    var expansion : String
    
    init(shortCut : String, expansion : String) {
        self.shortCut = shortCut
        self.expansion = expansion
    }
}
