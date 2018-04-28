import Foundation
import UIKit

class Theme : NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        if let backgroundColor = backgroundColor { aCoder.encode(backgroundColor, forKey: "backgroundColor") }
        if let textColor = textColor { aCoder.encode(textColor, forKey: "textColor") }
        if let font = font { aCoder.encode(font, forKey: "font") }
        if let fontSize = fontSize { aCoder.encode(fontSize, forKey: "fontSize") }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.backgroundColor = aDecoder.decodeObject(forKey: "backgroundColor") as? UIColor
        self.textColor = aDecoder.decodeObject(forKey: "textColor") as? UIColor
        self.font = aDecoder.decodeObject(forKey: "font") as? UIFont
        self.fontSize = aDecoder.decodeObject(forKey: "fontSize") as? CGFloat
    }
    
    var backgroundColor : UIColor?
    var textColor : UIColor?
    var font : UIFont?
    var fontSize : CGFloat?
    
    init(backgroundColor : UIColor, textColor : UIColor, font : UIFont, fontSize : CGFloat) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.font = font
        self.fontSize = fontSize
    }
}

class Themer {
    static let sharedInstance = Themer()
    let defaultFont : UIFont?
    let defaultFontSize = 18.0
    var theme : Theme = Theme(
        backgroundColor: UIColor.white,
        textColor: UIColor.darkGray,
        font: UIFont(name:"Helvetica-Light", size: 18.0)!,
        fontSize: 18.0
    ) {
        willSet(newTheme) {
            let themeData = NSKeyedArchiver.archivedData(withRootObject: newTheme)
            UserDefaults.standard.set(themeData, forKey: "Theme")
        }
    }
    
    init() {
        self.defaultFont = UIFont(name:"Helvetica-Light", size: 18.0)
        
        self.theme = Theme(
            backgroundColor: UIColor.white,
            textColor: UIColor.darkGray,
            font: defaultFont!,
            fontSize: CGFloat(defaultFontSize)
        )
    }
    
    func saveCustomTheme(theme : Theme) {
        
    }
    
    func getCustomeTheme() {
        
    }
    
    func Dark() -> Theme {
        return Theme(
            backgroundColor: UIColor.darkGray,
            textColor: UIColor.white,
            font: defaultFont!,
            fontSize: CGFloat(defaultFontSize)
        )
    }
    
    func Light() -> Theme {
        return Theme(
            backgroundColor: UIColor.white,
            textColor: UIColor.darkGray,
            font: defaultFont!,
            fontSize: CGFloat(defaultFontSize)
        )
    }
}
