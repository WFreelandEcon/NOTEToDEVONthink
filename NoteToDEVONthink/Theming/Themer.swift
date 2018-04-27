import Foundation
import UIKit

struct Theme {
    var backgroundColor : UIColor
    var textColor : UIColor
    var font : UIFont
    var fontSize : CGFloat
    
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
    var theme : Theme
    
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
