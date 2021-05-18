//
//  OnBoard5VC.swift
//  Motivia App
//
//  Created by Hamza Shahbaz on 11/03/2021.
//

import UIKit

class OnBoard5VC: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    
    var txts = ["Profitez gratuitement de vos 3 premiers jours","Citations introuvables ailleurs","Affirmations classées par catégories","Thèmes originaux et personnalisés","Essai gratuit de 3 jours","Seulement 1,66€/mois, payé annuellement"]
    var passUser: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func btnContinueTapped(_ sender: Any){
        
        DataService.instance.updateUser(user: passUser!)
        UserDefaults.standard.setValue(passUser?.userId, forKey: "userId")
        UserDefaults.standard.set([String](), forKey: "likes")
        let controller = self.storyboard?.instantiateViewController(identifier: "QuotesViewController") as! QuotesViewController
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }

}
extension OnBoard5VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return txts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OnBoardCell", for: indexPath) as! OnBoardCell
        cell.txtLbl.text = txts[indexPath.row]
        return cell
    }
    
    
}
