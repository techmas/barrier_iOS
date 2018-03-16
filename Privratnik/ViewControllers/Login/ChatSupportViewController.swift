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
    
    deinit {
        jivoSdk?.stop()
    }
    
    
    
    
    //MARK: IBAction
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}


extension ChatSupportViewController: JivoDelegate {
    func onEvent(_ name: String!, _ data: String!) {
        print("name: \(name) <> data: \(data)")
    }
}
