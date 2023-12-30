//
//  MoviesViewModel.swift
//  testReachability
//
//  Created by Mohamed Ali on 24/12/2023.
//

import Foundation
import Combine

class MoviesViewModel {
    
    var popularData = PassthroughSubject<[Int],Never>()
    
    func fetchData() {
        let strs = [1,2,3,4]
        popularData.send(strs)
    }
    
}
