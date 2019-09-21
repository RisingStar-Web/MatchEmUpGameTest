//
//  CollectionViewCell.swift
//  MatchEmUpGameTest
//


import UIKit


protocol CollectionViewCellDelegate {
    func animationFinished()
}

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 8
            imageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var coverView: UIImageView! {
        didSet {
            coverView.layer.cornerRadius = 8
            coverView.layer.masksToBounds = true
            coverView.layer.borderWidth = 2
            coverView.layer.borderColor = UIColor.gray.cgColor
            coverView.layer.masksToBounds = true
            
        }
    }
    
    func setUpCell(for card: CardObject) {
        guard let image = card.image else {return}
        coverView.isHidden = !card.isHidden
        imageView.image = image
        
    }
    
    func showCell() {
        coverView.isHidden = true
    }
    
    func hideCell() {
        coverView.isHidden = false
    }
    
    override func prepareForReuse() {
        coverView.isHidden = false
        imageView.image = nil
    }
}

