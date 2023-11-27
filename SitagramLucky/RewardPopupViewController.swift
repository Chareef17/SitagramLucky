//
//  RewardPopupViewController.swift
//  SitagramLucky
//
//  Created by Chareef on 18/11/2566 BE.
//

import UIKit
import SwiftEntryKit

class RewardPopupViewController: UIViewController {
    
    @IBOutlet var rewardImageView: UIImageView!
    @IBOutlet var backgroundImageView: UIImageView!
    
    @IBOutlet var lblTitle: UILabel!
    var isSuccess: Bool = false
    private var animationTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.view.sendSubviewToBack(self.backgroundImageView)
        self.backgroundImageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setup()
    }
    
    func setup() {
        if self.isSuccess {
            setUpSuccess()
        } else {
            setUpFail()
        }
        
        setAnimation()
    }
    
    func setUpSuccess() {
        Vibration.success.vibrate()
        self.rewardImageView.image = UIImage(named: "IMG_9331")
        self.showSplash()
        
        let attrString = NSAttributedString(
            string: "ยินดีด้วยจ้า~",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.white,
                NSAttributedString.Key.foregroundColor: UIColor.green,
                NSAttributedString.Key.strokeWidth: -2.0,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: getTextSize())
            ]
        )
        
        lblTitle.attributedText = attrString
    }
    
    func setUpFail() {
        Vibration.error.vibrate()
        self.rewardImageView.image = UIImage(named: "9D15D3D9-6FA9-4693-91CE-FB7FF95FFEEF")
        self.backgroundImageView.alpha = 0
        
        let attrString = NSAttributedString(
            string: "เสียใจด้วยน้า T_T",
            attributes: [
                NSAttributedString.Key.strokeColor: UIColor.white,
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.strokeWidth: -2.0,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: getTextSize())
            ]
        )
        
        lblTitle.attributedText = attrString
    }
    
    func showSplash() {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: { (success) in
            self.backgroundImageView.startRotating(duration: 15)
        })
    }
    
    func hideSplash() {
        
        UIView.animate(withDuration: 0.1, animations: {
            self.backgroundImageView.alpha = 0
        }, completion: { (success) in
            //
        })
    }
    
    func setAnimation() {
        
        if #available(iOS 10.0, *) {
            let animationTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(2), repeats: true, block: { (time) in
                self.animationStart()
            })
        } else {
            let animationTimer = Timer.scheduledTimer(timeInterval: TimeInterval(3), target: self, selector: #selector(RewardPopupViewController.animationStart), userInfo: nil, repeats: true)
        }
        
        if #available(iOS 10.0, *) {
            let animationTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(1), repeats: true, block: { (time) in
                self.imageAnimationStart()
            })
        } else {
            let animationTimer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(RewardPopupViewController.imageAnimationStart), userInfo: nil, repeats: true)
        }
    }
    
    func getTextSize() -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            // Code for iPad
            print("Running on iPad")
            return 80.0
        } else {
            // Code for iPhone or other devices
            print("Running on iPhone or other devices")
            return 45.0
        }
    }
    
    
    @objc func animationStart() {
        self.lblTitle.tada(nil)
    }
    
    @objc func imageAnimationStart() {
        self.rewardImageView.tada(nil)
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        self.hideSplash()
        SwiftEntryKit.dismiss()
    }
    
}

extension UIView {
    func startRotating(duration: Double = 1) {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            animate.fromValue = 0.0
            animate.toValue = Float(Double.pi * 2.0)
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) != nil {
            self.layer.removeAnimation(forKey: kAnimationKey)
        }
    }
}
