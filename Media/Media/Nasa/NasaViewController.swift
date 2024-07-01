//
//  NasaViewController.swift
//  Media
//
//  Created by 아라 on 7/1/24.
//

import UIKit
import SnapKit

class NasaViewController: UIViewController {
    let nasaImageView = UIImageView()
    let progressLabel = UILabel()
    let requestButton = UIButton()
    var session = URLSession()
    var total: Double = 0.0
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            let present = result * 100
            progressLabel.text = "\(present) / 100"
            if present == 100.0 {
                requestButton.isEnabled = true
                print("dfkfkk")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 화면이 사라진다면 네트워크 통신도 바로 함께 중단
        // 다운로드중인 리소스 무시
        session.invalidateAndCancel()
        
        // 다운로드가 완료가 될 때까지 기다렸다가 완료되면 리소스 정리
        session.finishTasksAndInvalidate()
    }
    
    func configureView() {
        view.backgroundColor = .white
        requestButton.backgroundColor = .red
        nasaImageView.backgroundColor = .lightGray
        requestButton.addTarget(self, action: #selector(requestBtnDidTap), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(nasaImageView)
        view.addSubview(progressLabel)
        view.addSubview(requestButton)
    }
    
    func configureLayout() {
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(requestButton.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        nasaImageView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(progressLabel.snp.bottom).offset(20)
        }
    }

    @objc func requestBtnDidTap() {
        buffer = Data()
        nasaImageView.image = nil
        requestButton.isEnabled = false
        callRequest()
    }
    
    func callRequest() {
        let request = URLRequest(url: Nasa.photo)
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
            
        session.dataTask(with: request).resume()
    }
}

extension NasaViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print(#function, response)
        
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            let contentLength = response.value(forHTTPHeaderField: "Content-Length")!
            total = Double(contentLength) ?? 0.0
            return .allow
        } else {
            return .cancel
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        buffer?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error = error {
            progressLabel.text = "문제 발생!"
            nasaImageView.image = UIImage(systemName: "star")
        } else {
            guard let
                buffer = buffer else {
                print("buffer is nil")
                return
            }
            
            let image = UIImage(data: buffer)
            nasaImageView.image = image
        }
    }
}

extension NasaViewController {
    enum Nasa: String, CaseIterable {
        
        static let baseURL = "https://apod.nasa.gov/apod/image/"
        
        case one = "2308/sombrero_spitzer_3000.jpg"
        case two = "2212/NGC1365-CDK24-CDK17.jpg"
        case three = "2307/M64Hubble.jpg"
        case four = "2306/BeyondEarth_Unknown_3000.jpg"
        case five = "2307/NGC6559_Block_1311.jpg"
        case six = "2304/OlympusMons_MarsExpress_6000.jpg"
        case seven = "2305/pia23122c-16.jpg"
        case eight = "2308/SunMonster_Wenz_960.jpg"
        case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
         
        static var photo: URL {
            return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
        }
    }
}
