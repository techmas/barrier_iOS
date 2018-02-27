//
//  ShlagbaumTableVC.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 21.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit

class ShlagbaumTableVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension ShlagbaumTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        return cell
    }
    
    
    
    
    
}
