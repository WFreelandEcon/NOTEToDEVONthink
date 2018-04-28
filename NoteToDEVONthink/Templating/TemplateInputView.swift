//
//  TemplateInputView.swift
//  NoteToDEVONthink
//
//  Created by Adam Fallon on 28/04/2018.
//  Copyright © 2018 Adam Fallon. All rights reserved.
//
import UIKit

class TemplateInputView : UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var shortCutInput: UITextField!
    @IBOutlet weak var expansionWindow: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var shortCutLabel: UILabel!
    @IBOutlet weak var expandToLabel: UILabel!
    
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
    }
    
    @IBAction func closeModal() {
        self.contentView.isHidden = true
    }
}
