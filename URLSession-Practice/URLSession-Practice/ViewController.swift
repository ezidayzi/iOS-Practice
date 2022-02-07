//
//  ViewController.swift
//  URLSession-Practice
//
//  Created by 김윤서 on 2022/02/06.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "http://apis.data.go.kr/B553748/CertImgListService/getCertImgListService?serviceKey=KJeZEeFZbu%2BlQy3OMv3FpnbLWrqM7mj8orXbKZQVAz%2FQe0ELaEIQnM%2BxY3NQY6k8%2BMi52M8Si%2B3Ys4bYV84o4w%3D%3D&returnType=json&numOfRows=100") else { return }
        HTTPClient.shared.request(url, method: .GET, parameters: nil, encoding: .URLEncoding, headers: nil)
            .subscribe { response in
                dump(response)
            }.disposed(by: disposeBag)
        
//        loadData()
    }

    func loadData() {
        let defaultSession = URLSession(configuration: .default)
        // 기본 세션 구성으로 초기화
    
        // URLSessionDataTask 변수 선언
        
        guard let url = URL(string: "http://apis.data.go.kr/B553748/CertImgListService/getCertImgListService?serviceKey=KJeZEeFZbu%2BlQy3OMv3FpnbLWrqM7mj8orXbKZQVAz%2FQe0ELaEIQnM%2BxY3NQY6k8%2BMi52M8Si%2B3Ys4bYV84o4w%3D%3D&returnType=json&numOfRows=100") else { return }
        
        let dataTask = defaultSession.dataTask(with: url) { data, response, error in
            // error가 존재하면 종료
            guard error == nil else { return }

            // status 코드가 200번대여야 성공적인 네트워크라 판단
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return
            }

            do {
                let result = try JSONDecoder().decode(Product.self, from: data)
                dump(result)
                
            } catch(let e) {
                print(e)
            }
            
        }
        
        dataTask.resume()
    }
}

extension Data {
    var prettyJson: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.withoutEscapingSlashes]),
              let prettyPrintedString = String(data: data, encoding:.utf8) else { return nil }

        return prettyPrintedString
    }
}
