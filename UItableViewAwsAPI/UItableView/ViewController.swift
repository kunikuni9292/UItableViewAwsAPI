//
//  ViewController.swift
//  UItableView
//
//  Created by 崎原邦達 on 2021/02/28.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

 
       
    let url = URL(string: "https://5xqq8vderh.execute-api.ap-northeast-1.amazonaws.com/Prod/practice")!
      var list = [Item]()
      @IBOutlet weak var tableView: UITableView!
      override func viewDidLoad() {
        super.viewDidLoad()
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("レスポンスエラー: \(error.localizedDescription)")
            return
          }
          guard let data = data, let response = response as? HTTPURLResponse else {
            print("レスポンスのデータが空です")
            return
          }
          if response.statusCode == 200 {
            do {
              let dto: [ItemDto] = try JSONDecoder().decode([ItemDto].self, from: data)
              for i in dto {
                let imgURL = URL(string: i.url)!
                let imgData = try Data(contentsOf: imgURL)
                self.list.append(Item(img: UIImage(data: imgData)!, title: i.title, subTitle: i.explain))
              }
              DispatchQueue.main.sync {
                self.tableView.reloadData()
              }
            } catch {
              print("Jsonデコードエラー")
            }
          } else {
            print("サーバー・エラー・ステータスコード: \(response.statusCode)")
          }
        }).resume()
      }


    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
      }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "item",for: indexPath)
        cell.textLabel?.text = list[indexPath.row].getTitle()
        cell.detailTextLabel?.text = list[indexPath.row].getSubTitle()
        cell.imageView?.image      = list[indexPath.row].getImg()
        return cell
     }
    
    

}

