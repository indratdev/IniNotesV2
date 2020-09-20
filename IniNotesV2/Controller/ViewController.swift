//
//  ViewController.swift
//  IniNotesV2
//
//  Created by IndratS on 19/09/20.
//  Copyright © 2020 IndratSaputra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myTable: UITableView!
    
    //    let noteVC = NotesVC()
    let util = Utilities()
    let op = OperationNote()
    var items: [Notes]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        
        let nib = UINib(nibName: util.Notenib, bundle: nil)
        myTable.register(nib, forCellReuseIdentifier: util.NoteCell)
        myTable.delegate = self
        myTable.dataSource = self
        
        self.loadData()
    }
    
    @objc func refresh() {
        loadData()
    }
    
    private func loadData(){
        self.items = op.loadData()
        print("========= load data============")
        
        DispatchQueue.main.async {
            self.myTable.reloadData()
        }
    }
    
    @IBAction func addNewButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NoteSegue", sender: nil)
    }
    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myTable.dequeueReusableCell(withIdentifier: util.NoteCell, for: indexPath) as? NoteTBCell else { fatalError("Error cell")}
        
        let note = self.items?[indexPath.row]
        
        cell.addDateLabel.text = "\(note?.addDate ?? Date())"
        cell.titleLabel.text = note?.title
        cell.decsriptionLabel.text = note?.descriptionNote
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = self.items![indexPath.row]
        print(data)
    }
    
    // MARK: SWIPE TO DELETE
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete", handler: {(action, view, completionHandler) in
            let data = self.items![indexPath.row]
//            self.op.context.del
//            print(data)
            let alert = UIAlertController(title: "Delete", message: "Are You Sure Delete This Data ?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: {(action) in
                self.op.context.delete(data)
                do {
                    try self.op.context.save()
                }catch{
                    print("Error Delete")
                }
                
                self.loadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        })
        return UISwipeActionsConfiguration(actions: [action])
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "NoteSegue"){
            
        }
    }
}

