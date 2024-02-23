//
//  MyCollectionViewCell.swift
//  DragDropView-iOS
//
//  Created by Brilliant Dev on 23/2/24.
//

import Foundation
import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel(frame: contentView.bounds)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        layer.cornerRadius = 10
        contentView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = .orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
