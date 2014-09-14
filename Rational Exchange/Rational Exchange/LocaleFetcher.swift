//
//  LocaleFetcher.swift
//  Rational Exchange
//
//  Created by Charles Vestal on 9/7/14.
//  Copyright (c) 2014 vestal. All rights reserved.
//

import Foundation
import Alamofire


var localeListSingleton = LocaleList()

class LocaleList {
    
    var list:[Locale]
    let countryList = [
        Country(countryName: "Afghanistan", currencyName: "Afghanistan Afghani", currencyCode: "AFN"),
        Country(countryName: "Albania", currencyName: "Albanian Lek", currencyCode: "ALL"),
        Country(countryName: "Algeria", currencyName: "Algerian Dinar", currencyCode: "DZD"),
        Country(countryName: "American Samoa", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "Andorra", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Angola", currencyName: "Angolan Kwanza", currencyCode: "AOA"),
        Country(countryName: "Anguilla", currencyName: "East Caribbean Dollar", currencyCode: "XCD"),
        Country(countryName: "Antarctica", currencyName: "East Caribbean Dollar", currencyCode: "XCD"),
        Country(countryName: "Antigua and Barbuda", currencyName: "East Caribbean Dollar", currencyCode: "XCD"),
        Country(countryName: "Argentina", currencyName: "Argentine Peso", currencyCode: "ARS"),
        Country(countryName: "Armenia", currencyName: "Armenian Dram", currencyCode: "AMD"),
        Country(countryName: "Aruba", currencyName: "Aruban Guilder", currencyCode: "AWG"),
        Country(countryName: "Australia", currencyName: "Australian Dollar", currencyCode: "AUD"),
        Country(countryName: "Austria", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Azerbaijan", currencyName: "Azerbaijan New Manat", currencyCode: "AZN"),
        Country(countryName: "Bahamas", currencyName: "Bahamian Dollar", currencyCode: "BSD"),
        Country(countryName: "Bahrain", currencyName: "Bahraini Dinar", currencyCode: "BHD"),
        Country(countryName: "Bangladesh", currencyName: "Bangladeshi Taka", currencyCode: "BDT"),
        Country(countryName: "Barbados", currencyName: "Barbados Dollar", currencyCode: "BBD"),
        Country(countryName: "Belarus", currencyName: "Belarussian Ruble", currencyCode: "BYR"),
        Country(countryName: "Belgium", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Belize", currencyName: "Belize Dollar", currencyCode: "BZD"),
        Country(countryName: "Benin", currencyName: "CFA Franc BCEAO", currencyCode: "XOF"),
        Country(countryName: "Bermuda", currencyName: "Bermudian Dollar", currencyCode: "BMD"),
        Country(countryName: "Bhutan", currencyName: "Bhutan Ngultrum", currencyCode: "BTN"),
        Country(countryName: "Bolivia", currencyName: "Boliviano", currencyCode: "BOB"),
        Country(countryName: "Bosnia-Herzegovina", currencyName: "Marka", currencyCode: "BAM"),
        Country(countryName: "Botswana", currencyName: "Botswana Pula", currencyCode: "BWP"),
        Country(countryName: "Bouvet Island", currencyName: "Norwegian Krone", currencyCode: "NOK"),
        Country(countryName: "Brazil", currencyName: "Brazilian Real", currencyCode: "BRL"),
        Country(countryName: "British Indian Ocean Territory", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "Brunei Darussalam", currencyName: "Brunei Dollar", currencyCode: "BND"),
        Country(countryName: "Bulgaria", currencyName: "Bulgarian Lev", currencyCode: "BGN"),
        Country(countryName: "Burkina Faso", currencyName: "CFA Franc BCEAO", currencyCode: "XOF"),
        Country(countryName: "Burundi", currencyName: "Burundi Franc", currencyCode: "BIF"),
        Country(countryName: "Cambodia", currencyName: "Kampuchean Riel", currencyCode: "KHR"),
        Country(countryName: "Cameroon", currencyName: "CFA Franc BEAC", currencyCode: "XAF"),
        Country(countryName: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD"),
        Country(countryName: "Cape Verde", currencyName: "Cape Verde Escudo", currencyCode: "CVE"),
        Country(countryName: "Cayman Islands", currencyName: "Cayman Islands Dollar", currencyCode: "KYD"),
        Country(countryName: "Central African Republic", currencyName: "CFA Franc BEAC", currencyCode: "XAF"),
        Country(countryName: "Chad", currencyName: "CFA Franc BEAC", currencyCode: "XAF"),
        Country(countryName: "Chile", currencyName: "Chilean Peso", currencyCode: "CLP"),
        Country(countryName: "China", currencyName: "Yuan Renminbi", currencyCode: "CNY"),
        Country(countryName: "Christmas Island", currencyName: "Australian Dollar", currencyCode: "AUD"),
        Country(countryName: "Cocos (Keeling) Islands", currencyName: "Australian Dollar", currencyCode: "AUD"),
        Country(countryName: "Colombia", currencyName: "Colombian Peso", currencyCode: "COP"),
        Country(countryName: "Comoros", currencyName: "Comoros Franc", currencyCode: "KMF"),
        Country(countryName: "Congo", currencyName: "CFA Franc BEAC", currencyCode: "XAF"),
        Country(countryName: "Congo, Dem. Republic", currencyName: "Francs", currencyCode: "CDF"),
        Country(countryName: "Cook Islands", currencyName: "New Zealand Dollar", currencyCode: "NZD"),
        Country(countryName: "Costa Rica", currencyName: "Costa Rican Colon", currencyCode: "CRC"),
        Country(countryName: "Croatia", currencyName: "Croatian Kuna", currencyCode: "HRK"),
        Country(countryName: "Cuba", currencyName: "Cuban Peso", currencyCode: "CUP"),
        Country(countryName: "Cyprus", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Czech Rep.", currencyName: "Czech Koruna", currencyCode: "CZK"),
        Country(countryName: "Denmark", currencyName: "Danish Krone", currencyCode: "DKK"),
        Country(countryName: "Djibouti", currencyName: "Djibouti Franc", currencyCode: "DJF"),
        Country(countryName: "Dominica", currencyName: "East Caribbean Dollar", currencyCode: "XCD"),
        Country(countryName: "Dominican Republic", currencyName: "Dominican Peso", currencyCode: "DOP"),
        Country(countryName: "Ecuador", currencyName: "Ecuador Sucre", currencyCode: "ECS"),
        Country(countryName: "Egypt", currencyName: "Egyptian Pound", currencyCode: "EGP"),
        Country(countryName: "El Salvador", currencyName: "El Salvador Colon", currencyCode: "SVC"),
        Country(countryName: "Equatorial Guinea", currencyName: "CFA Franc BEAC", currencyCode: "XAF"),
        Country(countryName: "Eritrea", currencyName: "Eritrean Nakfa", currencyCode: "ERN"),
        Country(countryName: "Estonia", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Ethiopia", currencyName: "Ethiopian Birr", currencyCode: "ETB"),
        Country(countryName: "European Union", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Falkland Islands (Malvinas)", currencyName: "Falkland Islands Pound", currencyCode: "FKP"),
        Country(countryName: "Faroe Islands", currencyName: "Danish Krone", currencyCode: "DKK"),
        Country(countryName: "Fiji", currencyName: "Fiji Dollar", currencyCode: "FJD"),
        Country(countryName: "Finland", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "France", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "French Guiana", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "French Southern Territories", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Gabon", currencyName: "CFA Franc BEAC", currencyCode: "XAF"),
        Country(countryName: "Gambia", currencyName: "Gambian Dalasi", currencyCode: "GMD"),
        Country(countryName: "Georgia", currencyName: "Georgian Lari", currencyCode: "GEL"),
        Country(countryName: "Germany", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Ghana", currencyName: "Ghanaian Cedi", currencyCode: "GHS"),
        Country(countryName: "Gibraltar", currencyName: "Gibraltar Pound", currencyCode: "GIP"),
        Country(countryName: "Great Britain", currencyName: "Pound Sterling", currencyCode: "GBP"),
        Country(countryName: "Greece", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Greenland", currencyName: "Danish Krone", currencyCode: "DKK"),
        Country(countryName: "Grenada", currencyName: "East Carribean Dollar", currencyCode: "XCD"),
        Country(countryName: "Guadeloupe (French)", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Guam (USA)", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "Guatemala", currencyName: "Guatemalan Quetzal", currencyCode: "QTQ"),
        Country(countryName: "Guernsey", currencyName: "Pound Sterling", currencyCode: "GGP"),
        Country(countryName: "Guinea", currencyName: "Guinea Franc", currencyCode: "GNF"),
        Country(countryName: "Guinea Bissau", currencyName: "Guinea-Bissau Peso", currencyCode: "GWP"),
        Country(countryName: "Guyana", currencyName: "Guyana Dollar", currencyCode: "GYD"),
        Country(countryName: "Haiti", currencyName: "Haitian Gourde", currencyCode: "HTG"),
        Country(countryName: "Heard Island and McDonald Islands", currencyName: "Australian Dollar", currencyCode: "AUD"),
        Country(countryName: "Honduras", currencyName: "Honduran Lempira", currencyCode: "HNL"),
        Country(countryName: "Hong Kong", currencyName: "Hong Kong Dollar", currencyCode: "HKD"),
        Country(countryName: "Hungary", currencyName: "Hungarian Forint", currencyCode: "HUF"),
        Country(countryName: "Iceland", currencyName: "Iceland Krona", currencyCode: "ISK"),
        Country(countryName: "India", currencyName: "Indian Rupee", currencyCode: "INR"),
        Country(countryName: "Indonesia", currencyName: "Indonesian Rupiah", currencyCode: "IDR"),
        Country(countryName: "Iran", currencyName: "Iranian Rial", currencyCode: "IRR"),
        Country(countryName: "Iraq", currencyName: "Iraqi Dinar", currencyCode: "IQD"),
        Country(countryName: "Ireland", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Isle of Man", currencyName: "Pound Sterling", currencyCode: "GBP"),
        Country(countryName: "Israel", currencyName: "Israeli New Shekel", currencyCode: "ILS"),
        Country(countryName: "Italy", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Ivory Coast", currencyName: "CFA Franc BCEAO", currencyCode: "XOF"),
        Country(countryName: "Jamaica", currencyName: "Jamaican Dollar", currencyCode: "JMD"),
        Country(countryName: "Japan", currencyName: "Japanese Yen", currencyCode: "JPY"),
        Country(countryName: "Jersey", currencyName: "Pound Sterling", currencyCode: "GBP"),
        Country(countryName: "Jordan", currencyName: "Jordanian Dinar", currencyCode: "JOD"),
        Country(countryName: "Kazakhstan", currencyName: "Kazakhstan Tenge", currencyCode: "KZT"),
        Country(countryName: "Kenya", currencyName: "Kenyan Shilling", currencyCode: "KES"),
        Country(countryName: "Kiribati", currencyName: "Australian Dollar", currencyCode: "AUD"),
        Country(countryName: "Korea-North", currencyName: "North Korean Won", currencyCode: "KPW"),
        Country(countryName: "Korea-South", currencyName: "Korean Won", currencyCode: "KRW"),
        Country(countryName: "Kuwait", currencyName: "Kuwaiti Dinar", currencyCode: "KWD"),
        Country(countryName: "Kyrgyzstan", currencyName: "Som", currencyCode: "KGS"),
        Country(countryName: "Laos", currencyName: "Lao Kip", currencyCode: "LAK"),
        Country(countryName: "Latvia", currencyName: "Latvian Lats", currencyCode: "LVL"),
        Country(countryName: "Lebanon", currencyName: "Lebanese Pound", currencyCode: "LBP"),
        Country(countryName: "Lesotho", currencyName: "Lesotho Loti", currencyCode: "LSL"),
        Country(countryName: "Liberia", currencyName: "Liberian Dollar", currencyCode: "LRD"),
        Country(countryName: "Libya", currencyName: "Libyan Dinar", currencyCode: "LYD"),
        Country(countryName: "Liechtenstein", currencyName: "Swiss Franc", currencyCode: "CHF"),
        Country(countryName: "Lithuania", currencyName: "Lithuanian Litas", currencyCode: "LTL"),
        Country(countryName: "Luxembourg", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Macau", currencyName: "Macau Pataca", currencyCode: "MOP"),
        Country(countryName: "Macedonia", currencyName: "Denar", currencyCode: "MKD"),
        Country(countryName: "Madagascar", currencyName: "Malagasy Franc", currencyCode: "MGF"),
        Country(countryName: "Malawi", currencyName: "Malawi Kwacha", currencyCode: "MWK"),
        Country(countryName: "Malaysia", currencyName: "Malaysian Ringgit", currencyCode: "MYR"),
        Country(countryName: "Maldives", currencyName: "Maldive Rufiyaa", currencyCode: "MVR"),
        Country(countryName: "Mali", currencyName: "CFA Franc BCEAO", currencyCode: "XOF"),
        Country(countryName: "Malta", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Marshall Islands", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "Martinique (French)", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Mauritania", currencyName: "Mauritanian Ouguiya", currencyCode: "MRO"),
        Country(countryName: "Mauritius", currencyName: "Mauritius Rupee", currencyCode: "MUR"),
        Country(countryName: "Mayotte", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Mexico", currencyName: "Mexican Nuevo Peso", currencyCode: "MXN"),
        Country(countryName: "Micronesia", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "Moldova", currencyName: "Moldovan Leu", currencyCode: "MDL"),
        Country(countryName: "Monaco", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Mongolia", currencyName: "Mongolian Tugrik", currencyCode: "MNT"),
        Country(countryName: "Montenegro", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Montserrat", currencyName: "East Caribbean Dollar", currencyCode: "XCD"),
        Country(countryName: "Morocco", currencyName: "Moroccan Dirham", currencyCode: "MAD"),
        Country(countryName: "Mozambique", currencyName: "Mozambique Metical", currencyCode: "MZN"),
        Country(countryName: "Myanmar", currencyName: "Myanmar Kyat", currencyCode: "MMK"),
        Country(countryName: "Namibia", currencyName: "Namibian Dollar", currencyCode: "NAD"),
        Country(countryName: "Nauru", currencyName: "Australian Dollar", currencyCode: "AUD"),
        Country(countryName: "Nepal", currencyName: "Nepalese Rupee", currencyCode: "NPR"),
        Country(countryName: "Netherlands", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Netherlands Antilles", currencyName: "Netherlands Antillean Guilder", currencyCode: "ANG"),
        Country(countryName: "New Caledonia (French)", currencyName: "CFP Franc", currencyCode: "XPF"),
        Country(countryName: "New Zealand", currencyName: "New Zealand Dollar", currencyCode: "NZD"),
        Country(countryName: "Nicaragua", currencyName: "Nicaraguan Cordoba Oro", currencyCode: "NIO"),
        Country(countryName: "Niger", currencyName: "CFA Franc BCEAO", currencyCode: "XOF"),
        Country(countryName: "Nigeria", currencyName: "Nigerian Naira", currencyCode: "NGN"),
        Country(countryName: "Niue", currencyName: "New Zealand Dollar", currencyCode: "NZD"),
        Country(countryName: "Norfolk Island", currencyName: "Australian Dollar", currencyCode: "AUD"),
        Country(countryName: "Northern Mariana Islands", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "Norway", currencyName: "Norwegian Krone", currencyCode: "NOK"),
        Country(countryName: "Oman", currencyName: "Omani Rial", currencyCode: "OMR"),
        Country(countryName: "Pakistan", currencyName: "Pakistan Rupee", currencyCode: "PKR"),
        Country(countryName: "Palau", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "Panama", currencyName: "Panamanian Balboa", currencyCode: "PAB"),
        Country(countryName: "Papua New Guinea", currencyName: "Papua New Guinea Kina", currencyCode: "PGK"),
        Country(countryName: "Paraguay", currencyName: "Paraguay Guarani", currencyCode: "PYG"),
        Country(countryName: "Peru", currencyName: "Peruvian Nuevo Sol", currencyCode: "PEN"),
        Country(countryName: "Philippines", currencyName: "Philippine Peso", currencyCode: "PHP"),
        Country(countryName: "Pitcairn Island", currencyName: "New Zealand Dollar", currencyCode: "NZD"),
        Country(countryName: "Poland", currencyName: "Polish Zloty", currencyCode: "PLN"),
        Country(countryName: "Polynesia (French)", currencyName: "CFP Franc", currencyCode: "XPF"),
        Country(countryName: "Portugal", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Puerto Rico", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "Qatar", currencyName: "Qatari Rial", currencyCode: "QAR"),
        Country(countryName: "Reunion (French)", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Romania", currencyName: "Romanian New Leu", currencyCode: "RON"),
        Country(countryName: "Russia", currencyName: "Russian Ruble", currencyCode: "RUB"),
        Country(countryName: "Rwanda", currencyName: "Rwanda Franc", currencyCode: "RWF"),
        Country(countryName: "Saint Helena", currencyName: "St. Helena Pound", currencyCode: "SHP"),
        Country(countryName: "Saint Kitts & Nevis Anguilla", currencyName: "East Caribbean Dollar", currencyCode: "XCD"),
        Country(countryName: "Saint Lucia", currencyName: "East Caribbean Dollar", currencyCode: "XCD"),
        Country(countryName: "Saint Pierre and Miquelon", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Saint Vincent & Grenadines", currencyName: "East Caribbean Dollar", currencyCode: "XCD"),
        Country(countryName: "Samoa", currencyName: "Samoan Tala", currencyCode: "WST"),
        Country(countryName: "San Marino", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Sao Tome and Principe", currencyName: "Dobra", currencyCode: "STD"),
        Country(countryName: "Saudi Arabia", currencyName: "Saudi Riyal", currencyCode: "SAR"),
        Country(countryName: "Senegal", currencyName: "CFA Franc BCEAO", currencyCode: "XOF"),
        Country(countryName: "Serbia", currencyName: "Dinar", currencyCode: "RSD"),
        Country(countryName: "Seychelles", currencyName: "Seychelles Rupee", currencyCode: "SCR"),
        Country(countryName: "Sierra Leone", currencyName: "Sierra Leone Leone", currencyCode: "SLL"),
        Country(countryName: "Singapore", currencyName: "Singapore Dollar", currencyCode: "SGD"),
        Country(countryName: "Slovakia", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Slovenia", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Solomon Islands", currencyName: "Solomon Islands Dollar", currencyCode: "SBD"),
        Country(countryName: "Somalia", currencyName: "Somali Shilling", currencyCode: "SOS"),
        Country(countryName: "South Africa", currencyName: "South African Rand", currencyCode: "ZAR"),
        Country(countryName: "South Georgia & South Sandwich Islands", currencyName: "Pound Sterling", currencyCode: "GBP"),
        Country(countryName: "South Sudan", currencyName: "South Sudan Pound", currencyCode: "SSP"),
        Country(countryName: "Spain", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Sri Lanka", currencyName: "Sri Lanka Rupee", currencyCode: "LKR"),
        Country(countryName: "Sudan", currencyName: "Sudanese Pound", currencyCode: "SDG"),
        Country(countryName: "Suriname", currencyName: "Surinam Dollar", currencyCode: "SRD"),
        Country(countryName: "Svalbard and Jan Mayen Islands", currencyName: "Norwegian Krone", currencyCode: "NOK"),
        Country(countryName: "Swaziland", currencyName: "Swaziland Lilangeni", currencyCode: "SZL"),
        Country(countryName: "Sweden", currencyName: "Swedish Krona", currencyCode: "SEK"),
        Country(countryName: "Switzerland", currencyName: "Swiss Franc", currencyCode: "CHF"),
        Country(countryName: "Syria", currencyName: "Syrian Pound", currencyCode: "SYP"),
        Country(countryName: "Taiwan", currencyName: "Taiwan Dollar", currencyCode: "TWD"),
        Country(countryName: "Tajikistan", currencyName: "Tajik Somoni", currencyCode: "TJS"),
        Country(countryName: "Tanzania", currencyName: "Tanzanian Shilling", currencyCode: "TZS"),
        Country(countryName: "Thailand", currencyName: "Thai Baht", currencyCode: "THB"),
        Country(countryName: "Togo", currencyName: "CFA Franc BCEAO", currencyCode: "XOF"),
        Country(countryName: "Tokelau", currencyName: "New Zealand Dollar", currencyCode: "NZD"),
        Country(countryName: "Tonga", currencyName: "Tongan Pa'anga", currencyCode: "TOP"),
        Country(countryName: "Trinidad and Tobago", currencyName: "Trinidad and Tobago Dollar", currencyCode: "TTD"),
        Country(countryName: "Tunisia", currencyName: "Tunisian Dollar", currencyCode: "TND"),
        Country(countryName: "Turkey", currencyName: "Turkish Lira", currencyCode: "TRY"),
        Country(countryName: "Turkmenistan", currencyName: "Manat", currencyCode: "TMT"),
        Country(countryName: "Turks and Caicos Islands", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "Tuvalu", currencyName: "Australian Dollar", currencyCode: "AUD"),
        Country(countryName: "U.K.", currencyName: "Pound Sterling", currencyCode: "GBP"),
        Country(countryName: "Uganda", currencyName: "Uganda Shilling", currencyCode: "UGX"),
        Country(countryName: "Ukraine", currencyName: "Ukraine Hryvnia", currencyCode: "UAH"),
        Country(countryName: "United Arab Emirates", currencyName: "Arab Emirates Dirham", currencyCode: "AED"),
        Country(countryName: "Uruguay", currencyName: "Uruguayan Peso", currencyCode: "UYU"),
        Country(countryName: "USA", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "USA Minor Outlying Islands", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "Uzbekistan", currencyName: "Uzbekistan Sum", currencyCode: "UZS"),
        Country(countryName: "Vanuatu", currencyName: "Vanuatu Vatu", currencyCode: "VUV"),
        Country(countryName: "Vatican", currencyName: "Euro", currencyCode: "EUR"),
        Country(countryName: "Venezuela", currencyName: "Venezuelan Bolivar", currencyCode: "VEF"),
        Country(countryName: "Vietnam", currencyName: "Vietnamese Dong", currencyCode: "VND"),
        Country(countryName: "Virgin Islands (British)", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "Virgin Islands (USA)", currencyName: "US Dollar", currencyCode: "USD"),
        Country(countryName: "Wallis and Futuna Islands", currencyName: "CFP Franc", currencyCode: "XPF"),
        Country(countryName: "Western Sahara", currencyName: "Moroccan Dirham", currencyCode: "MAD"),
        Country(countryName: "Yemen", currencyName: "Yemeni Rial", currencyCode: "YER"),
        Country(countryName: "Zambia", currencyName: "Zambian Kwacha", currencyCode: "ZMW"),
        Country(countryName: "Zimbabwe", currencyName: "Zimbabwe Dollar", currencyCode: "ZWD")
    ]
    
    var defaultLocaleList = [
        Locale(name:"Prague", country:"Czech Republic", taxRate: 0.0, tipRate: 0.0, exchangeRate: 21.31, precision: 1, currencyName: "Czech Crown", currencyCode:"CZK"),
        Locale(name:"Texas", country:"USA", taxRate: 0.0825, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyName: "Dollar",  currencyCode:"USD"),
        Locale(name:"Oregon", country:"USA", taxRate: 0.0, tipRate: 0.2, exchangeRate: 1.0, precision: 0.25, currencyName: "Dollar", currencyCode:"USD"),
        Locale(name:"Berlin", country:"Germany", taxRate: 0.0, tipRate: 0.0, exchangeRate: 0.76, precision: 1, currencyName:"Euro", currencyCode:"EUR"),
        Locale(name:"Oslo", country:"Norway", taxRate: 0.0, tipRate: 0.0, exchangeRate: 6.0, precision: 1, currencyName: "Norwegian Kroner", currencyCode:"NOK"),
        ]

    init() {
        list = defaultLocaleList
    }
    
    
    func refreshLocales() {
        
        let url = "http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json"
        
        Alamofire.request(.GET, url)
            .responseJSON { (request, response, data, error) in
                let jsonData = JSONValue(data!)
                
                
                for resource in jsonData["list"]["resources"].array! {
                    
                    // set the price
                    let quote = resource["resource"]["fields"]["price"].double!
                    
                    // get the currency code from the yahoo quote
                    var currencyCode = resource["resource"]["fields"]["symbol"].string!
                        let stringLength = countElements(currencyCode) // strip this off for the yahoo finance API
                        let substringIndex = stringLength - 2
                        currencyCode = currencyCode.substringToIndex(advance(currencyCode.startIndex, substringIndex))
                    
                    // only set up the locale if we have an exchange rate for the country
                    for (var i=0; i<localeListSingleton.countryList.count; i++){
                        if (currencyCode == localeListSingleton.countryList[i].currencyCode){
                            
                            let countryName = localeListSingleton.countryList[i].countryName
                            let currencyName = localeListSingleton.countryList[i].currencyName
                            
                            let name = countryName // change to locale name
                            
                            self.list.append(Locale(name: name, country:countryName, taxRate: 0.0, tipRate: 0.0, exchangeRate: quote, precision: 0.5, currencyName: currencyName, currencyCode: currencyCode))
                        }
                    }
                    
                
                }
                
                println("Updated Locales")
        }
    }


    func getLocale(localeName: String) -> Locale {
        
        for(var i=0;i<self.list.count; i++)
        {
            if(list[i].name == localeName){
                return list[i]
            }
        }
        return Locale(name: "boo", country:"soo", taxRate: 0.0, tipRate: 0.0, exchangeRate: 0.0, precision: 0.0, currencyName: "poo", currencyCode: "HEY") // what should we do if the Locale doesn't exist? theoretically it shouldn't happen since we're only choosing from the above list
    }
    
}


