//
//  ProfileViewController.swift
//  Intagram-Tecsup-LGuzman
//
//  Created by MAC35 on 28/10/22.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnStatics: UIButton!
    @IBOutlet weak var btnContact: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageProfile.layer.cornerRadius = 40
        btnEdit.layer.cornerRadius = 13
        btnContact.layer.cornerRadius = 13
        btnStatics.layer.cornerRadius = 13
        
    }
    
}
