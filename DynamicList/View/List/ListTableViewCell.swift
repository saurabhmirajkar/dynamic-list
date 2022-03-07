//
//  ListTableViewCell.swift
//  DynamicList
//
//  Created by Saurabh Mirajkar on 06/03/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    var logoImageView = UIImageView()
    var statusNameLabel = UILabel()
    
    var item : ListItem! {
        didSet {
            statusNameLabel.text = self.item.StationName
            logoImageView.load(urlString: self.item.Logo)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        logoImageView.backgroundColor = UIColor.systemGray
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        statusNameLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(logoImageView)
        contentView.addSubview(statusNameLabel)

        logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        statusNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        statusNameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10).isActive = true
        statusNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        statusNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
