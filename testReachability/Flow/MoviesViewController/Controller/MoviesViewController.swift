//
//  MoviesViewController.swift
//  testReachability
//
//  Created by Mohamed Ali on 24/12/2023.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var mostpopularCollectionView: UICollectionView!
    @IBOutlet weak var recentlyRealeaseCollectionView: UICollectionView!
    
    var viewmodel = MoviesViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    var populars = Array<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        regesterCollection()
        subscribeToPopulars()
        fetchData()
    }
    
    func regesterCollection() {
        mostpopularCollectionView.registerNib(cell: PopularCell.self)
    }
    
    func subscribeToPopulars() {
        viewmodel.popularData.sink(receiveValue: { [weak self] data in
            guard let self = self else { return }
            self.populars = data
            self.mostpopularCollectionView.reloadData()
        }).store(in: &cancellable)
    }
    
    func fetchData() {
        viewmodel.fetchData()
    }
}


extension MoviesViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return populars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PopularCell = collectionView.dequeue(indexPath: indexPath) as PopularCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (0.8 * collectionView.frame.size.width), height: collectionView.frame.height)
    }
}
