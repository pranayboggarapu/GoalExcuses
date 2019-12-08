//
//  OnboardingCollectionController.swift
//  GoalExcuses
//
//  Created by Sai Venkata Pranay Boggarapu on 12/7/19.
//  Copyright © 2019 Sai Venkata Pranay Boggarapu. All rights reserved.
//

import UIKit

class OnboardingCollectionController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var pageData = OnboardingPageData()
    
    var prevButton: UIButton = {
        var preButton = UIButton()
        let subtitleText = NSMutableAttributedString(string: "PREV", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.gray])
        preButton.setAttributedTitle(subtitleText, for: .normal)
        preButton.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return preButton
    }()
    
    var nextButton: UIButton = {
        var nxtButton = UIButton()
        let subtitleText = NSMutableAttributedString(string: "NEXT", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        nxtButton.setAttributedTitle(subtitleText, for: .normal)
        nxtButton.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return nxtButton
    }()
    
    var pageControl: UIPageControl =  {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = UIColor.black
        pc.pageIndicatorTintColor = UIColor.lightGray
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControls()
        collectionView.backgroundColor = .red
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: "onboardingScreen")
        collectionView.isPagingEnabled = true
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
    }
    
    func setupBottomControls() {
        let bottomStackView = UIStackView(arrangedSubviews: [prevButton,pageControl,nextButton])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.distribution = .fillEqually
        bottomStackView.axis = .horizontal
        view.addSubview(bottomStackView)
        NSLayoutConstraint.activate([bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                    bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                    bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                    bottomStackView.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pageData.totalData.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageData.totalData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pageSpecificData = pageData.totalData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingScreen", for: indexPath) as! OnboardingCollectionViewCell
        cell.pageData = pageSpecificData
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
