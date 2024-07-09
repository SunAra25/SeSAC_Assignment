//
//  CityInfoViewModel.swift
//  Magazine
//
//  Created by 아라 on 7/9/24.
//

import Foundation

class CityInfoViewModel {
    var inputWholeTap = Observable<Void?>(nil)
    var inputDomesticTap = Observable<Void?>(nil)
    var inputOverseaTap = Observable<Void?>(nil)
    
    var outputShowWholeList = Observable<[City]>([])
    var outputShowDomesticList = Observable<[City]>([])
    var outputShowOverseaList = Observable<[City]>([])
    
    let list = CityInfo.city
    
    init() {
        inputWholeTap.bind { [weak self] _ in
            guard let self else { return }
            outputShowWholeList.value = list
        }
        
        inputDomesticTap.bind {  [weak self] _ in
            guard let self else { return }
            outputShowDomesticList.value = list.filter { $0.domestic_travel == true }
        }
        
        inputOverseaTap.bind {  [weak self] _ in
            guard let self else { return }
            outputShowOverseaList.value = list.filter { $0.domestic_travel == false }
        }
    }
}

class Observable<T> {
    var closure: ((T) -> Void)?
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
}
