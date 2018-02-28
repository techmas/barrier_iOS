//
//  TabBarVC.swift
//  Privratnik
//
//  Created by Дмитрий Пичугин on 28.02.2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit

class TabBarVC: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func BarButtonPressed(_ sender: UIButton) {
        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        buttons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        sender.isSelected = true
        
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
    var shlagbaumViewController: UIViewController!
    var camerasViewController: UIViewController!
    var mapViewController: UIViewController!
    var walletViewController: UIViewController!
    var settingsViewController: UIViewController!
    var viewControllers: [UIViewController]!
    
    var selectedIndex: Int = 0 // Default selected VC at startup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        instantiateChildVCs()
        // Press 1 button to be selected (Home)
        buttons[selectedIndex].isSelected = true
        BarButtonPressed(buttons[selectedIndex])
        
    }

    func instantiateChildVCs() {
        
        let shlagbaumsStoryBoard = UIStoryboard(name: "Shlagbaum", bundle: nil)
        let camerasStoryBoard = UIStoryboard(name: "InDevelopment", bundle: nil)
        let mapStoryBoard = UIStoryboard(name: "InDevelopment", bundle: nil)
        let myWalletStoryBoard = UIStoryboard(name: "InDevelopment", bundle: nil)
        let settingsStoryBoard = UIStoryboard(name: "Settings", bundle: nil)
        
        shlagbaumViewController = shlagbaumsStoryBoard.instantiateViewController(withIdentifier: "MainScreenNavigationVC")
        camerasViewController = camerasStoryBoard.instantiateViewController(withIdentifier: "inDevelopmentVC")
        mapViewController = mapStoryBoard.instantiateViewController(withIdentifier: "inDevelopmentVC")
        walletViewController = myWalletStoryBoard.instantiateViewController(withIdentifier: "inDevelopmentVC")
        settingsViewController = settingsStoryBoard.instantiateViewController(withIdentifier: "settingsVC")
        
        viewControllers = [shlagbaumViewController, camerasViewController, mapViewController, walletViewController, settingsViewController ]
    }

}
