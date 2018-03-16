//
//  ShlagbaumTableVC.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 21.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit
import MBProgressHUD

class ShlagbaumTableVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromServer()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shlagbaumSettings" {
            guard let selectedShlagbaum = sender as? Shlagbaum else {return}
            guard let destination = segue.destination as? ShlagBaumSettingsVC else {return}
            
            destination.selectedShlagbaum = selectedShlagbaum
            
        }
    }
    
    private func getDataFromServer(){
        FakeModel.shared.shlagbaumArray = []
        tableView.reloadData()
        
        guard let phone = UserAPI.shared.getTokenAndPhoneNumber().phone else {return}
        guard let token = UserAPI.shared.getTokenAndPhoneNumber().token else {return}
        
        NetworkAPI.getBarriers(phone:phone,
                               token: token) {[weak self] (result, error) in
                                if error != nil {
                                    self?.displayAlert(error!)
                                    return
                                }
                                self?.tableView.reloadData()
        }
        
    }
    
    private func openBarrierWith(index:Int){
        guard let phone = UserAPI.shared.getTokenAndPhoneNumber().phone else {return}
        guard let token = UserAPI.shared.getTokenAndPhoneNumber().token else {return}
        guard let barrier_id = FakeModel.shared.shlagbaumArray[index].barrier_id else {return}
        
        NetworkAPI.openBarrier(phone: phone, token: token, barrierId: barrier_id) {[weak self] (result, error) in
            if error != nil {
                self?.displayAlert(error!)
                return
            }
        }
        
    }
}

extension ShlagbaumTableVC: UITableViewDelegate, UITableViewDataSource, CellButtonsDelegate {
    
    func didPressButtonWith(name: String?, indexPath: IndexPath!) {
        if name == "settings" {
            performSegue(withIdentifier: "shlagbaumSettings", sender: FakeModel.shared.shlagbaumArray[indexPath.row])
        }
        
        if name == "open" {
            openBarrierWith(index: indexPath.row)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FakeModel.shared.shlagbaumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShlagbaumTableViewCell
        
        cell.delegate = self
        
        cell.updateLeftRightConstraint()
        cell.currentIndexPath = indexPath
        
        let shlagbaum = FakeModel.shared.shlagbaumArray[indexPath.row]
        
        cell.shlagbaumName.text = shlagbaum.name
        cell.shlagbaumAdressUILabel.text = shlagbaum.adress
        if shlagbaum.photo != nil {
            cell.shlagbaumImageUIImage.image = shlagbaum.photo}
        cell.shlagbaumNeedsUpdate = shlagbaum.needsUpdate
        
        cell.setShlagbaumPresentation()
        
        return cell
    }
    
    
}
