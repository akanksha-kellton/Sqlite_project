//
//  UserTableViewCell.swift
//  SQLiteDemo
//
//  Created by IOS Training 2 on 21/07/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    public static var identifier = "UserTableViewCell"
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var mobileLable: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func insertDetails(name:String, email:String, mobile: String){
        nameLable.text = name
        emailLable.text = email
        mobileLable.text = mobile
    }
    
     
    public static func nib()->UINib{
        return UINib(nibName: "UserTableViewCell", bundle: nil)
    }
}

//bolo yaha  par
//control choro//
