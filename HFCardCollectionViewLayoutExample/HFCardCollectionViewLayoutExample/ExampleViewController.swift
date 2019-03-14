//
//  ExampleViewController.swift
//  HFCardCollectionViewLayoutExample
//
//  Created by Hendrik Frahmann on 28.10.16.
//  Copyright © 2016 Hendrik Frahmann. All rights reserved.
//

import UIKit
import HFCardCollectionViewLayout

struct CardInfo {
    var color: UIColor
    var icon: UIImage
    var eventName: String
}

class ExampleViewController : UICollectionViewController, HFCardCollectionViewLayoutDelegate {
    
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    
    @IBOutlet var backgroundView: UIView?
    @IBOutlet var backgroundNavigationBar: UINavigationBar?
    
    var cardLayoutOptions: CardLayoutSetupOptions?
    var shouldSetupBackgroundView = false
    
    var cardArray: [CardInfo] = []
    
    override func viewDidLoad() {
        self.setupExample()
        super.viewDidLoad()
    }
    
    // MARK: CollectionView
    
    func cardCollectionViewLayout(_ collectionViewLayout: HFCardCollectionViewLayout, willRevealCardAtIndex index: Int) {
        if let cell = self.collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? ExampleCollectionViewCell {
            cell.cardCollectionViewLayout = self.cardCollectionViewLayout
            cell.cardIsRevealed(true)
        }
    }
    
    func cardCollectionViewLayout(_ collectionViewLayout: HFCardCollectionViewLayout, willUnrevealCardAtIndex index: Int) {
        if let cell = self.collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as? ExampleCollectionViewCell {
            cell.cardCollectionViewLayout = self.cardCollectionViewLayout
            cell.cardIsRevealed(false)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cardArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! ExampleCollectionViewCell
        cell.backgroundColor = self.cardArray[indexPath.item].color
        cell.imageIcon?.image = self.cardArray[indexPath.item].icon
        cell.eventName?.text = self.cardArray[indexPath.item].eventName
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cardCollectionViewLayout?.revealCardAt(index: indexPath.item)
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempItem = self.cardArray[sourceIndexPath.item]
        self.cardArray.remove(at: sourceIndexPath.item)
        self.cardArray.insert(tempItem, at: destinationIndexPath.item)
    }
 
    // MARK: Actions
    
    @IBAction func goBackAction() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addCardAction() {
        let index = 0
        self.collectionView?.insertItems(at: [IndexPath(item: index, section: 0)])
        
        if(self.cardArray.count == 1) {
            self.cardCollectionViewLayout?.revealCardAt(index: index)
        }
    }
    
    @IBAction func deleteCardAtIndex0orSelected() {
        var index = 0
        if(self.cardCollectionViewLayout!.revealedIndex >= 0) {
            index = self.cardCollectionViewLayout!.revealedIndex
        }
        self.cardCollectionViewLayout?.flipRevealedCardBack(completion: {
            self.cardArray.remove(at: index)
            self.collectionView?.deleteItems(at: [IndexPath(item: index, section: 0)])
        })
    }
    
    // MARK: Private Functions
    
    private func setupExample() {
        if let cardCollectionViewLayout = self.collectionView?.collectionViewLayout as? HFCardCollectionViewLayout {
            self.cardCollectionViewLayout = cardCollectionViewLayout
        }
        if(self.shouldSetupBackgroundView == true) {
            self.setupBackgroundView()
        }
        if let cardLayoutOptions = self.cardLayoutOptions {
        
            self.cardCollectionViewLayout?.bottomNumberOfStackedCards = cardLayoutOptions.bottomNumberOfStackedCards
            self.cardCollectionViewLayout?.bottomStackedCardsShouldScale = cardLayoutOptions.bottomStackedCardsShouldScale
            //let count = cardLayoutOptions.numberOfCards
            
            
            
            self.cardArray.insert(createCardInfo(clr: UIColor.red, eventName: "BOENG!!"), at:0)
              self.cardArray.insert(createCardInfo(clr: UIColor.yellow, eventName: "BREXIT!!"), at:1)
              self.cardArray.insert(createCardInfo(clr: UIColor.green, eventName: "VOLKSWAGEN!!"), at:2)
        

        }
        self.collectionView?.reloadData()
    }
    
    private func createCardInfo(clr: UIColor, eventName: String) -> CardInfo {
        let icons: [UIImage] = [#imageLiteral(resourceName: "Icon1.pdf"), #imageLiteral(resourceName: "Icon2.pdf"), #imageLiteral(resourceName: "Icon3.pdf"), #imageLiteral(resourceName: "Icon4.pdf"), #imageLiteral(resourceName: "Icon5.pdf"), #imageLiteral(resourceName: "Icon6.pdf")]
        let icon = icons[Int(arc4random_uniform(6))]
        let newItem = CardInfo(color: clr, icon: icon, eventName: eventName)
        return newItem
    }
    
    private func setupBackgroundView() {
        if let collectionView = self.collectionView {
            collectionView.backgroundView = self.backgroundView
            self.backgroundNavigationBar?.shadowImage = UIImage()
            self.backgroundNavigationBar?.setBackgroundImage(UIImage(), for: .default)
        }
    }
    
}

