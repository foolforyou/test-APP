//
//  EditViewController.swift
//  面试app
//
//  Created by 陈思 on 2020/2/24.
//  Copyright © 2020 chance. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    var pickView = CityPickerView()
    let addBtn = UIButton.init(type: UIButton.ButtonType.custom)
    
    func setupPickView() -> Void {
        
        addBtn.frame = CGRect.init(x: 100, y: 350, width: 50, height: 50)
        addBtn.setTitle("确定", for: UIControl.State.normal)
        addBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        addBtn.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControl.Event.touchUpInside)
        view.addSubview(addBtn)
        
        pickView = CityPickerView.init(frame: CGRect(x: 10, y: 100, width: 394, height: 200))
        view.addSubview(pickView)
    }
    
    @objc func buttonAction(sender: UIButton) {
        let cell = tableView.cellForRow(at: NSIndexPath.init(row: 2, section: 0) as IndexPath) as? editCell
        let addressStr = String.init(format: "%@ %@ %@", pickView.provinceStr,pickView.citiesStr,pickView.areaStr)
        cell?.rightName.text = addressStr
        pickView.removeFromSuperview()
        addBtn.removeFromSuperview()
    }
    
    let leftNameList = ["收货人","电话","地址","地址详情"]

    lazy var tableView: UITableView = {
            let view = UITableView()
            view.delegate = self
            view.dataSource = self
            view.register(UINib.init(nibName: "editCell", bundle: Bundle.main), forCellReuseIdentifier: "editCell")
            return view
    }()
        

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = self.view.frame
        self.view.addSubview(tableView)
        
        // Do any additional setup after loading the view.
    }

}

extension EditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : editCell = tableView.dequeueReusableCell(withIdentifier: "editCell", for: indexPath) as! editCell
        
        cell.leftName.text = leftNameList[indexPath.row] 
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 2:
            setupPickView()
            break
        default:
            let cell = tableView.cellForRow(at: indexPath) as? editCell
            var inputText:UITextField = UITextField();
            let msgAlertCtr = UIAlertController.init(title: "提示", message: "请输入", preferredStyle: .alert)
            let ok = UIAlertAction.init(title: "确定", style:.default) { (action:UIAlertAction) ->() in
                if((inputText.text) != ""){
                    if indexPath.row == 1 {
                        if self.validateMobile(item: inputText.text ?? "")  {
                            cell?.rightName.text = inputText.text
                        } else {
                            print("请输入正确手机号")
                        }
                    } else {
                        cell?.rightName.text = inputText.text
                    }
                } else {
                    print("输入了空字符串")
                }
            }
            let cancel = UIAlertAction.init(title: "取消", style:.cancel) { (action:UIAlertAction) -> ()in
                print("取消输入")
            }
            msgAlertCtr.addAction(ok)
            msgAlertCtr.addAction(cancel)
            msgAlertCtr.addTextField { (textField) in
                inputText = textField

                inputText.placeholder = "输入数据"
            }
            self.present(msgAlertCtr, animated: true, completion: nil)
            break
        }
    }
    
    func validateMobile(item: String) -> Bool {
        let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: item)
    }
    
}
