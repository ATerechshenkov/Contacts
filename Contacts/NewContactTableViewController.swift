//
//  NewContactTableViewController.swift
//  Contacts
//
//  Created by Terechshenkov Andrey on 12/12/20.
//

import UIKit

class NewContactTableViewController: UITableViewController {
    
    var contact = Contact(image: nil, firstName: "", lastName: "", phone: "", favourite: false)
    
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var honorificTextField: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var favouriteSwitch: UISwitch!
    @IBOutlet var favouriteImage: UIImageView!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        updateCheckButtonState()
    }
    
    @IBAction func onChanged(_ sender: UITextField) {
        updateCheckButtonState()
    }

    private func updateCheckButtonState() {
        let name = firstNameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""
        
        saveButton.isEnabled = !name.isEmpty && !phone.isEmpty
    }
    
    private func updateUI() {
        if let image = contact.image {
            avatar.image = UIImage(named: image)
        } else {
            avatar.image = UIImage(systemName: "person.circle")
        }
        avatar.layer.cornerRadius = avatar.frame.height / 2
        honorificTextField.text = contact.honorific
        firstNameTextField.text = contact.firstName
        lastNameTextField.text = contact.lastName
        phoneTextField.text = contact.phone
        favouriteSwitch.isOn = contact.favourite
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSeque" else { return }
    
        contact.honorific = honorificTextField.text ?? ""
        contact.firstName = firstNameTextField.text ?? ""
        contact.lastName = lastNameTextField.text ?? ""
        contact.phone = phoneTextField.text ?? ""
        contact.favourite = favouriteSwitch.isOn
    }
}
