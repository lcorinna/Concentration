//
//  SecondViewController.swift
//  Concentration
//
//  Created by Lashaun Corinna on 12/2/22.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        messageForWinner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    let resultOfTouches: Int
    
    func messageForWinner() {
        let message = UILabel()
        message.text = "🎉 Congratulations! 🎉\nYou have won in Concentration!\nYou used \(resultOfTouches) touches."
        message.translatesAutoresizingMaskIntoConstraints = false
        message.lineBreakMode = .byWordWrapping
        message.numberOfLines = 0
        message.textAlignment = .center
        
        self.view.addSubview(message)
        
        message.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        message.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        message.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    init(resultOfTouches: Int) {
        self.resultOfTouches = resultOfTouches
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
