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

class SettingsViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!        
    var templates = [Template]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        templates = TemplateController.sharedInstance.retrieveAllTemplates()
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTemplateTable),
            name: NSNotification.Name(rawValue: "SavedTemplate"),
            object: nil)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return templates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(templates[indexPath.row].shortCut) -> \(templates[indexPath.row].expansion.components(separatedBy: .whitespacesAndNewlines))"
        return cell
    }
    
    @objc func updateTemplateTable() {
        templates = TemplateController.sharedInstance.retrieveAllTemplates()
        self.tableView.reloadData()
        self.view.makeToast("Added new template successfully", duration: 2.0, position: .bottom)
    }
    
    @IBAction func showCopyRight() {
        let alert = UIAlertController(title: "Copyright & Notices", message: "DEVONthink™️ and DEVONthink To Go™️ are registered trademarks of DEVONtechnologies, LLC. \nhttps://www.devontechnologies.com\n\nThird Party Libraries: \n\nToast-Swift: https://github.com/scalessec/Toast-Swift/blob/master/LICENSE \n\nDisk: https://github.com/saoudrizwan/Disk/blob/master/LICENSE", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
