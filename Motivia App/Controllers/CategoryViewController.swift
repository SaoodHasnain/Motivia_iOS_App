//
//  NewHomeVC.swift
//  Motivia App
//
//  Created by Hamza Shahbaz on 01/04/2021.
//

import UIKit

class CategoryViewController: UIViewController {

    //MARK:- Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- Controller LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- Supporting Functions
    
    
    
    //MARK:- Actions
    
    @IBAction func btnAnnuerTapped(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CategoryViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 197
    }
}
