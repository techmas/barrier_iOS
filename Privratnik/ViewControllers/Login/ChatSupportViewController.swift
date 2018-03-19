//
//  ChatSupportViewController.swift
//  Privratnik
//
//  Created by Захар Бабкин on 16/03/2018.
//  Copyright © 2018 Techmas. All rights reserved.
//

import UIKit

class ChatSupportViewController: UIViewController {
    
    
    //MARK: Variabels
    
    private var jivoSdk: JivoSdk?
    
    
    //MARK: IBOutlet
    
    @IBOutlet weak var webView: UIWebView!
    
    
    //MARK: View Controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBarButton()
        
        jivoSdk = JivoSdk(webView, "ru")
        jivoSdk?.delegate = self
        jivoSdk?.prepare()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        jivoSdk?.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        jivoSdk?.stop()
    }
    
    
    //MARK: IBAction
    
    @objc func back(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Methods
    
    func createBarButton(){
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back"), for: .normal)
        button.setTitle(" Назад", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
}


extension ChatSupportViewController: JivoDelegate {
    func onEvent(_ name: String!, _ data: String!) {
        print("name: \(name) <> data: \(data)")
    }
}
