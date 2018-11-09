//
//  ConstStruct.swift
//  Share Beauty App
//
//  Created by koji on 2016/09/09.
//  Copyright © 2016年 AQUA Co., Ltd. All rights reserved.
//

struct Const {
    static let defaultRegionId = 2
    static let defaultCountryId = 6
    static let defaultLanguageId = 21
    static let databaseName = "shiseido-finder.db"
    static let databaseNameFormat = "shiseido-finder-%d-%d.db"

    static let isShowScreenSaver = false

    static let regionIdAmericas = 1
    static let regionIdAsia = 2

    static let CountryIdUs = 1
    static let CountryIdCanada = 2

    static let lineIdLX = 1                     //FUTURE SOLUTION LXのline_id
    static let lineIdUTM = 2                    //ULTIMUNのline_id
    static let lineIdBioPerformance = 8         //BIO-PERFORMANCEのline_id
    static let lineIdSHISEIDO = 16              //SHISEIDOのline_id
    static let lineIdSUNCARE = 17               //SUNCAREのline_id
    static let lineIdMAKEUP = 18                //MAKEUPのline_id
    static let lineIdWASO = 37                  //WASOのline_id

    static let tagSignatureBeauty = 5

    //static let urlSchemeSignatureBeauty = "sfslx2://"
     static let outAppInfoUTMMask = OutAppInfo(title: "UTM Mask", url: "https://shiseido:ultimune@shiseido-ultimune.kayac.cc/") //UTM MASK APP
    static let outAppInfoNavigator = OutAppInfo(title: "Navigator", url: "ssdcatalog://")
    static let outAppInfoUltimune = OutAppInfo(title: "Ultimune 2", url: "sad.sg.utm2://")
    static let outAppInfoUvInfo = OutAppInfo(title: "UVinfo", url: "ssduvi://")
    static let outAppInfoSoftener = OutAppInfo(title: "Softner", url: "ssdsoftner://")
    static let outAppInfoFoundation = OutAppInfo(title: "Foundation Finder", url: "ssdfdf://")// "jp.co.shiseido.gs.fdf")
    static let outAppInfoESSENTIAL = OutAppInfo(title: "Essential Energy", url: "ssdeeapp://")// "jp.co.shiseido.e1.line.app")


    static let screenIdCountrySetting = 2
    static let screenIdLanguageSetting = 3
    static let screenIdSetting = 4
    static let screenIdProductList = 9
    static let screenIdProductDetail = 10
    static let screenIdLineDetail = 12
    static let screenIdLineStep = 13
    static let screenIdSideMenu = 16
    static let screenIdProductDetailCommon = 17
    static let screenIdRecommend = 23
    static let screenIdOnTrendBeauty = 42
    static let screenIdTop = 7785
    static let screenIdAboutShiseidoImage = 7786
    static let screenIdLifeStyleBeauty = 7795
    static let screenIdLifeStyleBeautyA = 7796 //＜＜うっかり日焼け用＞＞7805
    static let screenIdLifeStyleBeautyB = 7797
    static let screenIdLifeStyleBeautyC = 7798
    static let screenIdLifeStyleBeautyD = 7799
    static let screenIdLifeStyleBeautyE = 7805
    static let screenIdLifeStyleBeautyF = 7818
    static let screenIdLifeStyleBeautyG = 7819
    static let screenIdLifeStyleBeautyH = 7820
    static let screenIdLifeStyleBeautyI = 7821
    static let screenIdIdealBeauty1 = 7789
    static let screenIdIdealBeauty2 = 7790
    static let screenIdIdealBeauty3 = 7791
    static let screenIdIdealBeauty4 = 7792
    static let screenIdTips = 7797
    static let screenIdIconicBeauty = 7800
    static let screenIdIconicTips = 7801
    static let screenIdScreenSaver = 7802
    static let screenIdLXTop = 7806
    static let screenIdLXProduct = 7807
    static let screenIdLXIngredience = 7808
    static let screenIdLXYUTAKA = 7809
    static let screenIdLXProductDetail = 7810
    static let screenIdLXUBSResult = 7811
    static let screenIdLXSensoryExperience = 7812
    static let screenIdLXSkingenecell = 7813
    static let screenIdLXGraph = 7814
    static let screenIdLXConcept = 7815
    static let screenIdLXTool = 7816
    static let screenIdAboutShiseido = 7786
    static let screenIdNewApproach = 7817

    static let itemIdBeautyTips = "503301"

    static let beautySecondIdMoisturizer = 7    //MoisturizerのID（beauty_second_id）
    static let stepLowerIdMoisturizer = 9    //MoisturizerのID（beauty_second_id）

    static let troubleDisplayStrong = 3
    static let troubleDisplayNormal = 2
    static let troubleDisplayHide = 1

    
    static let lifeStyleBeautyList:[Int] = [601, LanguageConfigure.UTMId, 602, 606, 553, 610, 611, 550, 609, 582, 583] // 613のみ 612はつかわないWaso t-hirai 19ss
    // 18AW
    // private var productIdsDefault:[Int] = [564,566,568,LanguageConfigure.UTMId, 570, 571, 578, 572]
    
    static let lifeStyleBeautyListA = [513, 252, 313]//[101, 359, 497]<<うっかりひやけ>>SMK追加コンテンツ　平井20170217（項目だけ書いています、アイテムはほぼ確定）
    static let lifeStyleBeautyListB = [497, 115, 511] //waso追加　平井20170217　（アイテムは暫定）115, 497, 511
    // static let lifeStyleBeautyListC = [372, 421]
    static let lifeStyleBeautyListC = [372, 421, 564, 566, 568, 570, 571, 572, 578] //LS アイコン表示 不足分追加
    static let lifeStyleBeautyListD = [533, LanguageConfigure.UTMId, 534] //34 ibuki　平井20170307>> LS専用アイテムとして登録
    static let lifeStyleBeautyListE = [313, 513] //[513, 252, 313]
    static let lifeStyleBeautyListF = [455, 101] //[101,  455]
    static let lifeStyleBeautyListG = [470, 567] //item 変更　t-hirai 0803 >>[553, 554, 556] 555,556はどちらか排他表示にしたいです。
    static let lifeStyleBeautyListH = [470, 500, 551]
    static let lifeStyleBeautyListI = [545, 549, 498]
    
    static let idealBeautyModalTrouble = [12, 14, 15, 7]
    static let productIdsUTM = [LanguageConfigure.UTMId, 28, 601]

    static let idealBeautyTypeProduct = 1
    static let idealBeautyTypeLine = 2
    
    // LatestMoisturizer
    static let latestMoisturizerList = [602, 614, 604, 605, 606, 607, 608]

    //BP
    static let bpMoisturizerAmericas = [345, 340, 468, 127,
                                44, 238,
                                361, 231, 439, 368, 67,
                                64, 469, 452,
                                52, 29, 34,
                                281, 352]
    static let bpMoisturizerAsia = [345, 340, 468, 127,
                                204, 169, 1,
                                44, 238,
                                361, 231, 439, 368, 67,
                                64, 469, 452,
                                52, 29, 34,
                                281, 352]

    static let productIdBrush = 30 //商品詳細のブラシタップで遷移する商品ID
    static let brushValidSecondBeautyId = [30, 31, 32, 34, 35, 36, 37, 38, 39, 40, 41, 42]

    // 画像なし悩みID
    static let troubleIdNotImage = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]

    static let productIdUtm = [LanguageConfigure.UTMId, 559, 560]
    static let productIdUtmEye = 28
    static let productIdIbuki = 495
    static let productIdWhiteLucentOnMakeUp = 496
    static let productIdWhiteLucentAllDay = 497
    static let productIdSunCareBBSports = 498
    static let productIdSunCareFragrance = [545, 546, 547, 548]
    static let productIdSunCarePerfectUv = [499, 549]
    static let productIdMakeUp = 501

    static let movieIdMakeUpMorning = 5890
    static let movieIdMakeUpEvening = 5892
    static let movieIdMakeUpNight = 5891
    
    static let lineHeightMyanmar: CGFloat = 30.0
    static let apiSendLog = "https://nscp-ga.heteml.jp/sab/applog.php"
    static let logActionTapItem = 1
    static let logActionTapProduct = 2


    static let userAgent = "Safari-iOS10-iPad"

    static let lifeStyleBeautyCountUrl = "https://nscp-ga.heteml.jp/sab/summary/summary.json"
    
    static let japaneaseLanguageIds = [14, 15, 35, 43, 64, 72, 80]
}
