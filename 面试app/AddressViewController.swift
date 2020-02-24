//
//  AddressViewController.swift
//  面试app
//
//  Created by 陈思 on 2020/2/24.
//  Copyright © 2020 chance. All rights reserved.
//

import UIKit

class AddressViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(UINib.init(nibName: "AddressTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "AddressTableViewCell")
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = self.view.frame
        self.view.addSubview(tableView)
        
        // Do any additional setup after loading the view.
    }

}

extension AddressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AddressTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
        cell.reSetAddressBlock = {
            self.present(EditViewController(), animated: false, completion: nil)
        }
        return cell
    }
    
    
}
