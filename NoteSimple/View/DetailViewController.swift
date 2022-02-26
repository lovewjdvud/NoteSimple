//
//  DetailViewController.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewController

class DetailViewController: UIViewController {


    @IBOutlet weak var textview_detail: UITextView!
  
    
 
    
    var Sqllite = SqliteClass()
    var detailviewmodel = DetailViewMdoel()
    var viewmodel = TableViewMdoel()
    var disposeBag = DisposeBag()
    
    var lockornot = false
    var passWord = ""
  
    
  lazy var TableViewObservable = BehaviorSubject<UIBarButtonItem>(value: lockOffButton)
    
   lazy var aboutButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: nil)
  
    lazy var lockOffButton : UIBarButtonItem = { 
        let button =  UIBarButtonItem(image: UIImage(systemName: "lock.open"), style: .plain, target: self, action: #selector(lockButton(_:)))
        button.tag = 0
        return button
    }()
    
    lazy var  lockOnButton : UIBarButtonItem = {
        let button =   UIBarButtonItem(image: UIImage(systemName: "lock"), style: .plain, target: self, action: #selector(buttonPressed(_:)))
        button.tag = 1
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
        
        Detailsetting()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.passWord = ""
    }
    
    override func viewDidDisappear(_ animated: Bool) {

    }

    @objc private func buttonPressed(_ sender: Any) {
     //   Detaillockornot()

    }
    
    
    @objc private func lockButton(_ sender: Any) {
      
      
    }
    
    func Detailsetting()  {
    
        
        
        navigationItem.rightBarButtonItems = [aboutButton, lockOffButton]
        lockOffButton.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        aboutButton.tintColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        
     
        
        lockOffButton.rx.tap
                .subscribe(onNext:{ _ in
                    self.navigationItem.rightBarButtonItems = [self.aboutButton, self.lockOnButton]
                    self.lockornot = true
                })
                .disposed(by: disposeBag)
        
        
        lockOnButton.rx.tap
                .subscribe(onNext:{ _ in
                    self.navigationItem.rightBarButtonItems = [self.aboutButton, self.lockOffButton]
                    self.lockornot = false
                })
                .disposed(by: disposeBag)
        
        
        
        aboutButton.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self]  in
                //self?.Detaillockornot()
                self?.funcalert(NoteText: (self?.textview_detail.text)!)
                    .subscribe{ _ in
                    }
                    .disposed(by: self!.disposeBag)

            })
            .disposed(by: disposeBag)
        
    }
    
    
    func funcalert(NoteText:String) -> Completable {
     
        return  Completable.create { [weak self] completabl in
            
            guard NoteText != ""  else { return completabl(.completed) as! Disposable}
            
            print("detailview if문 들어가기전 \(self!.lockornot)")
            
        // 비밀번호가 있을 때
        if self!.lockornot {
            let art = UIAlertController(title: "비밀번호 입력", message: "비밀번호 꼭 기억해주세요", preferredStyle: .alert)
            art.addTextField()
            let Completed = UIAlertAction(title: "완료", style: .default, handler: { [weak self]  _ in
                self?.passWord = (art.textFields?[0].text)!
                
                // 비밀번호 입력이 안되었을때
                if self?.passWord == "" {
                let art2 = UIAlertController(title: "경고", message: "(비밀번호를 입력해주세요)", preferredStyle: .alert)
                let Cancel2 = UIAlertAction(title: "확인", style: .cancel  , handler: {  _ in
                   
                })
                    art2.view.tintColor = UIColor.red
                    art2.addAction(Cancel2)
                    self?.present(art2, animated: true, completion: nil)
                    print("detailview 비밀 번호가 입력 안되었을때")
                    // 비밀번호가 입력 되었을때
                } else {
                    
                    self?.viewmodel.insertTavleViewModelsds(Content: NoteText, Password: self!.passWord)
                    print("detailview 비밀 번호가 입력 되었을때1")
                    completabl(.completed)
                print("detailview 비밀 번호가 입력 되었을때2")
                }
                
            })
            let Cancel = UIAlertAction(title: "취소", style: .cancel ,  handler: {  _ in
             
            })
            
            
            art.addAction(Completed)
            art.addAction(Cancel)
            self?.present(art, animated: true, completion: nil)
            
            // 비밀번호가 없을때
        } else {
            self?.viewmodel.insertTavleViewModelsds(Content: NoteText, Password: self!.passWord)
            print("detailview 비밀 번호가 없을때 인서트1")
            completabl(.completed)
            print("detailview 비밀 번호가 입력 되었을때")
        }
        
        return Disposables.create {
            print("detailview Disposables.create")
            self?.navigationController?.popViewController(animated: true)
            
        }
        }
    }
    
    
    func Detaillockornot() {
        print("lockornot = \(lockornot)")
        if lockornot {
            let art = UIAlertController(title: "비밀번호 입력", message: "비밀번호 꼭 기억해주세요", preferredStyle: .alert)
            art.addTextField()
            let Completed = UIAlertAction(title: "완료", style: .default, handler: { [weak self]  _ in
                
                self?.passWord = (art.textFields?[0].text)!
                
                if self?.passWord == "" {
                let art2 = UIAlertController(title: "경고", message: "(비밀번호를 입력해주세요)", preferredStyle: .alert)
                let Cancel2 = UIAlertAction(title: "확인", style: .cancel)
                    art2.view.tintColor = UIColor.red
                    art2.addAction(Cancel2)
                    self?.present(art2, animated: true, completion: nil)
                    
                } else {
                    self?.insertdsds(passWord2: self!.passWord)
                }
                
            })
            let Cancel = UIAlertAction(title: "취소", style: .cancel)
            art.addAction(Completed)
            art.addAction(Cancel)
            self.present(art, animated: true, completion: nil)
            
        } else {
            insertdsds(passWord2: "")
        }
        
    }
    
    func insertdsds(passWord2: String?) {
        
        print("insertdsds")
      //  viewmodel.insertTavleViewModelsds(Content: textview_detail.text, Password: passWord2!)
        // self.navigationController?.popViewController(animated: true)
        
    }
  
    
    
    
}
