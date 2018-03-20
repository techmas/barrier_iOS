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
    var shlagbaumsTableRequireUpdate = false
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        refreshControl.beginRefreshing()
        getDataFromServer()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if shlagbaumsTableRequireUpdate {
            refreshControl.beginRefreshing()
            getDataFromServer()
        }
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "shlagbaumSettings" {
            guard let selectedShlagbaum = sender as? Shlagbaum else {return}
            guard let destination = segue.destination as? ShlagBaumSettingsVC else {return}
            
            destination.selectedShlagbaum = selectedShlagbaum
            
        }
    }
    
    @objc private func getDataFromServer(){
        //FakeModel.shared.shlagbaumArray = []
        //tableView.reloadData()
        
        guard let phone = UserAPI.shared.getTokenAndPhoneNumber().phone else {return}
        guard let token = UserAPI.shared.getTokenAndPhoneNumber().token else {return}
        //ProgressHUDManager.shared.showHUD()
        NetworkAPI.getBarriers(phone:phone,
                               token: token) {[weak self] (result, error) in
                                //ProgressHUDManager.shared.hideHUD()
                                DispatchQueue.main.async {
                                    self?.refreshControl.endRefreshing()
                                    if error != nil {
                                        self?.displayAlert(error!)
                                        return
                                    }
                                    self?.tableView.reloadData()
                                }
        }
        
    }
    
    private func openBarrierWith(index:Int){
        guard let phone = UserAPI.shared.getTokenAndPhoneNumber().phone else {return}
        guard let token = UserAPI.shared.getTokenAndPhoneNumber().token else {return}
        guard let barrier_id = FakeModel.shared.shlagbaumArray[index].barrier_id else {return}
        let oldBarrier:Bool = FakeModel.shared.shlagbaumArray[index].needsUpdate ?? false
        
        
        if oldBarrier {
            guard let barrierPhoneNumber = FakeModel.shared.shlagbaumArray[index].phone else {return}
            NetworkAPI.openBarrierViaGSM(phone: phone, token: token, barrierPhoneNumber: barrierPhoneNumber) {[weak self] (result, error) in
                if error != nil {
                    self?.displayAlert(error!)
                    return
                }
            }
        } else {
            NetworkAPI.openBarrier(phone: phone, token: token, barrierId: barrier_id) {[weak self] (result, error) in
                if error != nil {
                    self?.displayAlert(error!)
                    return
                }
            }
        }
        

        
    }
}

extension ShlagbaumTableVC: UITableViewDelegate, UITableViewDataSource, CellButtonsDelegate {
    
    fileprivate func addRefreshControl(){
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(getDataFromServer), for: .valueChanged)
        refreshControl.tintColor = UIColor.duskBlue
        refreshControl.attributedTitle = NSAttributedString(string: "Получаю данные с сервера ...", attributes: nil)
    }
    
    func didPressButtonWith(name: String?, indexPath: IndexPath!) {
        if name == "settings" {
            performSegue(withIdentifier: "shlagbaumSettings", sender: FakeModel.shared.shlagbaumArray[indexPath.row])
        }
        
        if name == "open" {
            openBarrierWith(index: indexPath.row)
        }
        
        if name == "camera" {
            displayAlert("Раздел в разработке, попробуйте еще раз чуть позже")
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
