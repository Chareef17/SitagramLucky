//
//  ViewController.swift
//  SitagramLucky
//
//  Created by Chareef on 18/11/2566 BE.
//

import UIKit
import SwiftEntryKit

class ViewController: UIViewController {

    var RANDOM_NUMBER: CGFloat = 0.6
    
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        resultLabel.text = ""

    }

    func random() -> Bool {
        let randomValue = Double.random(in: 0.0..<100.0) // Generate a random number between 0.0 and 99.999999...
        return randomValue < Double(RandomManager.shared.currentRate)
    }
    
    @IBAction func randomAction(_ sender: UIButton) {
        Vibration.medium.vibrate()
        resultLabel.text = ""
        self.randomButton.isUserInteractionEnabled = false
        self.randomButton.shake { [weak self] in
            guard let self = self else { return }
            self.displayRewardPopup(self.random())
        }
    }
    
    @IBAction func settingAction(_ sender: UIButton) {
        let vc = SettingViewController(nibName: String(describing: SettingViewController.self), bundle: nil)
        self.present(vc, animated: true)
    }
 
    func displayRewardPopup(_ isSuccess: Bool) {
        let vc = RewardPopupViewController(nibName: String(describing: RewardPopupViewController.self), bundle: nil)
        vc.isSuccess = isSuccess
        
        var attributes = EKAttributes()
        attributes.windowLevel = .statusBar
        attributes.positionConstraints.safeArea = .overridden
        attributes.position = .center
        attributes.displayDuration = .infinity
        attributes.positionConstraints.size = EKAttributes.PositionConstraints.Size(width: .constant(value: UIScreen.main.bounds.width), height: .constant(value: UIScreen.main.bounds.height))
        attributes.screenBackground = .color(color: .init(UIColor.init(white: 0.0, alpha: 0.8)))
        attributes.entryInteraction = .absorbTouches
        
        DispatchQueue.main.async {
            SwiftEntryKit.display(entry: vc, using: attributes)
        }
        
        self.randomButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        self.randomButton.stopRotating()
        self.randomButton.isUserInteractionEnabled = true
    }
}

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

enum Vibration {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    case selection
    case oldSchool
    
    func vibrate() {
        
        switch self {
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case .oldSchool: break
            
        }
    }
    
}
