import UIKit

// MARK : Date Structures
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

extension String {
    var lines: [String] { return self.components(separatedBy: CharacterSet.newlines) }
}

class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var Header: UILabel!
    var previousRect : CGRect!
    var lineCounter : Int!
    var wordCount : Int!
    let placeholderText : String! = "Start writing your note..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardDidShow, object: nil)
        
        textView.delegate = self
        previousRect = CGRect()
        lineCounter = 1
        wordCount = 0
        Header.text = String("Lines: \(lineCounter!) | Words: \(wordCount!)")
        
        textView.text = placeholderText
        textView.textColor = UIColor.lightGray
        self.view.layoutIfNeeded()
        subscribeToShowKeyboardNotifications()
        addToolbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func sendToDevonThink(sender: AnyObject!) {
        let textLines = textView.text.lines[1..<textView.text.lines.count]
        let note : DEVONthinkNote = DEVONthinkNote(title: textView.text.lines[0] , text: textLines.joined(separator: "\n"))
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(DEVONthinkURI().url(note: note), options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(DEVONthinkURI().url(note: note))
        }
    }
    
    func updateHeader(_ textView : UITextView) {
        // Count words
        let components = textView.text.components(separatedBy: .whitespacesAndNewlines)
        wordCount = components.filter { !$0.isEmpty }.count
        
        let pos = textView.endOfDocument
        let currentRect = textView.caretRect(for: pos)
        
        if (self.textView.text == nil) {
            lineCounter = 0
        }
        
        // Count lines
        if previousRect != CGRect.zero {
            if currentRect.origin.y > previousRect.origin.y {
                // Array of Strings
                var currentLines = textView.text.components(separatedBy: "\n")
                // Remove Blank Strings
                currentLines = currentLines.filter{ $0 != "" }
                //increase the counter counting how many items inside the array
                lineCounter = currentLines.count
            }
        }
        previousRect = currentRect
        Header.text = String("Lines: \(lineCounter!) | Words: \(wordCount!)")
    }

    // MARK: TextView Delegate Methods
    func textViewDidChange(_ textView: UITextView) {
        updateHeader(textView)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Keyboard Toolbar
    func addToolbar() {
        let toolBar = UIToolbar(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [
            UIBarButtonItem(title: "Send to DEVONthink", style: .plain, target: self, action: #selector(sendToDevonThink(sender:))),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearText(sender:))),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed(sender:)))]
        toolBar.sizeToFit()
        
        self.textView.inputAccessoryView = toolBar
    }
    
    // MARK : Toolbar methods
    @objc func donePressed(sender: AnyObject!) {
        self.textView.resignFirstResponder()
    }
    
    @objc func cancelPressed(sender: AnyObject!) {
        self.textView.resignFirstResponder()
    }
    
    @objc func clearText(sender: AnyObject!) {
        self.textView.text = nil
        updateHeader(textView)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardHeight = keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
    }
    
    func subscribeToShowKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }

}

