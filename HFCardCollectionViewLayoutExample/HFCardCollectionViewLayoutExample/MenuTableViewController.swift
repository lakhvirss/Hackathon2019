// BLK Hackathon 2019

import UIKit

struct CardLayoutSetupOptions {
    var bottomNumberOfStackedCards: Int = 5
    var bottomStackedCardsShouldScale: Bool = true
    var numberOfCards: Int = 3
}

class MenuTableViewController: UITableViewController {
    
    var hideNavigationBar = false
    var hideToolBar = false
    
    var defaults = CardLayoutSetupOptions()
    var numberFormatter = NumberFormatter()
    
    @IBOutlet var textfieldBottomNumberOfStackedCards: UITextField?
    @IBOutlet var switchBottomStackedCardsShouldScale: UISwitch?

    override func viewDidLoad() {
        self.numberFormatter.locale = Locale(identifier: "en_US")
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.isToolbarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.keyWindow?.endEditing(true)
        self.navigationController?.isNavigationBarHidden = self.hideNavigationBar
        self.navigationController?.isToolbarHidden = self.hideToolBar
    }
    
    // MARK: Actions
    
    @IBAction func resetAction() {
        self.textfieldBottomNumberOfStackedCards?.text      = String(self.defaults.bottomNumberOfStackedCards)
        self.switchBottomStackedCardsShouldScale?.isOn      = self.defaults.bottomStackedCardsShouldScale
    }
    
    // MARK: Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ExampleViewController {
            
            var layoutOptions = CardLayoutSetupOptions()
            layoutOptions.numberOfCards = 3
        
            controller.cardLayoutOptions = layoutOptions
            
            self.hideNavigationBar = false
            self.hideToolBar = true
            }

    }
    
    // MARK: Private functions
    
    private func getIntFromTextfield(_ textfield: UITextField) -> Int {
        if let n = self.numberFormatter.number(from: (textfield.text)!) {
            return n.intValue
        }
        return 0
    }
    
    private func getFloatFromTextfield(_ textfield: UITextField) -> CGFloat {
        if let n = self.numberFormatter.number(from: (textfield.text)!) {
            return CGFloat(truncating: n)
        }
        return 0
    }
    
    private func stringFromFloat(_ float: CGFloat) -> String {
        return String(Int(float))
    }
    
}
