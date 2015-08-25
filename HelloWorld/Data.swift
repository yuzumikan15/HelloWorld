//
//  Data.swift
//  HelloWorld
//
//  Created by Yuki Ishii on 2015/08/26.
//  Copyright (c) 2015年 Yuki Ishii. All rights reserved.
//

import Foundation
enum Level {
	case Beginner
	case Intermediate
	case Senior
	case Pro
	
	func toString() -> String {
		switch self {
		case .Beginner:
			return "Beginner"
		case .Intermediate:
			return "Intermediate"
		case .Senior:
			return "Senior"
		case .Pro:
			return "Pro"
		}
	}
}

struct StudyData {
	var category: String?
	var level: Level?
	var title: String?
	var author: String?
	var url: NSURL?
	var review: String?
}

// These data are only for mock
let ocaml1 = StudyData(category: "OCaml",
	level: .Beginner,
	title: "プログラミングの基礎",
	author: "浅井 健一",
	url: NSURL(string: "http://www.amazon.co.jp/dp/4781911609/ref=cm_sw_r_tw_dp_x9j3vb12SFTZ2"),
	review: "関数型プログラミング入門者のバイブル")

let ocaml2 = StudyData(category: "OCaml",
	level: .Intermediate,
	title: "プログラミング言語の基礎概念",
	author: "五十嵐 淳",
	url: NSURL(string: "http://www.amazon.co.jp/dp/4781912850/ref=cm_sw_r_tw_dp_k9j3vb1TBFM72"),
	review: "OCaml を用いた操作的意味論の学習本．Web 上で演習問題が解けるのが特徴．")

let haskell = StudyData(category: "Haskell",
	level: .Beginner,
	title: "すごいHaskell たのしく学ぼう",
	author: "Miran Lipovača",
	url: NSURL(string: "http://www.amazon.co.jp/dp/4274068854/ref=cm_sw_r_tw_dp_dck3vb02XMY0Z"),
	review: "Haskell 入門の決定版！")

let rails = StudyData(category: "Ruby on Rails",
	level: .Beginner,
	title: "Ruby on Rails チュートリアル 実例を使ってRailsを学ぼう",
	author: "Michael Hartl",
	url: NSURL(string: "http://railstutorial.jp/"),
	review: "Twitter のようなサービスを作ります．TDD をしっかりやるのでとてもよい入門です．")

var studyData = [ocaml1, ocaml2, haskell, rails]