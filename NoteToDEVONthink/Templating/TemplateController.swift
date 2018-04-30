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
            try Disk.save(templates, to: .caches, as: "Templates/\(template.shortCut)+\(template.expansion).json")
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
    
    func retrieveTemplate( template : Template ) -> [Template] {
        do {
            let templates = try Disk.retrieve("Templates/\(template.shortCut)+\(template.expansion).json", from: .caches, as: [Template].self)
            return templates
        } catch {
            // Throw error
        }
        
        return [Template]()
    }
    
    func removeTemplate(template : Template, completion: (_ done: Bool) -> Void) {
        do {
            var templates = try Disk.retrieve("templates.json", from: .caches, as: [Template].self)
            try Disk.remove("templates.json", from: .caches)
            if let index = templates.index(of: template) {
                templates.remove(at: index)
                try Disk.save(templates, to: .caches, as: "templates.json")
                try Disk.remove("Templates/\(template.shortCut)+\(template.expansion).json", from: .caches)
                completion(true)
            }
        } catch {
            // Throw error
            completion(false)
        }
    }
}
