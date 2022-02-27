//
//  TableViewCell.swift
//  NoteSimple
//
//  Created by Songjeongpyeong on 2022/02/11.
//

import UIKit
import RxSwift

class TableViewCell: UITableViewCell ,passWordcell{
    
    var protocolpassword: String = ""
    

    @IBOutlet weak var lablel_tableviewCell: UILabel!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        
        
    }
  

}
