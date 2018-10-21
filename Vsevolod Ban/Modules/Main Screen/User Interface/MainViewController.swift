//
//  MainViewController.swift
//  Vsevolod Ban
//
//  Created by Vsevolod Ban on 10/21/18.
//  Copyright © 2018 Vsevolod Ban. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, Identifierable {
    
    var navigator = MainWireframe()
    var interactor = MainInteractor()
    
    private var urls: Array<URL?>?
    private var tasks = [URLSessionTask]()
    private var images: Array<UIImage?>?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handleTable()
        
        interactor.load(resource: Results.all) { [weak self] (result: Result<[URL?]>) in
            
            switch result {
                
            case .success(let urls):
                DispatchQueue.main.async {
                    // TODO: Sort maybe
                    self?.urls = urls
                    self?.images = Array.init(repeating: nil, count: urls.count)
                    self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
                }
                
            case .failure(let error):
                print(error)
                break
            }
            
//            DispatchQueue.main.async {
//
//                self?.tableView.reloadData()
//            }
        }
    }
    
    private func handleTable() {
        
        self.tableView.delegate = self
        self.tableView.prefetchDataSource = self
        self.tableView.dataSource = self // Also can create separated class but I dont have such a complex logic for now
        self.tableView.estimatedRowHeight = 500
        self.tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: PhotoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PhotoTableViewCell.identifier)
    }

    private func downloadImage(forItemAtIndex index: Int) {
        
//        guard urls.indices.contains(index) else { return }
        guard let url = urls?[index] else { return }
        
        guard tasks.index(where: { $0.originalRequest?.url == url }) == nil else {
            // We're already downloading the image.
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error)
            }
            
            if let data = data, let image = UIImage(data: data) {
                
                self.images?[index] = image
                let indexPath = IndexPath(row: index, section: 0)
                DispatchQueue.main.async {
                    if self.tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
                        
                        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
                    }
                }
            }
        }
        task.resume()
        tasks.append(task)
    }
    
    private func cancelDownloadingImage(forItemAtIndex index: Int) {
        
        guard let urls = urls,
            urls.indices.contains(index) else { return }
        guard let url = urls[index] else { return }
        guard let taskIndex = tasks.index(where: { $0.originalRequest?.url == url }) else {
            return
        }
        let task = tasks[taskIndex]
        task.cancel()
        tasks.remove(at: taskIndex)
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let urlsCount = urls?.count {
            
            return urlsCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        if let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier) as? PhotoTableViewCell,
            tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
        
        
            if let images = images,
                images.indices.contains(indexPath.row),
                let image = images[indexPath.row] {

                cell.thumb.image = image
                cell.thumb.clipsToBounds = true
                cell.thumb.contentMode = .scaleAspectFill
            } else { self.downloadImage(forItemAtIndex: indexPath.row) }
            
            cell.selectionStyle = .none
            return cell
        }
        
        return UITableViewCell()
    }
}

extension MainViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        indexPaths.forEach { self.downloadImage(forItemAtIndex: $0.row) }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
        indexPaths.forEach { self.cancelDownloadingImage(forItemAtIndex: $0.row) }
    }
}


