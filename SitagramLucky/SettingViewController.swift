//
//  SettingViewController.swift
//  SitagramLucky
//
//  Created by Chareef on 18/11/2566 BE.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var valueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the initial value for the label
        slider.value = RandomManager.shared.currentRate
        updateValue()
    }

    func updateValue() {
        // Update the label text with the current slider value
        valueLabel.text = String(format: "%.1f", slider.value)
        RandomManager.shared.currentRate = slider.value
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        // Handle slider value changes here
        updateValue()
    }
    
    @IBAction func rate06Action(_ sender: UIButton) {
        slider.value = 0.6
        updateValue()
    }
    
    @IBAction func rate1Action(_ sender: UIButton) {
        slider.value = 1
        updateValue()
    }
    
    @IBAction func rate6Action(_ sender: UIButton) {
        slider.value = 6
        updateValue()
    }
    
    @IBAction func rate50Action(_ sender: UIButton) {
        slider.value = 50
        updateValue()
    }
    
    @IBAction func rate100Action(_ sender: UIButton) {
        slider.value = 100
        updateValue()
    }
    
}
