//
//  SelectSizeView.swift
//  面试app
//
//  Created by 陈思 on 2020/2/24.
//  Copyright © 2020 chance. All rights reserved.
//

import UIKit

class SelectSizeView: UIViewController {
    
    var defCode = "20"
    var defNumber = 0
    
    var codeList = ["0"]
    var stockNumbweList = ["0":"0"]
    
    let dataList1 = [["saleAttr1Value":"实样黄","saleAttr1ValueCode":"20"],
                     ["saleAttr1Value":"耀眼蓝","saleAttr1ValueCode":"40"]]
    
    let dataList2 = [["saleAttr2ValueCode":"30","saleAttr2Value":"110/56"],
                     ["saleAttr2ValueCode":"32","saleAttr2Value":"120/60"],
                     ["saleAttr2ValueCode":"34","saleAttr2Value":"130/64"],
                     ["saleAttr2ValueCode":"36","saleAttr2Value":"140/68"],
                     ["saleAttr2ValueCode":"37","saleAttr2Value":"150/72"],
    ]
    
    let dataList3 = [["saleAttr2ValueCode":"30","saleAttr1ValueCode":"20","stockNum":"5"],
                     ["saleAttr2ValueCode":"37","saleAttr1ValueCode":"20","stockNum":"5"],
                     ["saleAttr2ValueCode":"30","saleAttr1ValueCode":"40","stockNum":"4"],
                     ["saleAttr2ValueCode":"32","saleAttr1ValueCode":"40","stockNum":"4"],
                     ["saleAttr2ValueCode":"34","saleAttr1ValueCode":"40","stockNum":"4"],
                     ["saleAttr2ValueCode":"36","saleAttr1ValueCode":"40","stockNum":"4"],
                     ["saleAttr2ValueCode":"37","saleAttr1ValueCode":"40","stockNum":"4"],
    ]
    
    func funSize(code:String) {
        var list = NSMutableArray()
        var numberList = NSMutableDictionary()
        for item in dataList3 {
            let data = item as? NSDictionary
            let code = data?.object(forKey: "saleAttr1ValueCode") as? String
            let valueCode = data?.object(forKey: "saleAttr2ValueCode")
            let number = data?.object(forKey: "stockNum")
            if code == defCode {
                list.add(valueCode as Any)
                numberList.setValue(number, forKey: valueCode as! String)
            }
        }
        codeList.removeAll()
        stockNumbweList.removeAll()
        codeList = NSArray.init(array: list) as! [String]
        stockNumbweList = NSDictionary.init(dictionary: numberList) as! [String : String]
    }
    
    
    lazy var btnY: UIButton = {
        let view = UIButton.init(type: UIButton.ButtonType.custom)
        view.backgroundColor = UIColor.yellow
        view.addTarget(self, action: #selector(buttonAction1(sender:)), for: UIControl.Event.touchUpInside)
        return view
    }()
    
    lazy var btnB: UIButton = {
        let view = UIButton.init(type: UIButton.ButtonType.custom)
        view.backgroundColor = UIColor.blue
        view.addTarget(self, action: #selector(buttonAction2(sender:)), for: UIControl.Event.touchUpInside)
        return view
    }()
    
    @objc func buttonAction1(sender: UIButton) {
        buyNumber.text = ""
        defCode = (dataList1.first as? NSDictionary)?.object(forKey: "saleAttr1ValueCode") as! String
        funSize(code: defCode)
        collectionView.reloadData()
    }
    @objc func buttonAction2(sender: UIButton) {
        buyNumber.text = ""
        defCode = (dataList1.last as? NSDictionary)?.object(forKey: "saleAttr1ValueCode") as! String
        funSize(code: defCode)
        collectionView.reloadData()
    }
    
    lazy var buyNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.blue
        label.layer.borderWidth = 1.0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var btnAdd: UIButton = {
        let view = UIButton.init(type: UIButton.ButtonType.custom)
        view.setTitle("+", for: UIControl.State.normal)
        view.setTitleColor(UIColor.black, for: UIControl.State.normal)
        view.addTarget(self, action: #selector(buttonAddAction(sender:)), for: UIControl.Event.touchUpInside)
        return view
    }()
    @objc func buttonAddAction(sender: UIButton) {
        let number = Int(buyNumber.text ?? "0") ?? 0
        if number < defNumber {
            buyNumber.text = String(number+1)
        }
    }
    
    lazy var btnReduce: UIButton = {
        let view = UIButton.init(type: UIButton.ButtonType.custom)
        view.setTitle("-", for: UIControl.State.normal)
        view.setTitleColor(UIColor.black, for: UIControl.State.normal)
        view.addTarget(self, action: #selector(buttonReduceAction(sender:)), for: UIControl.Event.touchUpInside)
        return view
    }()
    @objc func buttonReduceAction(sender: UIButton) {
        let number = Int(buyNumber.text ?? "0") ?? 0
        if number > 1 {
            buyNumber.text = String(number-1)
        }
    }
    
    let widthScreen = UIScreen.main.bounds.size.width
    
    lazy var collectionView: UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let width = (widthScreen) * 0.3
        layout.itemSize = CGSize.init(width: width, height: 20)
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        layout.scrollDirection = .vertical
        let view = UICollectionView.init(frame: CGRect.init(x: 0, y: 150, width: widthScreen, height: 50), collectionViewLayout: layout)
        self.view.addSubview(view)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.white
        view.register(SelectSizeCell.self, forCellWithReuseIdentifier: "SelectSizeCell")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        btnY.frame = CGRect.init(x: 20, y: 50, width: 50, height: 50)
        self.view.addSubview(btnY)
        btnB.frame = CGRect.init(x: 100, y: 50, width: 50, height: 50)
        self.view.addSubview(btnB)
        
        buyNumber.frame = CGRect.init(x: 100, y: 300, width: 100, height: 50)
        self.view.addSubview(buyNumber)
        btnReduce.frame = CGRect.init(x: 50, y: 300, width: 50, height: 50)
        self.view.addSubview(btnReduce)
        btnAdd.frame = CGRect.init(x: 200, y: 300, width: 50, height: 50)
        self.view.addSubview(btnAdd)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SelectSizeView: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList2.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectSizeCell", for: indexPath) as? SelectSizeCell else { return UICollectionViewCell() }
        
        let data2 = dataList2[indexPath.row] as? NSDictionary
        let code = data2?.object(forKey: "saleAttr2ValueCode") as? String ?? "0"
        cell.label.text = data2?.object(forKey: "saleAttr2Value") as? String
        if codeList.contains(code) {
            cell.label.textColor = UIColor.blue
        } else {
            cell.label.textColor = UIColor.gray
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data2 = dataList2[indexPath.row] as? NSDictionary
        let code = data2?.object(forKey: "saleAttr2ValueCode") as? String ?? "0"
        let number = stockNumbweList[code] as? String ?? "0"
        
        buyNumber.text = number
        defNumber = Int(number) ?? 0
    }
}
