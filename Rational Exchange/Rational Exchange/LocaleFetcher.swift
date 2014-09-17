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
    
    var localeList:[Locale]
    var countryList: Dictionary<String, Country>
    
    init() {
        countryList = [
                "Afghanistan": Country(currencyName: "Afghanistan Afghani", currencyCode: "AFN", exchangeRate: 0.0),
                "Albania": Country(currencyName: "Albanian Lek", currencyCode: "ALL", exchangeRate: 0.0),
                "Algeria": Country(currencyName: "Algerian Dinar", currencyCode: "DZD", exchangeRate: 0.0),
                "American Samoa": Country(currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "Andorra": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Angola": Country(currencyName: "Angolan Kwanza", currencyCode: "AOA", exchangeRate: 0.0),
                "Anguilla": Country(currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 0.0),
                "Antarctica": Country(currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 0.0),
                "Antigua and Barbuda": Country(currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 0.0),
                "Argentina": Country(currencyName: "Argentine Peso", currencyCode: "ARS", exchangeRate: 0.0),
                "Armenia": Country(currencyName: "Armenian Dram", currencyCode: "AMD", exchangeRate: 0.0),
                "Aruba": Country(currencyName: "Aruban Guilder", currencyCode: "AWG", exchangeRate: 0.0),
                "Australia": Country(currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 0.0),
                "Austria": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Azerbaijan": Country(currencyName: "Azerbaijan New Manat", currencyCode: "AZN", exchangeRate: 0.0),
                "Bahamas": Country(currencyName: "Bahamian Dollar", currencyCode: "BSD", exchangeRate: 0.0),
                "Bahrain": Country(currencyName: "Bahraini Dinar", currencyCode: "BHD", exchangeRate: 0.0),
                "Bangladesh": Country(currencyName: "Bangladeshi Taka", currencyCode: "BDT", exchangeRate: 0.0),
                "Barbados": Country(currencyName: "Barbados Dollar", currencyCode: "BBD", exchangeRate: 0.0),
                "Belarus": Country(currencyName: "Belarussian Ruble", currencyCode: "BYR", exchangeRate: 0.0),
                "Belgium": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Belize": Country(currencyName: "Belize Dollar", currencyCode: "BZD", exchangeRate: 0.0),
                "Benin": Country(currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 0.0),
                "Bermuda": Country(currencyName: "Bermudian Dollar", currencyCode: "BMD", exchangeRate: 0.0),
                "Bhutan": Country(currencyName: "Bhutan Ngultrum", currencyCode: "BTN", exchangeRate: 0.0),
                "Bolivia": Country(currencyName: "Boliviano", currencyCode: "BOB", exchangeRate: 0.0),
                "Bosnia-Herzegovina": Country(currencyName: "Marka", currencyCode: "BAM", exchangeRate: 0.0),
                "Botswana": Country(currencyName: "Botswana Pula", currencyCode: "BWP", exchangeRate: 0.0),
                "Bouvet Island": Country(currencyName: "Norwegian Krone", currencyCode: "NOK", exchangeRate: 0.0),
                "Brazil": Country(currencyName: "Brazilian Real", currencyCode: "BRL", exchangeRate: 0.0),
                "British Indian Ocean Territory": Country(currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "Brunei Darussalam": Country(currencyName: "Brunei Dollar", currencyCode: "BND", exchangeRate: 0.0),
                "Bulgaria": Country(currencyName: "Bulgarian Lev", currencyCode: "BGN", exchangeRate: 0.0),
                "Burkina Faso": Country(currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 0.0),
                "Burundi": Country(currencyName: "Burundi Franc", currencyCode: "BIF", exchangeRate: 0.0),
                "Cambodia": Country(currencyName: "Kampuchean Riel", currencyCode: "KHR", exchangeRate: 0.0),
                "Cameroon": Country(currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 0.0),
                "Canada": Country(currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 0.0),
                "Cape Verde": Country(currencyName: "Cape Verde Escudo", currencyCode: "CVE", exchangeRate: 0.0),
                "Cayman Islands": Country(currencyName: "Cayman Islands Dollar", currencyCode: "KYD", exchangeRate: 0.0),
                "Central African Republic": Country(currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 0.0),
                "Chad": Country(currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 0.0),
                "Chile": Country(currencyName: "Chilean Peso", currencyCode: "CLP", exchangeRate: 0.0),
                "China": Country(currencyName: "Yuan Renminbi", currencyCode: "CNY", exchangeRate: 0.0),
                "Christmas Island": Country(currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 0.0),
                "Cocos (Keeling) Islands": Country(currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 0.0),
                "Colombia": Country(currencyName: "Colombian Peso", currencyCode: "COP", exchangeRate: 0.0),
                "Comoros": Country(currencyName: "Comoros Franc", currencyCode: "KMF", exchangeRate: 0.0),
                "Congo": Country(currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 0.0),
                "Congo:  Dem. Republic": Country(currencyName: "Francs", currencyCode: "CDF", exchangeRate: 0.0),
                "Cook Islands": Country(currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 0.0),
                "Costa Rica": Country(currencyName: "Costa Rican Colon", currencyCode: "CRC", exchangeRate: 0.0),
                "Croatia": Country(currencyName: "Croatian Kuna", currencyCode: "HRK", exchangeRate: 0.0),
                "Cuba": Country(currencyName: "Cuban Peso", currencyCode: "CUP", exchangeRate: 0.0),
                "Cyprus": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Czech Rep.": Country(currencyName: "Czech Koruna", currencyCode: "CZK", exchangeRate: 0.0),
                "Denmark": Country(currencyName: "Danish Krone", currencyCode: "DKK", exchangeRate: 0.0),
                "Djibouti": Country(currencyName: "Djibouti Franc", currencyCode: "DJF", exchangeRate: 0.0),
                "Dominica": Country(currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 0.0),
                "Dominican Republic": Country(currencyName: "Dominican Peso", currencyCode: "DOP", exchangeRate: 0.0),
                "Ecuador": Country(currencyName: "Ecuador Sucre", currencyCode: "ECS", exchangeRate: 0.0),
                "Egypt": Country(currencyName: "Egyptian Pound", currencyCode: "EGP", exchangeRate: 0.0),
                "El Salvador": Country(currencyName: "El Salvador Colon", currencyCode: "SVC", exchangeRate: 0.0),
                "Equatorial Guinea": Country(currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 0.0),
                "Eritrea": Country(currencyName: "Eritrean Nakfa", currencyCode: "ERN", exchangeRate: 0.0),
                "Estonia": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Ethiopia": Country(currencyName: "Ethiopian Birr", currencyCode: "ETB", exchangeRate: 0.0),
                "European Union": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Falkland Islands (Malvinas)": Country(currencyName: "Falkland Islands Pound", currencyCode: "FKP", exchangeRate: 0.0),
                "Faroe Islands": Country(currencyName: "Danish Krone", currencyCode: "DKK", exchangeRate: 0.0),
                "Fiji": Country(currencyName: "Fiji Dollar", currencyCode: "FJD", exchangeRate: 0.0),
                "Finland": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "France": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "French Guiana": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "French Southern Territories": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Gabon": Country(currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 0.0),
                "Gambia": Country(currencyName: "Gambian Dalasi", currencyCode: "GMD", exchangeRate: 0.0),
                "Georgia": Country(currencyName: "Georgian Lari", currencyCode: "GEL", exchangeRate: 0.0),
                "Germany": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Ghana": Country(currencyName: "Ghanaian Cedi", currencyCode: "GHS", exchangeRate: 0.0),
                "Gibraltar": Country(currencyName: "Gibraltar Pound", currencyCode: "GIP", exchangeRate: 0.0),
                "Great Britain": Country(currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.0),
                "Greece": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Greenland": Country(currencyName: "Danish Krone", currencyCode: "DKK", exchangeRate: 0.0),
                "Grenada": Country(currencyName: "East Carribean Dollar", currencyCode: "XCD", exchangeRate: 0.0),
                "Guadeloupe (French)": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Guam (USA)": Country(currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "Guatemala": Country(currencyName: "Guatemalan Quetzal", currencyCode: "QTQ", exchangeRate: 0.0),
                "Guernsey": Country(currencyName: "Pound Sterling", currencyCode: "GGP", exchangeRate: 0.0),
                "Guinea": Country(currencyName: "Guinea Franc", currencyCode: "GNF", exchangeRate: 0.0),
                "Guinea Bissau": Country(currencyName: "Guinea-Bissau Peso", currencyCode: "GWP", exchangeRate: 0.0),
                "Guyana": Country(currencyName: "Guyana Dollar", currencyCode: "GYD", exchangeRate: 0.0),
                "Haiti": Country(currencyName: "Haitian Gourde", currencyCode: "HTG", exchangeRate: 0.0),
                "Heard Island and McDonald Islands": Country(currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 0.0),
                "Honduras": Country(currencyName: "Honduran Lempira", currencyCode: "HNL", exchangeRate: 0.0),
                "Hong Kong": Country(currencyName: "Hong Kong Dollar", currencyCode: "HKD", exchangeRate: 0.0),
                "Hungary": Country(currencyName: "Hungarian Forint", currencyCode: "HUF", exchangeRate: 0.0),
                "Iceland": Country(currencyName: "Iceland Krona", currencyCode: "ISK", exchangeRate: 0.0),
                "India": Country(currencyName: "Indian Rupee", currencyCode: "INR", exchangeRate: 0.0),
                "Indonesia": Country(currencyName: "Indonesian Rupiah", currencyCode: "IDR", exchangeRate: 0.0),
                "Iran": Country(currencyName: "Iranian Rial", currencyCode: "IRR", exchangeRate: 0.0),
                "Iraq": Country(currencyName: "Iraqi Dinar", currencyCode: "IQD", exchangeRate: 0.0),
                "Ireland": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Isle of Man": Country(currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.0),
                "Israel": Country(currencyName: "Israeli New Shekel", currencyCode: "ILS", exchangeRate: 0.0),
                "Italy": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Ivory Coast": Country(currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 0.0),
                "Jamaica": Country(currencyName: "Jamaican Dollar", currencyCode: "JMD", exchangeRate: 0.0),
                "Japan": Country(currencyName: "Japanese Yen", currencyCode: "JPY", exchangeRate: 0.0),
                "Jersey": Country(currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.0),
                "Jordan": Country(currencyName: "Jordanian Dinar", currencyCode: "JOD", exchangeRate: 0.0),
                "Kazakhstan": Country(currencyName: "Kazakhstan Tenge", currencyCode: "KZT", exchangeRate: 0.0),
                "Kenya": Country(currencyName: "Kenyan Shilling", currencyCode: "KES", exchangeRate: 0.0),
                "Kiribati": Country(currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 0.0),
                "Korea-North": Country(currencyName: "North Korean Won", currencyCode: "KPW", exchangeRate: 0.0),
                "Korea-South": Country(currencyName: "Korean Won", currencyCode: "KRW", exchangeRate: 0.0),
                "Kuwait": Country(currencyName: "Kuwaiti Dinar", currencyCode: "KWD", exchangeRate: 0.0),
                "Kyrgyzstan": Country(currencyName: "Som", currencyCode: "KGS", exchangeRate: 0.0),
                "Laos": Country(currencyName: "Lao Kip", currencyCode: "LAK", exchangeRate: 0.0),
                "Latvia": Country(currencyName: "Latvian Lats", currencyCode: "LVL", exchangeRate: 0.0),
                "Lebanon": Country(currencyName: "Lebanese Pound", currencyCode: "LBP", exchangeRate: 0.0),
                "Lesotho": Country(currencyName: "Lesotho Loti", currencyCode: "LSL", exchangeRate: 0.0),
                "Liberia": Country(currencyName: "Liberian Dollar", currencyCode: "LRD", exchangeRate: 0.0),
                "Libya": Country(currencyName: "Libyan Dinar", currencyCode: "LYD", exchangeRate: 0.0),
                "Liechtenstein": Country(currencyName: "Swiss Franc", currencyCode: "CHF", exchangeRate: 0.0),
                "Lithuania": Country(currencyName: "Lithuanian Litas", currencyCode: "LTL", exchangeRate: 0.0),
                "Luxembourg": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Macau": Country(currencyName: "Macau Pataca", currencyCode: "MOP", exchangeRate: 0.0),
                "Macedonia": Country(currencyName: "Denar", currencyCode: "MKD", exchangeRate: 0.0),
                "Madagascar": Country(currencyName: "Malagasy Franc", currencyCode: "MGF", exchangeRate: 0.0),
                "Malawi": Country(currencyName: "Malawi Kwacha", currencyCode: "MWK", exchangeRate: 0.0),
                "Malaysia": Country(currencyName: "Malaysian Ringgit", currencyCode: "MYR", exchangeRate: 0.0),
                "Maldives": Country(currencyName: "Maldive Rufiyaa", currencyCode: "MVR", exchangeRate: 0.0),
                "Mali": Country(currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 0.0),
                "Malta": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Marshall Islands": Country(currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "Martinique (French)": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Mauritania": Country(currencyName: "Mauritanian Ouguiya", currencyCode: "MRO", exchangeRate: 0.0),
                "Mauritius": Country(currencyName: "Mauritius Rupee", currencyCode: "MUR", exchangeRate: 0.0),
                "Mayotte": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Mexico": Country(currencyName: "Mexican Nuevo Peso", currencyCode: "MXN", exchangeRate: 0.0),
                "Micronesia": Country(currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "Moldova": Country(currencyName: "Moldovan Leu", currencyCode: "MDL", exchangeRate: 0.0),
                "Monaco": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Mongolia": Country(currencyName: "Mongolian Tugrik", currencyCode: "MNT", exchangeRate: 0.0),
                "Montenegro": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Montserrat": Country(currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 0.0),
                "Morocco": Country(currencyName: "Moroccan Dirham", currencyCode: "MAD", exchangeRate: 0.0),
                "Mozambique": Country(currencyName: "Mozambique Metical", currencyCode: "MZN", exchangeRate: 0.0),
                "Myanmar": Country(currencyName: "Myanmar Kyat", currencyCode: "MMK", exchangeRate: 0.0),
                "Namibia": Country(currencyName: "Namibian Dollar", currencyCode: "NAD", exchangeRate: 0.0),
                "Nauru": Country(currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 0.0),
                "Nepal": Country(currencyName: "Nepalese Rupee", currencyCode: "NPR", exchangeRate: 0.0),
                "Netherlands": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Netherlands Antilles": Country(currencyName: "Netherlands Antillean Guilder", currencyCode: "ANG", exchangeRate: 0.0),
                "New Caledonia (French)": Country(currencyName: "CFP Franc", currencyCode: "XPF", exchangeRate: 0.0),
                "New Zealand": Country(currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 0.0),
                "Nicaragua": Country(currencyName: "Nicaraguan Cordoba Oro", currencyCode: "NIO", exchangeRate: 0.0),
                "Niger": Country(currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 0.0),
                "Nigeria": Country(currencyName: "Nigerian Naira", currencyCode: "NGN", exchangeRate: 0.0),
                "Niue": Country(currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 0.0),
                "Norfolk Island": Country(currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 0.0),
                "Northern Mariana Islands": Country(currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "Norway": Country(currencyName: "Norwegian Krone", currencyCode: "NOK", exchangeRate: 0.0),
                "Oman": Country(currencyName: "Omani Rial", currencyCode: "OMR", exchangeRate: 0.0),
                "Pakistan": Country(currencyName: "Pakistan Rupee", currencyCode: "PKR", exchangeRate: 0.0),
                "Palau": Country(currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "Panama": Country(currencyName: "Panamanian Balboa", currencyCode: "PAB", exchangeRate: 0.0),
                "Papua New Guinea": Country(currencyName: "Papua New Guinea Kina", currencyCode: "PGK", exchangeRate: 0.0),
                "Paraguay": Country(currencyName: "Paraguay Guarani", currencyCode: "PYG", exchangeRate: 0.0),
                "Peru": Country(currencyName: "Peruvian Nuevo Sol", currencyCode: "PEN", exchangeRate: 0.0),
                "Philippines": Country(currencyName: "Philippine Peso", currencyCode: "PHP", exchangeRate: 0.0),
                "Pitcairn Island": Country(currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 0.0),
                "Poland": Country(currencyName: "Polish Zloty", currencyCode: "PLN", exchangeRate: 0.0),
                "Polynesia (French)": Country(currencyName: "CFP Franc", currencyCode: "XPF", exchangeRate: 0.0),
                "Portugal": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Puerto Rico": Country(currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "Qatar": Country(currencyName: "Qatari Rial", currencyCode: "QAR", exchangeRate: 0.0),
                "Reunion (French)": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Romania": Country(currencyName: "Romanian New Leu", currencyCode: "RON", exchangeRate: 0.0),
                "Russia": Country(currencyName: "Russian Ruble", currencyCode: "RUB", exchangeRate: 0.0),
                "Rwanda": Country(currencyName: "Rwanda Franc", currencyCode: "RWF", exchangeRate: 0.0),
                "Saint Helena": Country(currencyName: "St. Helena Pound", currencyCode: "SHP", exchangeRate: 0.0),
                "Saint Kitts & Nevis Anguilla": Country(currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 0.0),
                "Saint Lucia": Country(currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 0.0),
                "Saint Pierre and Miquelon": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Saint Vincent & Grenadines": Country(currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 0.0),
                "Samoa": Country(currencyName: "Samoan Tala", currencyCode: "WST", exchangeRate: 0.0),
                "San Marino": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Sao Tome and Principe": Country(currencyName: "Dobra", currencyCode: "STD", exchangeRate: 0.0),
                "Saudi Arabia": Country(currencyName: "Saudi Riyal", currencyCode: "SAR", exchangeRate: 0.0),
                "Senegal": Country(currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 0.0),
                "Serbia": Country(currencyName: "Dinar", currencyCode: "RSD", exchangeRate: 0.0),
                "Seychelles": Country(currencyName: "Seychelles Rupee", currencyCode: "SCR", exchangeRate: 0.0),
                "Sierra Leone": Country(currencyName: "Sierra Leone Leone", currencyCode: "SLL", exchangeRate: 0.0),
                "Singapore": Country(currencyName: "Singapore Dollar", currencyCode: "SGD", exchangeRate: 0.0),
                "Slovakia": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Slovenia": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Solomon Islands": Country(currencyName: "Solomon Islands Dollar", currencyCode: "SBD", exchangeRate: 0.0),
                "Somalia": Country(currencyName: "Somali Shilling", currencyCode: "SOS", exchangeRate: 0.0),
                "South Africa": Country(currencyName: "South African Rand", currencyCode: "ZAR", exchangeRate: 0.0),
                "South Georgia & South Sandwich Islands": Country(currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.0),
                "South Sudan": Country(currencyName: "South Sudan Pound", currencyCode: "SSP", exchangeRate: 0.0),
                "Spain": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Sri Lanka": Country(currencyName: "Sri Lanka Rupee", currencyCode: "LKR", exchangeRate: 0.0),
                "Sudan": Country(currencyName: "Sudanese Pound", currencyCode: "SDG", exchangeRate: 0.0),
                "Suriname": Country(currencyName: "Surinam Dollar", currencyCode: "SRD", exchangeRate: 0.0),
                "Svalbard and Jan Mayen Islands": Country(currencyName: "Norwegian Krone", currencyCode: "NOK", exchangeRate: 0.0),
                "Swaziland": Country(currencyName: "Swaziland Lilangeni", currencyCode: "SZL", exchangeRate: 0.0),
                "Sweden": Country(currencyName: "Swedish Krona", currencyCode: "SEK", exchangeRate: 0.0),
                "Switzerland": Country(currencyName: "Swiss Franc", currencyCode: "CHF", exchangeRate: 0.0),
                "Syria": Country(currencyName: "Syrian Pound", currencyCode: "SYP", exchangeRate: 0.0),
                "Taiwan": Country(currencyName: "Taiwan Dollar", currencyCode: "TWD", exchangeRate: 0.0),
                "Tajikistan": Country(currencyName: "Tajik Somoni", currencyCode: "TJS", exchangeRate: 0.0),
                "Tanzania": Country(currencyName: "Tanzanian Shilling", currencyCode: "TZS", exchangeRate: 0.0),
                "Thailand": Country(currencyName: "Thai Baht", currencyCode: "THB", exchangeRate: 0.0),
                "Togo": Country(currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 0.0),
                "Tokelau": Country(currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 0.0),
                "Tonga": Country(currencyName: "Tongan Pa'anga", currencyCode: "TOP", exchangeRate: 0.0),
                "Trinidad and Tobago": Country(currencyName: "Trinidad and Tobago Dollar", currencyCode: "TTD", exchangeRate: 0.0),
                "Tunisia": Country(currencyName: "Tunisian Dollar", currencyCode: "TND", exchangeRate: 0.0),
                "Turkey": Country(currencyName: "Turkish Lira", currencyCode: "TRY", exchangeRate: 0.0),
                "Turkmenistan": Country(currencyName: "Manat", currencyCode: "TMT", exchangeRate: 0.0),
                "Turks and Caicos Islands": Country(currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "Tuvalu": Country(currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 0.0),
                "U.K.": Country(currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.0),
                "Uganda": Country(currencyName: "Uganda Shilling", currencyCode: "UGX", exchangeRate: 0.0),
                "Ukraine": Country(currencyName: "Ukraine Hryvnia", currencyCode: "UAH", exchangeRate: 0.0),
                "United Arab Emirates": Country(currencyName: "Arab Emirates Dirham", currencyCode: "AED", exchangeRate: 0.0),
                "Uruguay": Country(currencyName: "Uruguayan Peso", currencyCode: "UYU", exchangeRate: 0.0),
                "USA":Country(currencyName:"US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "USA Minor Outlying Islands": Country(currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "Uzbekistan": Country(currencyName: "Uzbekistan Sum", currencyCode: "UZS", exchangeRate: 0.0),
                "Vanuatu": Country(currencyName: "Vanuatu Vatu", currencyCode: "VUV", exchangeRate: 0.0),
                "Vatican": Country(currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.0),
                "Venezuela": Country(currencyName: "Venezuelan Bolivar", currencyCode: "VEF", exchangeRate: 0.0),
                "Vietnam": Country(currencyName: "Vietnamese Dong", currencyCode: "VND", exchangeRate: 0.0),
                "Virgin Islands (British)": Country(currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "Virgin Islands (USA)": Country(currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 0.0),
                "Wallis and Futuna Islands": Country(currencyName: "CFP Franc", currencyCode: "XPF", exchangeRate: 0.0),
                "Western Sahara": Country(currencyName: "Moroccan Dirham", currencyCode: "MAD", exchangeRate: 0.0),
                "Yemen": Country(currencyName: "Yemeni Rial", currencyCode: "YER", exchangeRate: 0.0),
                "Zambia": Country(currencyName: "Zambian Kwacha", currencyCode: "ZMW", exchangeRate: 0.0),
                "Zimbabwe": Country(currencyName: "Zimbabwe Dollar", currencyCode: "ZWD", exchangeRate: 0.0)
        ]
        
        localeList = [
            Locale(name: "Prague", taxRate: 0.825, tipRate: 0.0, precision: 1.0, countryName: countryList["Afghanistan"]!),
            Locale(name: "Texas", taxRate: 0.825, tipRate: 0.0, precision: 1.0, countryName: countryList["USA"]!)
        ]
    }
    
    
    func refreshCountries() {
        
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
                    
                    
                    for countryToIterate in self.countryList.values
                    {
                        countryToIterate.exchangeRate = quote
                        
                    }

                    
//                    // only set up the locale if we have an exchange rate for the country
//                    for (var i=0; i<localeListSingleton.countryList.count; i++){
//                        if (currencyCode == localeListSingleton.countryList..currencyCode){
//                            
//                            let countryName = localeListSingleton.countryList[i].countryName
//                            let currencyName = localeListSingleton.countryList[i].currencyName
//                            
//                            let name = countryName // change to locale name
//                            
//                            self.list.append(Locale(name: name, country:countryName, taxRate: 0.0, tipRate: 0.0, exchangeRate: quote, precision: 0.5, currencyName: currencyName, currencyCode: currencyCode))
//                        }
//                    }
                    
                
                }
                
                println("Updated Exchange Rates")
        }
    }
    


    func getLocale(localeName: String) -> Locale {
        
        for(var i=0;i < localeList.count; i++)
        {
            if(localeList[i].name == localeName)
            {
                return localeList[i]
            }
        }
        return  Locale(name: "Prague", taxRate: 0.825, tipRate: 0.0, precision: 1.0, countryName: countryList["Afghanistan"]!)

    }
    

}