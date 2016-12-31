//
//  ViewController.swift
//  PickerTest
//
//  Created by Manuel Meyer on 30.12.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class BaseView: UIView {
    var label: UILabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(label)
        label.frame = self.bounds
    }
}

class GroupView: BaseView {
    override func layoutSubviews() {
        super.layoutSubviews()
        label.backgroundColor = .orange
    }
    
}

class ItemView: BaseView {

}

class ViewController: UIViewController {
    enum ButtonState {
        case proceed
        case selectToProceed
    }

    var pickerViewSource: AlternativePickerViewSource?
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var pickerView: UIPickerView! {
        didSet{
            let pickerViewSource = AlternativePickerViewSource(pickerView: pickerView)
            
            pickerViewSource.selected = {
                [weak self] selected in
                guard let `self` = self else { return }
                self.configureButton(state: .proceed)
            }
            
            pickerViewSource.deselected = {
                [weak self] deselected in
                guard let `self` = self else { return }
                self.configureButton(state: .selectToProceed)
            }
            
            self.pickerViewSource = pickerViewSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton(state: .selectToProceed)
    }
    
    func configureButton(state:ButtonState) {
        switch state {
        case .proceed:
            if let pickerViewSource = pickerViewSource,
                let element = pickerViewSource.selectedElement,
                let title = element["title"] {
                button.setTitle("\(title) selected. Procced", for: .normal)
            }
            button.isEnabled = true
        case .selectToProceed:
            button.setTitle("select item to procced", for: .normal)
            button.isEnabled = false

        }

    }
    
}

