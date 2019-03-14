// BLK Hackathon 2019
import UIKit
import HFCardCollectionViewLayout

struct CardInfo {
    var color: UIColor
    var icon: UIImage
    var eventName: String
    var eventDesc: String
    var mainImage: UIImage
    var eventNews: String

}

class ExampleViewController : UICollectionViewController, HFCardCollectionViewLayoutDelegate {
    
    
    @IBOutlet var pHoldings: [UILabel]!
    var cardCollectionViewLayout: HFCardCollectionViewLayout?
    
    func someFunction() {
        self.pHoldings[0].text = "text"
    }
    
    
    @IBAction func raiseOrder(_ sender: UIButton) {
        let alert = UIAlertController(title: "Order Submitted", message: " Thanks😊 #fiduciary ❤️ ", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default, handler: nil))
        
        // show the alert
    UIApplication.shared.keyWindow?.rootViewController?.present(alert,animated: true, completion: nil)
        
    }
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
        cell.mainChart?.image = self.cardArray[indexPath.item].mainImage
        cell.eventDesc?.text = self.cardArray[indexPath.item].eventDesc
        cell.eventNews?.text = self.cardArray[indexPath.item].eventNews
        
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
   
            guard let brexit = UIImage(named: "brexit") else {return}
            guard let boeing = UIImage(named: "boeing") else {return}
                guard let volks = UIImage(named: "volks") else {return}
            let rcolour = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
                        let ycolour = UIColor(red: 255.0/255.0, green: 195.0/255.0, blue: 18.0/255.0, alpha: 1.0)
                        let gcolour = UIColor(red: 120.0/255.0, green: 224.0/255.0, blue: 143.0/255.0, alpha: 1.0)
            self.cardArray.insert(createCardInfo(clr: rcolour, eventName: "Boeing", eventDesc: "Breaking news: Boeing stock price crashes by 13%", mainImage: boeing, eventNews:
                """
Boeing shares slumped almost 13 per cent on Monday after thesecond fatal crash of one if its 737 Max 8 planes.The sell-off wiped around $30bn (£23bn) wiped off. Boeing’s valuation leavingthe world’s largest plane manufacturer on track to record its biggest single-day trading fall in two decades as concerns mount about a possible technical problem with one of its models. All 157 passengers and crew aboard an Ethiopian Airlines flight died when the plane crashed shortly after take-off from Addis Ababa on Sunday morning.
"""), at:0)
            self.cardArray.insert(createCardInfo(clr: ycolour, eventName: "Brexit", eventDesc: "Sterling plummeted, U.S. dollar up", mainImage: brexit, eventNews:
            """
The pound has fallen to levels not seen since 1985 following the UK's referendum vote to leave the EU. Shares have also been hit. The FTSE 100 index began the day by falling more than 8%, then regained some ground to stand 2.5% lower. The more UK-focused FTSE 250 fared even worse, down 8% in early afternoon trading. Banks were hard hit, with Barclays and RBS falling about 30%, although they later pared losses to below 20%. The FTSE 100 ended the day 3.15% or 199.41 points lower.
"""), at:1)
            self.cardArray.insert(createCardInfo(clr: gcolour, eventName: "Volkswagen", eventDesc: "VW emissions scandal hits 11m vehicles", mainImage: volks, eventNews:
                """
Car giant Volkswagen has been fined €1bn (£880m) by German prosecutors over its diesel emissions scandal. The Braunschweig public prosecutor found VW had sold more than 10 million cars between mid-2007 and 2015 that had emissions-test-cheating software installed. The car firm said it did not plan to appeal against the fine. VW said it had admitted "its responsibility for the diesel crisis".
"""), at:2)
        

        }
        self.collectionView?.reloadData()
    }
    
    private func createCardInfo(clr: UIColor, eventName: String, eventDesc: String, mainImage: UIImage, eventNews: String) -> CardInfo {
        let icons: [UIImage] = [#imageLiteral(resourceName: "Icon1.pdf"), #imageLiteral(resourceName: "Icon2.pdf"), #imageLiteral(resourceName: "Icon3.pdf"), #imageLiteral(resourceName: "Icon4.pdf"), #imageLiteral(resourceName: "Icon5.pdf"), #imageLiteral(resourceName: "Icon6.pdf")]
        let icon = icons[Int(arc4random_uniform(6))]
        let newItem = CardInfo(color: clr, icon: icon, eventName: eventName, eventDesc: eventDesc, mainImage: mainImage, eventNews: eventNews)
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

