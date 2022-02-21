//
//  DetailViewController.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import UIKit
import RxSwift
class DetailViewController: UIViewController {


    @IBOutlet weak var textview_detail: UITextView!
    @IBOutlet weak var AboutBarButton: UIButton!
    
    var Sqllite = SqliteClass()
    var detailviewmodel = DetailViewMdoel()
    var viewmodel = TableViewMdoel()
    var disposeBag = DisposeBag()
   lazy var aboutButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(buttonPressed(_:)))
   lazy var  lockOffButton = UIBarButtonItem(image: UIImage(systemName: "lock.open"), style: .plain, target: self, action: #selector(lockButton(_:)))
   lazy var  lockOnButton = UIBarButtonItem(image: UIImage(systemName: "lock"), style: .plain, target: self, action: #selector(buttonPressed(_:)))

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItems = [aboutButton, lockOffButton]
      
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
//        disposeBag = DisposeBag()
//        viewmodel.loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
     //   viewmodel.loadData()
    }

    
    
    @objc private func buttonPressed(_ sender: Any) {
        
        
        
        
        //detailviewmodel.insertDetailViewModel(Content: textview_detail.text , Password: "")
     
       viewmodel.insertTavleViewModelsds(Content: textview_detail.text, Password: "")
       // Sqllite.InsetSqlite(Content: textview_detail.text, Password: "", insertdate: "2022-2-12")
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc private func lockButton(_ sender: Any) {
        
     
      
        self.navigationController?.popViewController(animated: true)
    }
    

    
    
  
    
    
    
}
