//
//  EntriesTableViewController.swift
//  daily-journal
//
//  Created by Patricia Jamriskova on 06.05.2022.
//



//control+a ==> prettier


import UIKit
import CoreData

class EntriesTableViewController: UITableViewController {
    
    var entries: [Entry] = [] //data sa po vypnutí appky vymažú

    // zavola sa len prvykrat kedy sa controler vytvorí
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entries.count
    }
    
    //zavola sa hocikedy, kedy sa controler ukaze
    override func viewWillAppear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            //wanna be fetch request, citame data z core data
            
            let request: NSFetchRequest<Entry> = Entry.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
            
            if let entriesFromCoreData = try? context.fetch(request) {
                entries = entriesFromCoreData
                tableView.reloadData() // reloadneme data na stránke
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        //let cell = UITableViewCell()
        
        
        //zadefinovana nasa vlastna EntryCell zo storyboardu, ktoru sme kreslili
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell") as? EntryTableViewCell{
        
        let entry =  entries[indexPath.row]
            
            cell.entryTextLabel.text = entry.text
            //cell.monthLabel.text = "FEB"
            //cell.dayLabel.text = "14"
            
            cell.monthLabel.text = entry.month()
            cell.dayLabel.text = entry.day()

        //ak robime nieco custom, nikdy nenastavujeme textLabel, lebo sa rozsere  layout!!
        //cell.textLabel?.text = entry.text
         return cell
        } else {
            return UITableViewCell() // default
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry =  entries[indexPath.row]
        performSegue(withIdentifier: "segueToEntry", sender: entry)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let entryVC = segue.destination as? EntryViewController{
            //entryVC.entriesVS = self //self prezentuje aktuálnu triedu
            
            if let entryToBeSent = sender as? Entry {
                entryVC.entry = entryToBeSent
            }
        }
    }


}
