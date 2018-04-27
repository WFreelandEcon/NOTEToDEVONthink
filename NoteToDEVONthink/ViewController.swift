import UIKit
import Floaty

class DEVONthinkNote {
    var date : Date
    var title : String?
    var text : String?
    
    init( title : String?, text : String) {
        self.date = Date()
        self.title = title
        self.text = text
    }
}

class DEVONthinkURI {
    let path : String
    
    init() {
        self.path = "x-devonthink://createText"
    }
    
    func url( note : DEVONthinkNote ) -> URL {
        let queryItems = [NSURLQueryItem(name: "title", value: "{[\(note.title!)]}"),
                          NSURLQueryItem(name: "location", value: "{[Inbox]}"),
                          NSURLQueryItem(name: "text", value: "\(note.text!)")]
        let urlComps = NSURLComponents(string: self.path)!
        urlComps.queryItems = queryItems as [URLQueryItem]
        return urlComps.url!
    }
}

// Utils Class

extension String {
    var lines: [String] { return self.components(separatedBy: CharacterSet.newlines) }
}

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createSendButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func createSendButton() {
        let floaty = Floaty()
        floaty.addItem("Send to DEVONthink", icon: UIImage(named: "SendIcon"), handler: { item in
            self.sendToDevonThink()
        })
        self.view.addSubview(floaty)
    }
    
    func alterTextWhenNotEditingTitle() {
        // Shrink down the font size.
    }
    
    func sendToDevonThink() {
        let textLines = textView.text.lines[1..<textView.text.lines.count]
        let note : DEVONthinkNote = DEVONthinkNote(title: textView.text.lines[0] , text: textLines.joined(separator: "\n"))
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(DEVONthinkURI().url(note: note), options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(DEVONthinkURI().url(note: note))
        }
    }

}

