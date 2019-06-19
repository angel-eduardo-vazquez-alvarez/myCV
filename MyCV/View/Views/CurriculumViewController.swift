//
//  CVViewController.swift
//  MyCV
//
//  Created by Angel Eduardo Vazquez Alvarez on 6/20/19.
//  Copyright © 2019 Globant. All rights reserved.
//

import UIKit

class CurriculumViewController: UIViewController {
    
    // MARK: - Properties
    let curriculumViewModel = CurriculumViewModel(locator: UseCaseLocator.main)
    
    // MARK: - IBOutlets
    @IBOutlet weak var fullNameLabel: UILabel?
    @IBOutlet weak var ageLabel: UILabel?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var summaryLabel: UILabel?
    @IBOutlet weak var languagesStackView: UIStackView?
    @IBOutlet weak var programmingLanguagesStackView: UIStackView?
    @IBOutlet weak var workStackView: UIStackView?
    @IBOutlet weak var educationStackView: UIStackView?
    @IBOutlet weak var imageView: UIImageView?
    
    // MARK: - Height constraints
    @IBOutlet weak var languagesCard: RoundedView?
    @IBOutlet weak var programmingLanguagesCard: RoundedView?
    @IBOutlet weak var workCard: RoundedView?
    @IBOutlet weak var educationCard: RoundedView?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCardsHeight()
        configureCards()
        configureBasicInfo()
        configureUI()
    }
    
    // MARK: - Methods
    private func configureBasicInfo() {
        guard let fullNameLabel = fullNameLabel, let ageLabel = ageLabel, let locationLabel = locationLabel, let summaryLabel = summaryLabel else { return }
        
        let info = curriculumViewModel.basicInfo
        fullNameLabel.text = info.fullName
        ageLabel.text = "\(info.age)"
        locationLabel.text = info.city
        summaryLabel.text = info.summary
    }
    
    private func configureUI() {
        guard let imageView = imageView else { return }
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = imageView.bounds.size.height / 2
        imageView.layer.shadowPath = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: imageView.layer.cornerRadius).cgPath
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowColor = UIColor.lightGray.cgColor
        imageView.layer.shadowOpacity = 20
    }
    
    private func configureCardsHeight() {
        guard let languagesCard = languagesCard, let programmingLanguagesCard = programmingLanguagesCard, let workCard = workCard, let educationCard = educationCard else { return }
        
        let languageCardHeight = CGFloat(curriculumViewModel.heightForLanguageCard())
        let programmingCardHeight = CGFloat(curriculumViewModel.heightForProgrammingCard())
        let workCardHeight = CGFloat(curriculumViewModel.heightForWorkCard())
        let educationCardHeight = CGFloat(curriculumViewModel.heightForEducationCard())
        
        languagesCard.heightAnchor.constraint(equalToConstant: languageCardHeight).isActive = true
        programmingLanguagesCard.heightAnchor.constraint(equalToConstant: programmingCardHeight).isActive = true
        workCard.heightAnchor.constraint(equalToConstant: workCardHeight).isActive = true
        educationCard.heightAnchor.constraint(equalToConstant: educationCardHeight).isActive = true
    }
    
    private func configureCards() {
        configureLanguages()
        configureProgrammingLanguages()
        configureWork()
        configureEducation()
    }
    
    private func configureLanguages() {
        guard let languagesStackView = languagesStackView else { return }
        languagesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        var titleLabels = [UILabel]()
        
        for language in curriculumViewModel.languages {
            let nameLabel = UILabel()
            nameLabel.configure(text: language.name, alignment: .right, font: .systemFont(ofSize: 17, weight: .medium), contentHuggingPriority: 252)
            titleLabels.append(nameLabel)
            
            let levelLabel = UILabel()
            levelLabel.configure(text: language.level)
            
            let horizontalStackView = UIStackView()
            horizontalStackView.addArrangedSubview(nameLabel)
            horizontalStackView.addArrangedSubview(levelLabel)
            horizontalStackView.spacing = 20
            languagesStackView.addArrangedSubview(horizontalStackView)
        }

        configureConstraintsForStackViewTitleLabels(titleLabels)
    }
    
    private func configureProgrammingLanguages() {
        guard let programmingLanguagesStackView = programmingLanguagesStackView else { return }
        programmingLanguagesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        var titleLabels = [UILabel]()
        
        for language in curriculumViewModel.programmingLanguages {
            let nameLabel = UILabel()
            nameLabel.configure(text: language.name, alignment: .right, font: .systemFont(ofSize: 17, weight: .medium), contentHuggingPriority: 252)
            titleLabels.append(nameLabel)
            
            let levelLabel = UILabel()
            levelLabel.configure(text:  language.duration)
            
            let horizontalStackView = UIStackView()
            horizontalStackView.addArrangedSubview(nameLabel)
            horizontalStackView.addArrangedSubview(levelLabel)
            horizontalStackView.spacing = 20
            programmingLanguagesStackView.addArrangedSubview(horizontalStackView)
        }
        
        configureConstraintsForStackViewTitleLabels(titleLabels)
    }
    
    private func configureWork() {
        guard let workStackView = workStackView else { return }
        workStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        var titleLabels = [UILabel]()
        
        for work in curriculumViewModel.works {
            let nameLabel = UILabel()
            nameLabel.configure(text: NSLocalizedString("Name:", comment: "A name"), alignment: .right, font: .systemFont(ofSize: 17, weight: .medium), contentHuggingPriority: 252)
            titleLabels.append(nameLabel)
            
            let nameValueLabel = UILabel()
            nameValueLabel.adjustsFontSizeToFitWidth = true
            nameValueLabel.configure(text: work.name)
            
            let dateLabel = UILabel()
            dateLabel.configure(text: NSLocalizedString("Date:", comment: "A date from calendars"), alignment: .right, font: .systemFont(ofSize: 17, weight: .medium), contentHuggingPriority: 252)
            titleLabels.append(dateLabel)
            
            let dateValueLabel = UILabel()
            dateValueLabel.configure(text: "\(work.startDate) - \(work.endDate ?? "")")
            
            let roleLabel = UILabel()
            roleLabel.configure(text: NSLocalizedString("Role:", comment: "What someone does"), alignment: .right, font: .systemFont(ofSize: 17, weight: .medium), contentHuggingPriority: 252)
            titleLabels.append(roleLabel)
            
            let roleValueLabel = UILabel()
            roleValueLabel.configure(text: work.role)
            
            let nameStackView = UIStackView()
            nameStackView.addArrangedSubview(nameLabel)
            nameStackView.addArrangedSubview(nameValueLabel)
            nameStackView.spacing = 20
            let dateStackView = UIStackView()
            dateStackView.addArrangedSubview(dateLabel)
            dateStackView.addArrangedSubview(dateValueLabel)
            dateStackView.spacing = 20
            let roleStackView = UIStackView()
            roleStackView.addArrangedSubview(roleLabel)
            roleStackView.addArrangedSubview(roleValueLabel)
            roleStackView.spacing = 20
            workStackView.addArrangedSubview(nameStackView)
            workStackView.addArrangedSubview(dateStackView)
            workStackView.addArrangedSubview(roleStackView)
            
            let descriptionLabel = UILabel()
            descriptionLabel.configure(text: work.description, alignment: .justified, numberOfLines: 0)
            workStackView.addArrangedSubview(descriptionLabel)
            
            let separator = makeSeparator()
            workStackView.addArrangedSubview(separator)
        }
        
        configureConstraintsForStackViewTitleLabels(titleLabels)
    }
    
    private func configureEducation() {
        guard let educationStackView = educationStackView else { return }
        educationStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        var titleLabels = [UILabel]()
        
        for school in curriculumViewModel.educationValues {
            let nameLabel = UILabel()
            nameLabel.configure(text: NSLocalizedString("Name:", comment: "A name"), alignment: .right, font: .systemFont(ofSize: 17, weight: .medium), contentHuggingPriority: 252)
            titleLabels.append(nameLabel)
            
            let nameValueLabel = UILabel()
            nameValueLabel.configure(text: school.name)
            
            let degreeLabel = UILabel()
            degreeLabel.configure(text: NSLocalizedString("Degree:", comment: "School degree"), alignment: .right, font: .systemFont(ofSize: 17, weight: .medium), contentHuggingPriority: 252)
            titleLabels.append(degreeLabel)
            
            let degreeValueLabel = UILabel()
            degreeValueLabel.configure(text: school.degree)
            
            let dateLabel = UILabel()
            dateLabel.configure(text: NSLocalizedString("Date:", comment: "A date from calendars"), alignment: .right, font: .systemFont(ofSize: 17, weight: .medium), contentHuggingPriority: 252)
            titleLabels.append(dateLabel)
            
            let dateValueLabel = UILabel()
            dateValueLabel.configure(text: "\(school.startDate) - \(school.endDate ?? "")")
            
            let nameStackView = UIStackView()
            nameStackView.addArrangedSubview(nameLabel)
            nameStackView.addArrangedSubview(nameValueLabel)
            nameStackView.spacing = 20
            educationStackView.addArrangedSubview(nameStackView)
            
            let degreeStackView = UIStackView()
            degreeStackView.addArrangedSubview(degreeLabel)
            degreeStackView.addArrangedSubview(degreeValueLabel)
            degreeStackView.spacing = 20
            educationStackView.addArrangedSubview(degreeStackView)
            
            let dateStackView = UIStackView()
            dateStackView.addArrangedSubview(dateLabel)
            dateStackView.addArrangedSubview(dateValueLabel)
            dateStackView.spacing = 20
            educationStackView.addArrangedSubview(dateStackView)
            
            let separator = makeSeparator()
            educationStackView.addArrangedSubview(separator)
        }
        
        configureConstraintsForStackViewTitleLabels(titleLabels)
    }
}

private extension CurriculumViewController {
    func configureConstraintsForStackViewTitleLabels(_ labels: [UILabel]) {
        guard labels.count >= 2, let firstLabel = labels.first else { return }
        for i in 1 ..< labels.count {
            labels[i].widthAnchor.constraint(equalTo: firstLabel.widthAnchor, multiplier: 1).isActive = true
        }
    }
    
    func makeSeparator() -> UILabel {
        let separator = UILabel()
        separator.text = "————————"
        separator.textAlignment = .center
        separator.textColor = .lightGray
        return separator
    }
}

private extension UILabel {
    func configure(text: String, alignment: NSTextAlignment = .left, font: UIFont = UIFont.systemFont(ofSize: 17),
                   textColor: UIColor = .black, contentHuggingPriority: Float = 251, numberOfLines: Int = 1) {
        self.text = text
        self.textAlignment = alignment
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        setContentHuggingPriority(UILayoutPriority(contentHuggingPriority), for: .horizontal)
    }
}
