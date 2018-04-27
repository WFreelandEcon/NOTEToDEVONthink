import Foundation
import Disk

class TemplateController {
    static let sharedInstance = TemplateController()
    private init() {}
    
    func storeTemplate( template : Template ) {
        do {
            let unique = templateIsUnique(template: template).unique
            if (unique) {
                try Disk.save(template, to: .caches, as: "\(template.shortCut).json")
            } else {
                // Ask if it should be overwritten?
            }
        } catch {
            // Throw error
        }
    }
    
    func templateIsUnique( template : Template ) -> (template: Template?, unique: Bool) {
        do {
            let template = try Disk.retrieve("\(template.shortCut).json", from: .caches, as: Template.self)
            return (template, false)
        } catch {
            // Failure
        }
        return (nil, true)
    }
    
    func retrieveAllTemplates() -> [Template]? {
        return nil
    }
}
