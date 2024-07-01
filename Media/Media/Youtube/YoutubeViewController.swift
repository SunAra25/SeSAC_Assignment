//
//  YoutubeViewController.swift
//  Media
//
//  Created by 아라 on 7/1/24.
//

import UIKit
import WebKit
import SnapKit
import Alamofire

final class YoutubeViewController: UIViewController {
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.navigationDelegate = self
        return view
    }()
    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    private let movieId: Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setHierachy()
        setConstraints()
        callRequest()
    }
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierachy() {
        view.addSubview(webView)
        view.addSubview(indicatorView)
    }
    
    func setConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func callRequest() {
        
        let url = APIURL.getYoutube + "\(movieId)/videos"
        let headers: HTTPHeaders = [
            "Authorization" : APIKey.auth,
            "accept" : "application/json"
        ]
        AF.request(url,
                   headers: headers).responseDecodable(of: YoutubResponse.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let value):
                let urlString = value.results.count < 1 ? "https://www.youtube.com" : "https://www.youtube.com/watch?v=" + value.results[0].key
                
                guard let url = URL(string: urlString) else { return }
                let request = URLRequest(url: url)
                webView.load(request)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension YoutubeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicatorView.stopAnimating()
    }
}
