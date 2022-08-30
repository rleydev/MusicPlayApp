//
//  FooterView.swift
//  MusicPlayApp
//
//  Created by Arthur Lee on 25.08.2022.
//

import UIKit

class FooterView: UIView {
    
    private var myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = UIColor(red: 162/255, green: 165/255, blue: 269/255, alpha: 1)
        label.textColor = .black
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpElements()
    }
    
    private func setUpElements() {
        addSubview(myLabel)
        addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            loader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            loader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            myLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            myLabel.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 8)
        ])
    }
    
    func showLoader() {
        loader.startAnimating()
        myLabel.text = "Loading"
    }
    
    func hideLoader() {
        loader.stopAnimating()
        myLabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
