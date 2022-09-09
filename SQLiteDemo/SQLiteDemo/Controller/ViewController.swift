//
//  ViewController.swift
//  SQLiteDemo
//
//  Created by IOS Training 2 on 20/07/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var usertable: UITableView!
    
    let dbSharedInstance = SqlDB.sharedInstance
    var details: [Details] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usertable.delegate = self
        usertable.dataSource = self
        configireNib()
        //wait
//        details = dbSharedInstance.read()
//        usertable.reloadData()
        // Do any additional setup after loading the view.
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        details = dbSharedInstance.read()
        usertable.reloadData()
    }

    @IBAction func AddBtn(_ sender: UIBarButtonItem) {
        
        let root = AddViewController()
        root.delegate = self
        root.title = "Add"
        root.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .done, target: self, action: nil)
        
        navigationController?.pushViewController(root, animated: false)
        
        //updateDataSource()
        
    }
    
//    private func updateDataSource() {
//            // updating table view datasource
//            details = dbSharedInstance.read()
//            usertable.reloadData()
//        }
    
}
extension ViewController: setDataDelegate{
     func updateTable(){
        details = dbSharedInstance.read()
        usertable.reloadData()
         
    }
    
    
}

extension ViewController{
    private func configireNib(){
        self.usertable.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.identifier)
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = AddViewController()
        let selectedPerson = details[indexPath.row]
        vc.isEdit = true
            
        vc.detailsObj = Details(id: selectedPerson.id, name: selectedPerson.name, email: selectedPerson.email, mobile: selectedPerson.mobile)
    
        navigationController?.pushViewController(vc, animated: false)
    }
 
        
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }

}
extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,commit  editingStyle:UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let selectedPerson = details[indexPath.row]
        if(editingStyle == .delete){
            self.dbSharedInstance.deleteByID(id: selectedPerson.id)
            //selectedPerson.remove(at: indexPath.row)
            usertable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath)as! UserTableViewCell
      
        
        let values = details[indexPath.row]
        cell.insertDetails(name: values.name, email: values.email, mobile: String(values.mobile))
        return cell
        
    }
    
    
}

