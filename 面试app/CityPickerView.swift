//
//  CityPickerView.swift
//  面试app
//
//  Created by 陈思 on 2020/2/24.
//  Copyright © 2020 chance. All rights reserved.
//

import UIKit

class CityPickerView: UIPickerView,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var baseCitiesArr = [[String]]()
    var baseAreaArr = [[[String]]]()
    
    var provinceArr: NSArray = []
    var citiesArr: NSArray = []
    var areaArr: NSArray = []
    var provinceStr = ""
    var citiesStr = ""
    var areaStr = ""
    var selectArr: NSArray = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupData()
        self.delegate = self
        self.dataSource = self
    }
    
    func setupData() -> Void {
        
        guard let jsonPath = Bundle.main.path(forResource: "city.json", ofType: nil) else {
            return
        }
        
        guard let jsonData = NSData(contentsOfFile: jsonPath) else {
            return
        }
        
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData as Data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
            return
        }
        
        guard let dicArray = anyObject as? [String:NSDictionary] else {
            return
        }
        let proArray = NSMutableArray()
        for (key, value) in dicArray {
            proArray.add(key)
            var cityArrayNew = [String]()
            var areaArrNew = [[String]]()
            for (key, value) in value as? [String:[String]] ?? ["":[]] {
                cityArrayNew.append(key)
                areaArrNew.append(value)
            }
            baseAreaArr.append(areaArrNew)
            baseCitiesArr.append(cityArrayNew)
        }
        
        provinceArr = NSArray.init(array: proArray)
        citiesArr = NSArray.init(array: baseCitiesArr.first ?? [])
        
        provinceStr = provinceArr.firstObject as! String
        citiesStr = citiesArr.firstObject as! String
        areaStr = baseAreaArr[0][0].first!
    }
    
    //MARK: UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return provinceArr.count
        }else if component == 1{
            return citiesArr.count
        }else{
            return areaArr.count
        }
    }
    
    //MARK: UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            
            citiesArr = baseCitiesArr[row] as NSArray
            areaArr = baseAreaArr[row].first! as NSArray
            
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }else if component == 1{
            
            let number = provinceArr.index(of: provinceStr)
            areaArr = baseAreaArr[number][row] as NSArray
            pickerView.reloadComponent(2)
            pickerView.selectRow(0, inComponent: 2, animated: true)
        }
        
        let provinceNum = pickerView.selectedRow(inComponent: 0)
        let cityNum = pickerView.selectedRow(inComponent: 1)
        let areaNum = pickerView.selectedRow(inComponent: 2)
        
        provinceStr = provinceArr[provinceNum] as! String
        citiesStr = citiesArr[cityNum] as! String
        if areaArr.count == 0 {
            areaStr = ""
        }else{
            areaStr = areaArr[areaNum] as! String
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        if component == 0 {
            label.text = provinceArr[row] as? String
        }else if component == 1{
            label.text = citiesArr[row] as? String
        }else{
            if areaArr.count == 0 {
                label.text = ""
            }else{
                label.text = areaArr[row] as? String
            }
        }
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
