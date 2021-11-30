//
//  AddNoteViewController.swift
//  Full Stack Notes
//
//  Created by Aman on 01/12/21.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    
    let api = APIFunctions()
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var note:Note?
    var update = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if update == true {
            titleTextField.text = note!.title
            bodyTextField.text = note!.note
        }
    }
   
    @IBAction func saveClick(_ sender: UIBarButtonItem) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        if update == true {
            api.updateNote(date: date, title: titleTextField.text!, note: bodyTextField.text, id: note!._id)
            self.navigationController?.popViewController(animated: true)
        }else if titleTextField.text != ""  && bodyTextField.text != ""{
            api.AddNote(date: date, title: titleTextField.text!, note: bodyTextField.text)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if update == false {
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
        }
    }
    
    @IBAction func deleteClicked(_ sender: Any) {
        api.deleteNote(id: note!._id)
        self.navigationController?.popViewController(animated: true)
    }
    
}
