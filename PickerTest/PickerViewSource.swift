//
//  PickerViewSource.swift
//  PickerTest
//
//  Created by Manuel Meyer on 30.12.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

class BasePickerViewSource: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    init(pickerView: UIPickerView) {
        super.init()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    var selected: (([String: Any]) -> Void)?
    
    let data = [
        ["title": "Group a", "selectable": false],
        ["title": "title a1", "selectable": true],
        ["title": "title a2", "selectable": true],
        ["title": "title a3", "selectable": true],
        ["title": "Group b", "selectable": false],
        ["title": "title b1", "selectable": true],
        ["title": "title b2", "selectable": true],
        ["title": "Group c", "selectable": false],
        ["title": "title c1", "selectable": true],
        ["title": "title c2", "selectable": true],
        ]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let d = data[row]
        if let selectable = d["selectable"] as? Bool, selectable == true {
            
            if let view = view as? ItemView, let title = d["title"] as? String{
                view.label.text = title
                return view
            }
            let view = ItemView()
            if let title = d["title"] as? String{
                view.label.text = title
                
            }
            return view
        }
        
        if let selectable = d["selectable"] as? Bool, selectable == false {
            if let view = view as? GroupView, let title = d["title"] as? String{
                view.label.text = title
                view.setNeedsLayout()
                return view
            }
            let view = GroupView()
            if let title = d["title"] as? String{
                view.label.text = title
                
            }
            return view
            
        }
        return UIView()
    }
}

class PickerViewSource: BasePickerViewSource {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var index = row
        if let selectable = data[row]["selectable"] as? Bool, selectable == false {
            index += 1
            pickerView.selectRow(index, inComponent: 0, animated: true)
        }
        selected?(data[index])
    }
}



class AlternativePickerViewSource: BasePickerViewSource {
    
    var selectedElement: [String:Any]?
    
    var deselected: (([String: Any]) -> Void)?

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if let element = selectedElement {
            deselected?(element)
            selectedElement = nil
        }
        
        if let selectable = data[row]["selectable"] as? Bool, selectable == true {
            let element = data[row]
            selectedElement = element
            selected?(element)
        }
       
    }
}
