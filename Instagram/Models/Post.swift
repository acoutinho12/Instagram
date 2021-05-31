//
//  Post.swift
//  Instagram
//
//  Created by Andre Luis Barbosa Coutinho on 31/05/21.
//

import UIKit

struct Post {
    var user: User
    var post:UIImage
    var liked: Bool = false;
    var savedPost: Bool = false;
    var comments: [Comments]?
    var userComment: String?
    var description: String
}
