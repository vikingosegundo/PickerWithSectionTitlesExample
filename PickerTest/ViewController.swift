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

    var pickerViewSource: BasePickerViewSource?
    
    @IBOutlet weak var pickerView: UIPickerView! {
        didSet{
            let pickerViewSource = AlternativePickerViewSource(pickerView: pickerView)
            
            pickerViewSource.selected = {
                selected in
                print("selected: \(selected)")
            }
            
            pickerViewSource.deselected = {
                deselected in
                print("deselected: \(deselected)")
            }
            
            self.pickerViewSource = pickerViewSource
        }
    }
}

