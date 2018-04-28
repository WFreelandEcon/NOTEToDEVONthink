import Foundation
import UIKit

class Theme : NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        if let backgroundColor = backgroundColor { aCoder.encode(backgroundColor, forKey: "backgroundColor") }
        if let textColor = textColor { aCoder.encode(textColor, forKey: "textColor") }
        if let font = font { aCoder.encode(font, forKey: "font") }
        if let fontSize = fontSize { aCoder.encode(fontSize, forKey: "fontSize") }
        if let settingsImage = settingsImage { aCoder.encode(settingsImage, forKey: "settingsImage") }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.backgroundColor = aDecoder.decodeObject(forKey: "backgroundColor") as? UIColor
        self.textColor = aDecoder.decodeObject(forKey: "textColor") as? UIColor
        self.font = aDecoder.decodeObject(forKey: "font") as? UIFont
        self.fontSize = aDecoder.decodeObject(forKey: "fontSize") as? CGFloat
        self.settingsImage = aDecoder.decodeObject(forKey: "settingsImage") as? UIImage
    }
    
    var backgroundColor : UIColor?
    var textColor : UIColor?
    var font : UIFont?
    var fontSize : CGFloat?
    var settingsImage : UIImage?
    
    init(backgroundColor : UIColor, textColor : UIColor, font : UIFont, fontSize : CGFloat, settingsImage : UIImage) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
        self.fontSize = fontSize
        self.settingsImage = settingsImage
    }
}

class Themer {
    static let sharedInstance = Themer()
    let defaultFont : UIFont?
    let defaultFontSize = 18.0
    var theme : Theme = Theme(
        backgroundColor: UIColor(red:0.93, green:0.94, blue:0.96, alpha:1.0),
        textColor: UIColor.darkGray,
        font: UIFont(name:"Helvetica-Light", size: 18.0)!,
        fontSize: 18.0,
        settingsImage: UIImage(named: "SettingsLight")!
    ) {
        willSet(newTheme) {
            let themeData = NSKeyedArchiver.archivedData(withRootObject: newTheme)
            UserDefaults.standard.set(themeData, forKey: "Theme")
        }
    }
    
    init() {
        self.defaultFont = UIFont(name:"Helvetica-Light", size: 18.0)
        
        self.theme = Theme(
            backgroundColor: UIColor(red:0.93, green:0.94, blue:0.96, alpha:1.0),
            textColor: UIColor.darkGray,
            font: defaultFont!,
            fontSize: CGFloat(defaultFontSize),
            settingsImage: UIImage(named: "SettingsLight")!
        )
    }
    
    func saveCustomTheme(theme : Theme) {
        
    }
    
    func getCustomeTheme() {
        
    }
    
    func Dark() -> Theme {
        return Theme(
            backgroundColor: UIColor(red:0.27, green:0.30, blue:0.36, alpha:1.0),
            textColor: UIColor.white,
            font: defaultFont!,
            fontSize: CGFloat(defaultFontSize),
            settingsImage: UIImage(named: "SettingsDark")!
        )
    }
    
    func Light() -> Theme {
        return Theme(
            backgroundColor: UIColor(red:0.93, green:0.94, blue:0.96, alpha:1.0),
            textColor: UIColor.darkGray,
            font: defaultFont!,
            fontSize: CGFloat(defaultFontSize),
            settingsImage: UIImage(named: "SettingsLight")!
        )
    }
}
