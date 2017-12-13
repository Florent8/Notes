//
//  NoteTableViewController.swift
//  Notes
//
//  Created by  on 28/11/2017.
//  Copyright © 2017 amacabr2. All rights reserved.
//

import UIKit
import MapKit

class NoteTableViewController: UITableViewController {
    
    private var notes: Notes = Notes()
    
    private var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return url!.appendingPathComponent("Data").path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        navigationItem.leftBarButtonItem = editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notes.size()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NoteTableViewCell
        cell.update(with: notes.getNote(indexPath.row))
        cell.showsReorderControl = true
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            notes.deleteNote(indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        notes.addNote(notes.deleteNote(fromIndexPath.row), at: to.row)
        tableView.reloadData()
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditNote" {
            (segue.destination as! NoteAddOrEditTableViewController).setNote(note: notes.getNote(tableView.indexPathForSelectedRow!.row))
        }
    }
    
    @IBAction func unwindToNoteTableViewController(segue: UIStoryboardSegue) {
        if segue.identifier == "save" {
            if let note = (segue.source as! NoteAddOrEditTableViewController).getNote() {
                if let selectedPath = tableView.indexPathForSelectedRow {
                    notes.updateNote(note, at: selectedPath.row)
                } else {
                    notes.addNote(note)
                }
                saveData(notes: notes)
                tableView.reloadData()
            }
        }
    }
    
    private func saveData(notes: Notes) {
        NSKeyedArchiver.archiveRootObject(notes, toFile: filePath)
    }
    
    private func loadData() {
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? Notes {
            notes = data
        }
    }
}
