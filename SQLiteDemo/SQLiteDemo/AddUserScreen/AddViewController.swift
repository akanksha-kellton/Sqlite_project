//
//  AddViewController.swift
//  SQLiteDemo
//
//  Created by IOS Training 2 on 21/07/22.
//

import UIKit

class AddViewController: UIViewController {
    let dbSharedInstance = SqlDB.sharedInstance
    var detailsObj : Details?
    var isEdit : Bool = false
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    
    var delegate : setDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldValueFromDatbase()
    }

    private func setTextFieldValueFromDatbase(){
        guard let forEditName = self.detailsObj?.name else{return}
        guard let forEditEmail = self.detailsObj?.email else{return}
        guard let forEditMobile = self.detailsObj?.mobile else{return}
        
        nameTextField.text = forEditName
        emailTextField.text = forEditEmail
        mobileTextField.text = String(forEditMobile)
    }
    
    @IBAction func SubmitBtn(_ sender: UIButton) {
        
        guard let name = nameTextField.text else{return}
        guard let email = emailTextField.text else{return}
        guard let mobile = mobileTextField.text, let mob = Int64(mobile) else{return}

        if isEdit{
            self.dbSharedInstance.update(name: name, mobile: mob, id: detailsObj!.id)
        }else{
            dbSharedInstance.insert(name: name, email: email, mobile: mob)
        }
        
        self.delegate?.updateTable()
        self.navigationController?.popViewController(animated: true)
    }
   
}

  

