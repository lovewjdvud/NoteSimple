//
//  ViewController.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import UIKit
import RxSwift
import RxCocoa
import JJFloatingActionButton


class ViewController: UIViewController {

    
    
    
    let TableViewModel = TableViewMdoel()       // 테이블뷰 viewmpdel
    var disposbag = DisposeBag()
    
    
    
    let CellId = "TableViewCell" //TableViewCell
    
    

    
    @IBOutlet weak var TableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
 
        

        seting()
        
        
        AddButton()
        
        
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        TableView.reloadData()
    }
    
    
    override func setEditing (_ editing:Bool, animated:Bool)
    {
       super.setEditing(editing,animated:animated)
        if(self.isEditing)
       {
            self.editButtonItem.title = "완료"
       }else
       {
        self.editButtonItem.title = "편집"
       }
     }
    
    func AddButton()  {

        // edit버튼을 만들과 삭제 기능 추가하기 ,왼족으로 배치
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.editButtonItem.title = "편집"
       
        self.editButtonItem.tintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
       // self.navigationItem.leftBarButtonItem!.title = "Change"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        // 버튼 UI 시작
        let actionButton = JJFloatingActionButton()
        actionButton.buttonColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        actionButton.addItem(title: "", image: nil) { item in
//            let deTailVC = self.storyboard?.instantiateViewController(identifier: "DeTailView")
//            deTailVC?.modalTransitionStyle = .coverVertical
//            deTailVC?.modalPresentationStyle = .automatic
//            self.present(deTailVC!, animated: true, completion: nil)
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "DeTailView")
            
                   self.navigationController?.pushViewController(pushVC!, animated: true)
       
        }
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true

        // last 4 lines can be replaced with
        // actionButton.display(inViewController: self)
        
        // 버튼 UI 끝
    
        
    }
    
    // 시작시 셋팅 뷰
    func seting()  {
 
        
        TableViewModel.TableViewObservable
            .observe(on: MainScheduler.instance)
            .bind(to: TableView.rx.items(cellIdentifier: CellId ,cellType:
                TableViewCell.self)) { index, item, cell in
                cell.lablel_tableviewCell.text = "\(item.Content)"
              
            }
            .disposed(by: disposbag)
        
        
    }


}

