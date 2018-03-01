//
//  ShlagbaumTableVC.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 21.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit

class ShlagbaumTableVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

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
    
}

extension ShlagbaumTableVC: UITableViewDelegate, UITableViewDataSource, CellButtonsDelegate {
    
    func didPressButtonWith(name: String?, indexPath: IndexPath!) {
        if name == "settings" {
            performSegue(withIdentifier: "shlagbaumSettings", sender: FakeModel.shared.shlagbaumArray[indexPath.row])
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
        //cell.shlagbaumImageUIImage.image = shlagbaum.photo
        cell.shlagbaumNeedsUpdate = shlagbaum.needsUpdate
        
        cell.setShlagbaumPresentation()
        
        return cell
    }
    
    
}
