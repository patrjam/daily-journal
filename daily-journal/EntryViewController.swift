//
//  EntryViewController.swift
//  daily-journal
//
//  Created by Patricia Jamriskova on 06.05.2022.
//

import UIKit

class EntryViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var entryTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var entry: Entry? //optional
    
    //tiez uz neni potreba
    //var entriesVS: EntriesTableViewController? //hodnota alebo nill
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        if entry == nil {
            //create
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                entry = Entry(context: context)
                entry?.date = datePicker.date
                //entry?.text = entryTextView.text
                entry?.text = "Today was ..." //nastavenie default textu
                entryTextView.becomeFirstResponder() //pridanie zobrazovania klavesnice pri prvom vytvarani prispevku
                
            }

        } else {
            // fill in info about existing entry
            
        }
        
        entryTextView.text = entry?.text
        if let dateToBeShown = entry?.date {
            datePicker.date = dateToBeShown
        }
        entryTextView.delegate = self
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        
            //uz nepotrebujeme
            //entry?.date = datePicker.date
            //entry?.text = entryTextView.text
        
        
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext() //ulozenie contextu pre dalsi beh appky
        
        
        //nepotrebny kod, ktory bol nahradeny core datami/DB riesenim
        //entriesVS?.entries.append(entry)
        //entriesVS?.tableView.reloadData()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            bottomConstraint.constant = keyboardHeight
        }
    }
    @IBAction func deleteTapped(_ sender: Any) {
        if entry != nil {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(entry!) //mazeme entry objekt, ktory nie je nil
                try? context.save()
            }
        }
        
        navigationController?.popViewController(animated: true)

    }
    
    func textViewDidChange(_ textView: UITextView) {
        // ulozenie zmien pri editovani uz vytvoreneho prispevku
        entry?.text = entryTextView.text
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        entry?.date = datePicker.date
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext() // ulozime si kontext zmenenej hodnoty
    }
}
