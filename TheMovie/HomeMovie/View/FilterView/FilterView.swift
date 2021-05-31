//
//  FilterView.swift
//  TheMovie
//
//  Created by Nicolas Chavez on 30/05/21.
//

import Foundation
import UIKit


class FilterView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableviewLanguage: UITableView!
    @IBOutlet weak var rangeBarVoted: RangeSeekSlider!
    @IBOutlet weak var lblFilterVotedMin: UILabel!
    @IBOutlet weak var lblFilterVotedMax: UILabel!
    @IBOutlet weak var lblSelectLanguage: UILabel!
    @IBOutlet weak var switchAdults: UISwitch!
    @IBOutlet weak var heightTblLanguage: NSLayoutConstraint!
    
    var language:[Language] = []
    var selectLanguage = ""
    var includeAdult = false
    var viewController: HomeMovieViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        registerTableview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed("FilterView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    func registerTableview(){
        self.tableviewLanguage.separatorStyle = .none
        self.tableviewLanguage.delegate = self
        self.tableviewLanguage.dataSource = self
        self.tableviewLanguage.layer.cornerRadius = 6.0
        tableviewLanguage.register(UITableViewCell.self, forCellReuseIdentifier: "LanguageCell")
    }
    
    //MARK: - Actions
    
    @IBAction func actionCancel(_ sender:UIButton){
        self.removeFromSuperview()
    }
    
    @IBAction func actionApply(_ sender:UIButton){
        self.viewController?.actionApplyFilter(view: self)
        self.removeFromSuperview()
    }
    
    @IBAction func selectLanguage(_ sender:UIControl){
        self.heightTblLanguage.constant = 150
        self.tableviewLanguage.isHidden = false
    }
    
    @IBAction func actionHidden(_ sender:UIControl){
        self.heightTblLanguage.constant = 0
        self.tableviewLanguage.isHidden = true
    }
    
    @IBAction func actionInclude(_ sender:UISwitch){
        if sender.isOn {
            self.includeAdult = !self.includeAdult
        }else {
            self.includeAdult = !self.includeAdult
        }
    }
    
    //MARK: - UITableviewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return language.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath)
        cell.textLabel?.font = UIFont(name: "Avenir", size: 16)
        cell.textLabel?.text = language[indexPath.row].englishName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("holi")
        self.tableviewLanguage.isHidden = true
        self.heightTblLanguage.constant = 0
        self.lblSelectLanguage.text = language[indexPath.row].englishName
        self.selectLanguage = language[indexPath.row].iso639_1
    }
}
