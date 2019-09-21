//
//  ViewController.swift
//  MatchEmUpGameTest
//

//

import UIKit
import CoreLocation


fileprivate let cellIdentifer = "CollectionViewCell"

class GameViewController: UIViewController {
    
    @IBOutlet weak var screenTitle: UILabel! {
        didSet {
            screenTitle.layer.shadowColor = UIColor.blue.cgColor
            screenTitle.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            screenTitle.layer.shadowOpacity = 2.0
            screenTitle.layer.shadowRadius = 2.0
        }
    }

    @IBOutlet weak var levelLabel: UILabel! {
        didSet {
            levelLabel.font = UIFont(name: "SFSlapstickComicShaded", size: 30)
            levelLabel.textColor = .red
            levelLabel.layer.shadowColor = UIColor.black.cgColor
            levelLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            levelLabel.layer.shadowOpacity = 2
            levelLabel.layer.shadowRadius = 1.0
            levelLabel.isHidden = true
          
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    var cardsImagesURLs: [String] = []
    var cards : [CardObject] = []
    var images: [UIImage] = []
    var levelNumber = 1 {
        didSet {
            imagesCount = levelNumber + 2
        }
    }
    var imagesCount = 3 {
        didSet {
            loadDefaultPhotos()
            startGameButtonDidTap()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
        
        
        if let _ = UserDefaults.standard.object(forKey: "level") {
           levelNumber = UserDefaults.standard.integer(forKey: "level")
        } else {
            levelNumber = 1
        }
        
    }
    
    
    func setupView() {
        
       // view.backgroundColor = backgroundColor
    }
    
  func loadDefaultPhotos() {
        images.removeAll()
        for i in 1...imagesCount {
            images.append(UIImage(named: "\(i)") ?? UIImage())
        }
    }

    
    func setupCollectionView() {
        collectionView.backgroundColor = .clear
        let view = UIView()
        view.backgroundColor = .clear
        collectionView.backgroundView = nil
        collectionView.delegate = self
        collectionView.dataSource = self
         collectionView.register(UINib(nibName: cellIdentifer, bundle: nil), forCellWithReuseIdentifier: cellIdentifer)
    }
    
    func setLevelLabel(text: String) {
        
        let strokeTextAttributes : [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strokeColor : UIColor.white,
            NSAttributedString.Key.foregroundColor : UIColor.red,
            
            NSAttributedString.Key.strokeWidth : -3.0,
            NSAttributedString.Key.font : UIFont(name: "SFSlapstickComic-BoldOblique", size: 30)!
            ] as [NSAttributedString.Key  : Any]
        
        let customizedText = NSMutableAttributedString(string: "Level \(text)",
                                                       attributes: strokeTextAttributes)
        levelLabel.attributedText = customizedText
        levelLabel.isHidden = false
        
        
    }
    

    
    func prepareCardsToGame() {
        loadDefaultPhotos()
        
        if images.count != imagesCount * 2 {
            images.append(contentsOf: images)
        }
        images = images.shuffled()
        cards.removeAll()
        images.forEach { (image) in
            let card = CardObject(image: image, isHidden: true)
            self.cards.append(card)
        }
        
        self.collectionView.reloadData()
    }
    
    @objc func startGameButtonDidTap() {
        

        prepareCardsToGame()
        collectionView.reloadData()
  
        
        setLevelLabel(text: "\(levelNumber)")

    }
    
    
    
    func checkCombination(for indexPath: IndexPath) {
        let selectedCards = cards.filter({!$0.isHidden})
        
        
        switch selectedCards.count {
        case 0:
            cards[indexPath.item].isHidden = false
            collectionView.reloadItems(at: [indexPath])
            
        case 1:
            guard let firstCard = selectedCards.first, let firstIndex = cards.indexes(of: firstCard).first,  firstIndex != indexPath.item else { return }
            cards[indexPath.item].isHidden = false
            collectionView.reloadItems(at: [indexPath])
            
            if selectedCards.first!.image == cards[indexPath.item].image {
                cards.remove(at: firstIndex)
                
                if indexPath.item > firstIndex {
                    cards.remove(at: indexPath.item - 1)
                } else {
                    cards.remove(at: indexPath.item)
                }
                
                
                collectionView.deleteItems(at: [IndexPath(item: firstIndex, section: 0),
                                                indexPath])
            }
            
        case 2:
            
            
            guard let firstCard = selectedCards.first, let firstIndex = cards.indexes(of: firstCard).first,
                let secondCard = selectedCards.last, let secondIndex = cards.indexes(of: secondCard).first,
                firstIndex != indexPath.item, secondIndex != indexPath.item
                
                else {
                    return
            }
            
            selectedCards.forEach({$0.isHidden = true})
            cards[indexPath.item].isHidden = false
            collectionView.reloadItems(at: [IndexPath(item: firstIndex, section: 0),
                                            IndexPath(item: secondIndex, section: 0),
                                            indexPath])
            
        default:
            break
        }
        
        checkWin()
        
    }
    
    func checkWin() {
        if cards.count > 0 { return }
   
        if levelNumber == 18 {
             self.showAlert("Congratulations!!!", andText: "You passed the game. You are very cool!!", buttonTitle: "OK")
        } else {
            self.showAlert("Congratulations!!!", andText: "You passed the level!", buttonTitle: "Play next")
                levelNumber = levelNumber + 1
            UserDefaults.standard.set(levelNumber, forKey: "level")
            UserDefaults.standard.synchronize()
        }

    }
}

extension GameViewController:  UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifer, for: indexPath) as! CollectionViewCell
        if indexPath.row < cards.count {
            cell.setUpCell(for: cards[indexPath.item])
        }
        return cell
    }
}

extension GameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        checkCombination(for: indexPath)
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width - 25)/4 - 3, height: (self.view.frame.width - 25)/4 - 3)   //grid 4x4
    }
}


