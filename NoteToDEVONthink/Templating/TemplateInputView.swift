//
//  TemplateInputView.swift
//  NoteToDEVONthink
//
//  Created by Adam Fallon on 28/04/2018.
//  Copyright © 2018 Adam Fallon. All rights reserved.
//
import UIKit
import Toast_Swift

class TemplateInputView : UIView, UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var shortCutInput: UITextField!
    @IBOutlet weak var expansionWindow: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var shortCutLabel: UILabel!
    @IBOutlet weak var expandToLabel: UILabel!
    let placeHolderTextForTextView = "Enter expansion here"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TemplateInput", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        expansionWindow.delegate = self
        expansionWindow.textColor = UIColor.lightGray
        expansionWindow.text = placeHolderTextForTextView
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        shortCutInput.becomeFirstResponder()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.modalView.frame.origin.y -= 20
        }, completion: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.modalView.frame.origin.y == 0{
                self.modalView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.modalView.frame.origin.y != 0{
                self.modalView.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if expansionWindow.text == placeHolderTextForTextView {
            expansionWindow.text = nil
            expansionWindow.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if expansionWindow.text == "" {
            expansionWindow.text = placeHolderTextForTextView
            expansionWindow.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func closeModal() {
        self.removeFromSuperview()
    }
    
    @IBAction func addTemplate() {
        guard let shortCutText = self.shortCutInput.text else {
            // Failure Alert
            return
        }
        
        guard let expanisionText = self.expansionWindow.text else {
            // Failure Alert
            return
        }
        
        let template : Template = Template(shortCut: shortCutText, expansion: expanisionText )
        TemplateController.sharedInstance.storeTemplate(template: template)
        self.contentView.makeToast("Saved Template", duration: 2.0, position: .top)
        closeModal()
    }
}
