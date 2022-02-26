//
//  ViewController.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController
import JJFloatingActionButton


class ViewController: UIViewController {

    let TableViewModel = TableViewMdoel()       // 테이블뷰 viewmpdel
    var disposbag = DisposeBag()
    let CellId = "TableViewCell" //TableViewCell
    var noteitem: [NoteItem] = []
    lazy var TableViewObservables = BehaviorRelay<[NoteItem]>(value: [])
    
    lazy var edictButton = UIBarButtonItem(title: "편집", style: .plain, target: self, action: nil)
    lazy var edictCompletedButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: nil)
    
    
    @IBOutlet weak var TableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
  
 
    
        AddButton()
        seting()
        
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      //  TableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
       TableViewModel.loadData()
     
    }
    
//
//    override func setEditing (_ editing:Bool, animated:Bool)
//    {
//       super.setEditing(editing,animated:animated)
//        if(self.isEditing)
//       {
//            self.editButtonItem.title = "완료"
//       }else
//       {
//        self.editButtonItem.title = "편집"
//       }
//     }
//
    func AddButton()  {

        self.navigationItem.leftBarButtonItem = editButtonItem
        editButtonItem.tintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
       
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        // 버튼 UI 시작
        let actionButton = JJFloatingActionButton()
        actionButton.buttonColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        actionButton.addItem(title: "", image: nil) { item in
            
            let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "DeTailView")
                    
                   self.navigationController?.pushViewController(pushVC!, animated: true)
 
        }
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    
        
    }
    
    // 시작시 셋팅 뷰
    func seting()  {

        
        TableViewModel.TableViewObservable
            .observe(on: MainScheduler.instance)
            .filter { !$0.isEmpty }
            .bind(to: TableView.rx.items(cellIdentifier: CellId ,cellType:
                TableViewCell.self)) { index, item, cell in
                cell.lablel_tableviewCell?.text = "\(item.Content!)"
            }
            .disposed(by: disposbag)
        
        // 삭제
        Observable
            .zip(TableView.rx.itemDeleted, TableView.rx.modelDeleted(NoteItem.self))
            .map { "셀 선택 \($0),\n\($1)" }
            .subscribe (onNext : { index in
              
            })
            .disposed(by: disposbag)
        
        
        //선택이동
        TableView.rx.itemMoved
            .map { "아이템 이동 \n= \($0)" }
            .subscribe (onNext : { index in
                print("\(index) 최종 itemMoved")
            })
            .disposed(by: disposbag)
        
        editButtonItem.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.toggleEditMode()
            })
            .disposed(by: disposbag)
        
        
        Observable
            .zip(TableView.rx.itemSelected, TableView.rx.modelSelected(NoteItem.self))
            .map { "셀 선택 \($0),\n\($1)" }
            .subscribe (onNext : { index in
                print("\(index) 최종")
            })
            .disposed(by: disposbag)

        
    }

    private func toggleEditMode() {
        let toggleEditMode = !TableView.isEditing
        TableView.setEditing(toggleEditMode, animated: true)
    }

    
}

