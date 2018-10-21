//
//  MainViewController.swift
//  Vsevolod Ban
//
//  Created by Vsevolod Ban on 10/21/18.
//  Copyright © 2018 Vsevolod Ban. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, Identifierable {
    
    var navigator: MainWireframe?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func handleTable() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self // Also can create separated class but I dont have such a complex logic for now
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private struct Constants {
        
        static let splashScreenStoryboardName = "SplashScreen"
        static let tabBarStoryboardName = "TabBar"
        static let splashScreenStoryboardIdentifier = "SplashScreenViewController"
        static let tabBarStoryboardIdentifier = "TabBarViewController"
    }
}

extension MainViewController: UITableViewDelegate {
    
    
}

extension MainViewController: UITableViewDataSource {
    
    
}
