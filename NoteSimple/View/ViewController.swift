//
//  ViewController.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import RxViewController
import JJFloatingActionButton
import Lottie



class ViewController: UIViewController {
 

   

    let actionButton = JJFloatingActionButton()

    let TableViewModel = TableViewMdoel()       // 테이블뷰 viewmpdel
    
    var disposbag = DisposeBag()
    let CellId = "TableViewCell" //TableViewCell
    var noteitem : NoteItem?
    var noteitemss : [NoteItem]? = []

    
    
    
    lazy var edictButton = UIBarButtonItem(title: "편집", style: .plain, target: self, action: nil)
    lazy var edictCompletedButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: nil)
    
    var DetailpassWord = ""
    
    @IBOutlet weak var TableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
 
        introscren()
    
        AddButton()
        seting()
        
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
      //  TableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
       TableViewModel.loadData()
     
    }
    
    func introscren()  {
        
        TableView.isHidden  = true
        actionButton.isHidden = true
        navigationController?.isNavigationBarHidden = true



      
        let animationView2 : AnimationView = {
        let animView = AnimationView(name: "lf30_editor_9qce0ujc")
        animView.frame = CGRect(x: 0, y: 0, width: 350, height: 500)
            animView.contentMode = .scaleToFill
       return animView
        }()
        
        view.addSubview(animationView2)
        animationView2.center = view.center
        
        // 애니매이션 끝나면 메인 등장
        animationView2.play{ (finish) in
            // 애니매이션 삭제
            animationView2.removeFromSuperview()
            self.TableView.isHidden  = false
            self.actionButton.isHidden = false
            self.navigationController?.isNavigationBarHidden = false
            
        }
    }
    
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
    func cellColor(itemcolor: String)  {
   
    }
    
    // 시작시 셋팅 뷰
    func seting()  {
        // 테이블뷰
        TableViewModel.TableViewObservable
            .observe(on: MainScheduler.instance)
            .bind(to: TableView.rx.items(cellIdentifier: CellId ,cellType:
                TableViewCell.self)) { index, item, cell in
                 
                cell.updateUI(item: item)
                self.cellColor(itemcolor: item.Color!)
                print("index = \(index) item = \(item)")
            }
            .disposed(by: disposbag)
        
        // 삭제
        TableView.rx.modelDeleted(NoteItem.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] noteit in
                self?.TableViewModel.deleteTavleViewModelsds(Id: "\(noteit.Id!)")
                self?.TableViewModel.loadData()
            }
            )
            .disposed(by: disposbag)
            
        //선택이동
        TableView.rx.itemMoved
            .subscribe (onNext : { [self] index in
                
                var noteitem =  TableViewModel.noteitem
                var items =  TableViewModel.TableViewObservable.value
                let item = items.remove(at: index.sourceIndex.row)
                           items.insert(item, at: index.destinationIndex.row)
                noteitem = items
                
                TableViewModel.TableViewObservable.accept(items)
                TableViewModel.alldeleteTavleViewModelsds()
                TableViewModel.SelectChangeupdateTavleViewModelsds(noteitem: noteitem)
           
            })
            .disposed(by: disposbag)

        // 제스처
        TableView.rx
            .anyGesture(.swipe(direction: .right))
            .when(.recognized)
            .subscribe(onNext: {[weak self] gesture in
               // let tapLocation = recognizer.locationInView(self.tableView)
                let tapLocation = gesture.location(in: self?.TableView)
                let tapIndexPath = self?.TableView.indexPathForRow(at: tapLocation)
      
                let noteitem =  self?.TableViewModel.noteitem[(tapIndexPath?[1])!]
                let itemid = noteitem?.Id!
                let itemColor = Int(noteitem!.Color!)
                
                let itemColorcount = self!.itemchang(colorCount: itemColor!)
                self?.TableViewModel.updateTavleViewModelsds(Content: (noteitem?.Content!)!, Password: (noteitem?.Password!)!, id: "\(itemid!)", updatedate: (noteitem?.Date)!, color:("\(String(describing: itemColorcount))"))
                                self?.TableViewModel.loadData()
            }
            )
            .disposed(by: disposbag)
        
        
        
        // edit버튼
        editButtonItem.rx.tap
            .subscribe(onNext: { [weak self] _ in
            
                self?.toggleEditMode()
                self?.TableViewModel.loadData()
            
            })
            .disposed(by: disposbag)
        
        // 선택 시
        TableView.rx.modelSelected(NoteItem.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] member in
                self?.presentDetail(of: member)
            })
            .disposed(by: disposbag)
    }
    
    func itemchang(colorCount: Int) -> Int {
        var color = colorCount + 1
        
    
        if color == 4 {
            color = 0
            return color
        }
        return color
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


class wjdvud : UIView {
    
}
