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
 

   
  

    let actionButton = JJFloatingActionButton()

    let TableViewModel = TableViewMdoel()       // 테이블뷰 viewmpdel
    var disposbag = DisposeBag()
    let CellId = "TableViewCell" //TableViewCell
    var noteitem : NoteItem?
    lazy var TableViewObservables = BehaviorRelay<[NoteItem]>(value: [])
    
    lazy var edictButton = UIBarButtonItem(title: "편집", style: .plain, target: self, action: nil)
    lazy var edictCompletedButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: nil)
    
    var DetailpassWord = ""
    
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
                cell.updateUI(item: item)
                
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
        
        TableView.rx.modelSelected(NoteItem.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] member in
              
               
                self?.presentDetail(of: member)
                
            })
            .disposed(by: disposbag)
    }
    
    private func presentDetail(of member: NoteItem) {
        guard let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "DeTailView") as? DetailViewController else {return}
        pushVC.selectNote = member
        pushVC.detailorno = true
        
        if member.Password == "" {
            self.navigationController?.pushViewController(pushVC, animated: true)
        } else{
            
            alert(of: member)
            
            
            
        }
    }
    
    func alert(of noteItem: NoteItem)  {
        
    // 비밀번호가 있을 때
        guard let pushVC = self.storyboard?.instantiateViewController(withIdentifier: "DeTailView") as? DetailViewController else {return}
     
        
        let art = UIAlertController(title: "비밀번호 입력", message: "비밀번호 꼭 기억해주세요", preferredStyle: .alert)
        art.addTextField()
        let Completed = UIAlertAction(title: "완료", style: .default, handler: { [weak self]  _ in
            self?.DetailpassWord = (art.textFields?[0].text)!
            
            // 비밀번호 입력이 안되었을때
            if self?.DetailpassWord == "" || noteItem.Password !=  self?.DetailpassWord  {
            let art2 = UIAlertController(title: "경고", message: "(비밀번호를 확인해주세요!)", preferredStyle: .alert)
            let Cancel2 = UIAlertAction(title: "확인", style: .cancel  , handler: {  _ in
               
            })
                art2.view.tintColor = UIColor.red
                art2.addAction(Cancel2)
                self?.present(art2, animated: true, completion: nil)
              
                // 비밀번호가 입력 되었을때
            } else if noteItem.Password ==  self?.DetailpassWord  {
                pushVC.selectNote = noteItem
                pushVC.detailorno = true
                self?.navigationController?.pushViewController(pushVC, animated: true)
            }
            
        })
        let Cancel = UIAlertAction(title: "취소", style: .cancel ,  handler: {  _ in
         
        })
        
        
        art.addAction(Completed)
        art.addAction(Cancel)
        self.present(art, animated: true, completion: nil)
        
        
    
    }


    private func toggleEditMode() {
        let toggleEditMode = !TableView.isEditing
        TableView.setEditing(toggleEditMode, animated: true)
    }

    
}

