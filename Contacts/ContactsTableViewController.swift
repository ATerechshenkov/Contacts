//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by Terechshenkov Andrey on 12/10/20.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    var contacts = Contact.contacts
    
    var favourites: [Contact] {
        get {
            contacts.filter { (contact) -> Bool in
                contact.favourite
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Contacts"
    }

    @IBAction func unwindSeque(seque: UIStoryboardSegue) {
        guard seque.identifier == "saveSeque" else { return }
        
        let sourceViewController = seque.source as! NewContactTableViewController
        let contact = sourceViewController.contact
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            contacts[selectedIndexPath.row] = contact
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let indexPath = IndexPath(row: contacts.count, section: 0)
            contacts.append(sourceViewController.contact)
            tableView.insertRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editContact" else { return }
        
        let indexPath = tableView.indexPathForSelectedRow!
        let navigationVC = segue.destination as! UINavigationController
        let newContactVC = navigationVC.topViewController as! NewContactTableViewController
        newContactVC.contact = contacts[indexPath.row]
        newContactVC.title = "Edit"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactTableViewCell
        
        cell.name.text = contacts[indexPath.row].fullName
        
        if let image = contacts[indexPath.row].image {
            cell.avatar.image = UIImage(named: image)
        } else {
            cell.avatar.image = UIImage(systemName: "person.circle")
        }
        cell.avatar.layer.cornerRadius = cell.avatar.frame.height / 2
        cell.avatar.clipsToBounds = true
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [favouriteAction(it: indexPath)])
    }

    private func favouriteAction(it indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
            self.contacts[indexPath.row].switchFavourite()
            completion(true)
        }
        action.image = contacts[indexPath.row].favourite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        action.backgroundColor = contacts[indexPath.row].favourite ? .systemYellow : .systemGray
        return action
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
