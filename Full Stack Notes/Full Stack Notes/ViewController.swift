//
//  ViewController.swift
//  Full Stack Notes
//
//  Created by Aman on 01/12/21.
//

import UIKit

class ViewController: UIViewController, DataDelegate {
    
    
    @IBOutlet weak var notesTableView: UITableView!
    
    var notesArray = [Note]()
    
    let api = APIFunctions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self
        api.fetchNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        api.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        api.fetchNotes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddNoteViewController
        
        if segue.identifier == "updateNoteSegue" {
            vc.note = notesArray[notesTableView.indexPathForSelectedRow!.row]
            vc.update = true
        }
        
    }
    
    
    func updateArray(newArray: String) {
        do {
            notesArray = try JSONDecoder().decode([Note].self,from: newArray.data(using: .utf8)!)
        }catch{
            print("Failed to decode!")
        }
        self.notesTableView.reloadData()
    }


}



extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! NotePrototypeCell
        cell.title.text = notesArray[indexPath.row].title
        cell.note.text = notesArray[indexPath.row].note
        cell.date.text = notesArray[indexPath.row].date
        return cell
    }
}

