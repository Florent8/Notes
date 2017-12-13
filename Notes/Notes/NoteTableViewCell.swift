//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by  on 28/11/2017.
//  Copyright © 2017 amacabr2. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelCreatedAt: UILabel!
    @IBOutlet weak var labelUpdatedAt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with note: Note) {
        labelTitle.text = note.getTitle()
        labelCreatedAt.text = note.getCreatedAtToString()
        labelUpdatedAt.text = note.getUpdatedAtToString()
    }
}
