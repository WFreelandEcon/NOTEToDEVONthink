import Foundation
import Disk

class TemplateController {
    static let sharedInstance = TemplateController()
    private init() {}
    
    func storeTemplate( template : Template ) {
        do {
            var templates = retrieveAllTemplates()
            templates.append(template)
            try Disk.save(templates, to: .caches, as: "templates.json")
            NotificationCenter.default.post(name: Notification.Name("SavedTemplate"), object: nil)
        } catch {
            // Throw error
        }
    }
    
    func retrieveAllTemplates() -> [Template] {
        do {
            let templates = try Disk.retrieve("templates.json", from: .caches, as: [Template].self)
            return templates
        } catch {
            // Throw error
        }
        
        return [Template]()
    }
}
