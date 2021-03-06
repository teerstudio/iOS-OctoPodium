//
//  Follow.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 27/03/16.
//  Copyright © 2016 Nuno Gonçalves. All rights reserved.
//

struct Twitter {

    enum TwitterClient : String {
        case Twitter = "twitter://user?screen_name="
        case TweetBot = "tweetbot://user_profile/"
        case Echofon = "echofon://user_timeline?"
        case TwittelatorPro = "twit://user?screen_name="
        case Seesmic = "x-seesmic://twitter_profile?twitter_screen_name="
        case Birdfeed = "x-birdfeed://user?screen_name="
        case Tweetings = "tweetings://user?screen_name="
        case SimplyTweet = "simplytweet://?link=http://twitter.com/"
        case IceBird = "icebird://user?screen_name="
        case Fluttr = "fluttr://user/"
        
        static func all() -> [TwitterClient] {
            return [Twitter, TweetBot, Echofon, TwittelatorPro, Seesmic,
                Birdfeed, Tweetings, SimplyTweet, IceBird, Fluttr]
        }
    }
    
    struct Follow {
        
        init(username: String) {
        
            var applicationOpened: Bool = false
            let application = UIApplication.sharedApplication()
            for twitterClient in TwitterClient.all() {
                let twitterUrl = "\(twitterClient.rawValue)\(username)"
                if let url = NSURL(string: twitterUrl) where application.canOpenURL(url) && !applicationOpened {
                    application.openURL(url)
                    Analytics.SendToGoogle.showDeveloperOnTwitterEvent(String(twitterClient))
                    applicationOpened = true
                    break
                }
            }
            
            if !applicationOpened {
                Analytics.SendToGoogle.showDeveloperOnTwitterEvent("Browser")
                Browser.openPage("http://twitter.com/\(username)")
            }
        }
    }
}