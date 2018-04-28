//
//  SettingsViewController.swift
//  NoteToDEVONthink
//
//  Created by Adam Fallon on 28/04/2018.
//  Copyright © 2018 Adam Fallon. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

class SettingsViewController : UIViewController {
    @IBOutlet weak var tableView: UITableView!        
    
    override func viewDidLoad() {
         super.viewDidLoad()
    }
    
    @IBAction func changeToDarkTheme() {
        Themer.sharedInstance.theme = Themer.sharedInstance.Dark()
        self.view.makeToast("Editor Theme changed 😁", duration: 2.0, position: .bottom)
    }
    
    @IBAction func changeToLightTheme() {
        Themer.sharedInstance.theme = Themer.sharedInstance.Light()
        self.view.makeToast("Editor Theme changed 😁", duration: 2.0, position: .bottom)
    }
    
    @IBAction func createCustomTheme() {
        // TODO: Implement this screen
    }
    
    @IBAction func addTemplate() {
        let templateInput = TemplateInputView(frame: CGRect(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2, width:self.view.bounds.width, height: self.view.bounds.height))
        templateInput.isHidden = false
        templateInput.center = self.view.center
        self.view.addSubview(templateInput)
    }
    
    @IBAction func closeSettings() {
        self.navigationController?.popViewController(animated: true)
    }
}
