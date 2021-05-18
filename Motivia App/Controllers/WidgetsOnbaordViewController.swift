//
//  WidgetsOnbaordViewController.swift
//  Motivia App
//
//  Created by Hamza Shahbaz on 05/04/2021.
//

import UIKit

class WidgetsOnbaordViewController: UIViewController {

    //MARK:- Properties
    
    var passUser: UserModel?
    
    //MARK:- Controller Life Cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    //MARK:- Supporting Functions
    
    
    //MARK:- Actions
    @IBAction func btnComprisTapped(_ sender: Any){
        let controller = self.storyboard?.instantiateViewController(identifier: "OnBoard4VC") as! OnBoard4VC
        controller.passUser = passUser
        self.present(controller, animated: true, completion: nil)
    }
}
