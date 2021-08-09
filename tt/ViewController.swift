//
//  ViewController.swift
//  tt
//
//  Created by Diana Princess on 02.08.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let simpleTableIdentifier = "SimpleTableIdentifier"
    
    var numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    var helper: Int?
    
    var tableView = UITableView.init(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.frame = CGRect.init(origin: .zero, size: self.view.frame.size)
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: simpleTableIdentifier)
        if (cell == nil){
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: simpleTableIdentifier)
        }
        cell?.textLabel?.text = numbers[indexPath.row]
        cell?.selectionStyle = .none
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = NewViewController()
        var row: Int = indexPath.row
        helper = row+1
        newViewController.receivedInt = helper ?? 0
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

