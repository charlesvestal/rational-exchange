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
            "Afghanistan": Country(countryName : "Afghanistan", currencyName : "Afghanistan Afghani", currencyCode : "AFN", exchangeRate : 56.68),
            "Albania": Country(countryName : "Albania", currencyName : "Albanian Lek", currencyCode : "ALL", exchangeRate : 108.175003),
            "Algeria": Country(countryName : "Algeria", currencyName : "Algerian Dinar", currencyCode : "DZD", exchangeRate : 81.324996999999996),
            "American Samoa": Country(countryName : "American Samoa", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "Andorra": Country(countryName : "Andorra", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Angola": Country(countryName : "Angola", currencyName : "Angolan Kwanza", currencyCode : "AOA", exchangeRate : 97.889999000000003),
            "Anguilla": Country(countryName : "Anguilla", currencyName : "East Caribbean Dollar", currencyCode : "XCD", exchangeRate : 2.7000000000000002),
            "Antarctica": Country(countryName : "Antarctica", currencyName : "East Caribbean Dollar", currencyCode : "XCD", exchangeRate : 2.7000000000000002),
            "Antigua and Barbuda": Country(countryName : "Antigua and Barbuda", currencyName : "East Caribbean Dollar", currencyCode : "XCD", exchangeRate : 2.7000000000000002),
            "Argentina": Country(countryName : "Argentina", currencyName : "Argentine Peso", currencyCode : "ARS", exchangeRate : 8.4012499999999992),
            "Armenia": Country(countryName : "Armenia", currencyName : "Armenian Dram", currencyCode : "AMD", exchangeRate : 408.83999599999999),
            "Aruba": Country(countryName : "Aruba", currencyName : "Aruban Guilder", currencyCode : "AWG", exchangeRate : 1.79),
            "Australia": Country(countryName : "Australia", currencyName : "Australian Dollar", currencyCode : "AUD", exchangeRate : 1.102633),
            "Austria": Country(countryName : "Austria", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Azerbaijan": Country(countryName : "Azerbaijan", currencyName : "Azerbaijan New Manat", currencyCode : "AZN", exchangeRate : 0.7843),
            "Bahamas": Country(countryName : "Bahamas", currencyName : "Bahamian Dollar", currencyCode : "BSD", exchangeRate : 1),
            "Bahrain": Country(countryName : "Bahrain", currencyName : "Bahraini Dinar", currencyCode : "BHD", exchangeRate : 0.37709999999999999),
            "Bangladesh": Country(countryName : "Bangladesh", currencyName : "Bangladeshi Taka", currencyCode : "BDT", exchangeRate : 77.480002999999996),
            "Barbados": Country(countryName : "Barbados", currencyName : "Barbados Dollar", currencyCode : "BBD", exchangeRate : 2),
            "Belarus": Country(countryName : "Belarus", currencyName : "Belarussian Ruble", currencyCode : "BYR", exchangeRate : 10515),
            "Belgium": Country(countryName : "Belgium", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Belize": Country(countryName : "Belize", currencyName : "Belize Dollar", currencyCode : "BZD", exchangeRate : 1.9950000000000001),
            "Benin": Country(countryName : "Benin", currencyName : "CFA Franc BCEAO", currencyCode : "XOF", exchangeRate : 507.14999399999999),
            "Bermuda": Country(countryName : "Bermuda", currencyName : "Bermudian Dollar", currencyCode : "BMD", exchangeRate : 1),
            "Bhutan": Country(countryName : "Bhutan", currencyName : "Bhutan Ngultrum", currencyCode : "BTN", exchangeRate : 61.095001000000003),
            "Bolivia": Country(countryName : "Bolivia", currencyName : "Boliviano", currencyCode : "BOB", exchangeRate : 6.9100000000000001),
            "Bosnia-Herzegovina": Country(countryName : "Bosnia-Herzegovina", currencyName : "Marka", currencyCode : "BAM", exchangeRate : 1.51295),
            "Botswana": Country(countryName : "Botswana", currencyName : "Botswana Pula", currencyCode : "BWP", exchangeRate : 9.0991999999999997),
            "Bouvet Island": Country(countryName : "Bouvet Island", currencyName : "Norwegian Krone", currencyCode : "NOK", exchangeRate : 6.4035000000000002),
            "Brazil": Country(countryName : "Brazil", currencyName : "Brazilian Real", currencyCode : "BRL", exchangeRate : 2.3372000000000002),
            "British Indian Ocean Territory": Country(countryName : "British Indian Ocean Territory", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "Brunei Darussalam": Country(countryName : "Brunei Darussalam", currencyName : "Brunei Dollar", currencyCode : "BND", exchangeRate : 1.2609999999999999),
            "Bulgaria": Country(countryName : "Bulgaria", currencyName : "Bulgarian Lev", currencyCode : "BGN", exchangeRate : 1.5154000000000001),
            "Burkina Faso": Country(countryName : "Burkina Faso", currencyName : "CFA Franc BCEAO", currencyCode : "XOF", exchangeRate : 507.14999399999999),
            "Burundi": Country(countryName : "Burundi", currencyName : "Burundi Franc", currencyCode : "BIF", exchangeRate : 1535),
            "Cambodia": Country(countryName : "Cambodia", currencyName : "Kampuchean Riel", currencyCode : "KHR", exchangeRate : 4065),
            "Cameroon": Country(countryName : "Cameroon", currencyName : "CFA Franc BEAC", currencyCode : "XAF", exchangeRate : 506.43273900000003),
            "Canada": Country(countryName : "Canada", currencyName : "Canadian Dollar", currencyCode : "CAD", exchangeRate : 1.0979099999999999),
            "Cape Verde": Country(countryName : "Cape Verde", currencyName : "Cape Verde Escudo", currencyCode : "CVE", exchangeRate : 85.5),
            "Cayman Islands": Country(countryName : "Cayman Islands", currencyName : "Cayman Islands Dollar", currencyCode : "KYD", exchangeRate : 0.81999999999999995),
            "Central African Republic": Country(countryName : "Central African Republic", currencyName : "CFA Franc BEAC", currencyCode : "XAF", exchangeRate : 506.43273900000003),
            "Chad": Country(countryName : "Chad", currencyName : "CFA Franc BEAC", currencyCode : "XAF", exchangeRate : 506.43273900000003),
            "Chile": Country(countryName : "Chile", currencyName : "Chilean Peso", currencyCode : "CLP", exchangeRate : 591.96997099999999),
            "China": Country(countryName : "China", currencyName : "Yuan Renminbi", currencyCode : "CNY", exchangeRate : 6.1478999999999999),
            "Christmas Island": Country(countryName : "Christmas Island", currencyName : "Australian Dollar", currencyCode : "AUD", exchangeRate : 1.102633),
            "Cocos (Keeling), Islands": Country(countryName : "Cocos Keeling), Islands", currencyName : "Australian Dollar", currencyCode : "AUD", exchangeRate : 1.102633),
            "Colombia": Country(countryName : "Colombia", currencyName : "Colombian Peso", currencyCode : "COP", exchangeRate : 1984.400024),
            "Comoros": Country(countryName : "Comoros", currencyName : "Comoros Franc", currencyCode : "KMF", exchangeRate : 380.27499399999999),
            "Congo": Country(countryName : "Congo", currencyName : "CFA Franc BEAC", currencyCode : "XAF", exchangeRate : 506.43273900000003),
            "Cook Islands": Country(countryName : "Cook Islands", currencyName : "New Zealand Dollar", currencyCode : "NZD", exchangeRate : 1.2225239999999999),
            "Costa Rica": Country(countryName : "Costa Rica", currencyName : "Costa Rican Colon", currencyCode : "CRC", exchangeRate : 541.95001200000002),
            "Croatia": Country(countryName : "Croatia", currencyName : "Croatian Kuna", currencyCode : "HRK", exchangeRate : 5.8852000000000002),
            "Cuba": Country(countryName : "Cuba", currencyName : "Cuban Peso", currencyCode : "CUP", exchangeRate : 1),
            "Cyprus": Country(countryName : "Cyprus", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Czech Rep.": Country(countryName : "Czech Rep.", currencyName : "Czech Koruna", currencyCode : "CZK", exchangeRate : 21.247999),
            "Denmark": Country(countryName : "Denmark", currencyName : "Danish Krone", currencyCode : "DKK", exchangeRate : 5.7484999999999999),
            "Djibouti": Country(countryName : "Djibouti", currencyName : "Djibouti Franc", currencyCode : "DJF", exchangeRate : 182),
            "Dominica": Country(countryName : "Dominica", currencyName : "East Caribbean Dollar", currencyCode : "XCD", exchangeRate : 2.7000000000000002),
            "Dominican Republic": Country(countryName : "Dominican Republic", currencyName : "Dominican Peso", currencyCode : "DOP", exchangeRate : 43.810001),
            "Ecuador": Country(countryName : "Ecuador", currencyName : "Ecuador Sucre", currencyCode : "ECS", exchangeRate : 0),
            "Egypt": Country(countryName : "Egypt", currencyName : "Egyptian Pound", currencyCode : "EGP", exchangeRate : 7.1488500000000004),
            "El Salvador": Country(countryName : "El Salvador", currencyName : "El Salvador Colon", currencyCode : "SVC", exchangeRate : 8.7469999999999999),
            "Equatorial Guinea": Country(countryName : "Equatorial Guinea", currencyName : "CFA Franc BEAC", currencyCode : "XAF", exchangeRate : 506.43273900000003),
            "Eritrea": Country(countryName : "Eritrea", currencyName : "Eritrean Nakfa", currencyCode : "ERN", exchangeRate : 15.1),
            "Estonia": Country(countryName : "Estonia", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Ethiopia": Country(countryName : "Ethiopia", currencyName : "Ethiopian Birr", currencyCode : "ETB", exchangeRate : 19.912001),
            "European Union": Country(countryName : "European Union", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Falkland Islands (Malvinas),": Country(countryName : "Falkland Islands Malvinas),", currencyName : "Falkland Islands Pound", currencyCode : "FKP", exchangeRate : 0.61480000000000001),
            "Faroe Islands": Country(countryName : "Faroe Islands", currencyName : "Danish Krone", currencyCode : "DKK", exchangeRate : 5.7484999999999999),
            "Fiji": Country(countryName : "Fiji", currencyName : "Fiji Dollar", currencyCode : "FJD", exchangeRate : 1.8845000000000001),
            "Finland": Country(countryName : "Finland", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "France": Country(countryName : "France", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "French Guiana": Country(countryName : "French Guiana", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "French Southern Territories": Country(countryName : "French Southern Territories", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Gabon": Country(countryName : "Gabon", currencyName : "CFA Franc BEAC", currencyCode : "XAF", exchangeRate : 506.43273900000003),
            "Gambia": Country(countryName : "Gambia", currencyName : "Gambian Dalasi", currencyCode : "GMD", exchangeRate : 39.650002000000001),
            "Georgia": Country(countryName : "Georgia", currencyName : "Georgian Lari", currencyCode : "GEL", exchangeRate : 1.7381500000000001),
            "Germany": Country(countryName : "Germany", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Ghana": Country(countryName : "Ghana", currencyName : "Ghanaian Cedi", currencyCode : "GHS", exchangeRate : 3.5924999999999998),
            "Gibraltar": Country(countryName : "Gibraltar", currencyName : "Gibraltar Pound", currencyCode : "GIP", exchangeRate : 0.61480000000000001),
            "Great Britain": Country(countryName : "Great Britain", currencyName : "Pound Sterling", currencyCode : "GBP", exchangeRate : 0.614838),
            "Greece": Country(countryName : "Greece", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Greenland": Country(countryName : "Greenland", currencyName : "Danish Krone", currencyCode : "DKK", exchangeRate : 5.7484999999999999),
            "Grenada": Country(countryName : "Grenada", currencyName : "East Carribean Dollar", currencyCode : "XCD", exchangeRate : 2.7000000000000002),
            "Guadeloupe (French),": Country(countryName : "Guadeloupe French),", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Guam (USA),": Country(countryName : "Guam USA),", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "Guernsey": Country(countryName : "Guernsey", currencyName : "Pound Sterling", currencyCode : "GGP", exchangeRate : 0),
            "Guinea Bissau": Country(countryName : "Guinea Bissau", currencyName : "Guinea-Bissau Peso", currencyCode : "GWP", exchangeRate : 0),
            "Guinea": Country(countryName : "Guinea", currencyName : "Guinea Franc", currencyCode : "GNF", exchangeRate : 6830),
            "Guyana": Country(countryName : "Guyana", currencyName : "Guyana Dollar", currencyCode : "GYD", exchangeRate : 205.699997),
            "Haiti": Country(countryName : "Haiti", currencyName : "Haitian Gourde", currencyCode : "HTG", exchangeRate : 44.700001),
            "Heard Island and McDonald Islands": Country(countryName : "Heard Island and McDonald Islands", currencyName : "Australian Dollar", currencyCode : "AUD", exchangeRate : 1.102633),
            "Honduras": Country(countryName : "Honduras", currencyName : "Honduran Lempira", currencyCode : "HNL", exchangeRate : 21.105),
            "Hong Kong": Country(countryName : "Hong Kong", currencyName : "Hong Kong Dollar", currencyCode : "HKD", exchangeRate : 7.750845),
            "Hungary": Country(countryName : "Hungary", currencyName : "Hungarian Forint", currencyCode : "HUF", exchangeRate : 242.48500100000001),
            "Iceland": Country(countryName : "Iceland", currencyName : "Iceland Krona", currencyCode : "ISK", exchangeRate : 118.650002),
            "India": Country(countryName : "India", currencyName : "Indian Rupee", currencyCode : "INR", exchangeRate : 61.080002),
            "Indonesia": Country(countryName : "Indonesia", currencyName : "Indonesian Rupiah", currencyCode : "IDR", exchangeRate : 11965),
            "Iran": Country(countryName : "Iran", currencyName : "Iranian Rial", currencyCode : "IRR", exchangeRate : 26661),
            "Iraq": Country(countryName : "Iraq", currencyName : "Iraqi Dinar", currencyCode : "IQD", exchangeRate : 1162),
            "Ireland": Country(countryName : "Ireland", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Isle of Man": Country(countryName : "Isle of Man", currencyName : "Pound Sterling", currencyCode : "GBP", exchangeRate : 0.614838),
            "Israel": Country(countryName : "Israel", currencyName : "Israeli New Shekel", currencyCode : "ILS", exchangeRate : 3.6402000000000001),
            "Italy": Country(countryName : "Italy", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Ivory Coast": Country(countryName : "Ivory Coast", currencyName : "CFA Franc BCEAO", currencyCode : "XOF", exchangeRate : 507.14999399999999),
            "Jamaica": Country(countryName : "Jamaica", currencyName : "Jamaican Dollar", currencyCode : "JMD", exchangeRate : 112.5),
            "Japan": Country(countryName : "Japan", currencyName : "Japanese Yen", currencyCode : "JPY", exchangeRate : 107.230003),
            "Jersey": Country(countryName : "Jersey", currencyName : "Pound Sterling", currencyCode : "GBP", exchangeRate : 0.614838),
            "Jordan": Country(countryName : "Jordan", currencyName : "Jordanian Dinar", currencyCode : "JOD", exchangeRate : 0.70899999999999996),
            "Kazakhstan": Country(countryName : "Kazakhstan", currencyName : "Kazakhstan Tenge", currencyCode : "KZT", exchangeRate : 181.925003),
            "Kenya": Country(countryName : "Kenya", currencyName : "Kenyan Shilling", currencyCode : "KES", exchangeRate : 89.099997999999999),
            "Kiribati": Country(countryName : "Kiribati", currencyName : "Australian Dollar", currencyCode : "AUD", exchangeRate : 1.102633),
            "Korea-North": Country(countryName : "Korea-North", currencyName : "North Korean Won", currencyCode : "KPW", exchangeRate : 900),
            "Korea-South": Country(countryName : "Korea-South", currencyName : "Korean Won", currencyCode : "KRW", exchangeRate : 1033.4849850000001),
            "Kuwait": Country(countryName : "Kuwait", currencyName : "Kuwaiti Dinar", currencyCode : "KWD", exchangeRate : 0.28739999999999999),
            "Kyrgyzstan": Country(countryName : "Kyrgyzstan", currencyName : "Som", currencyCode : "KGS", exchangeRate : 53.913502000000001),
            "Laos": Country(countryName : "Laos", currencyName : "Lao Kip", currencyCode : "LAK", exchangeRate : 8044.5),
            "Latvia": Country(countryName : "Latvia", currencyName : "Latvian Lats", currencyCode : "LVL", exchangeRate : 0.54330000000000001),
            "Lebanon": Country(countryName : "Lebanon", currencyName : "Lebanese Pound", currencyCode : "LBP", exchangeRate : 1513.5),
            "Lesotho": Country(countryName : "Lesotho", currencyName : "Lesotho Loti", currencyCode : "LSL", exchangeRate : 10.9),
            "Liberia": Country(countryName : "Liberia", currencyName : "Liberian Dollar", currencyCode : "LRD", exchangeRate : 84.5),
            "Libya": Country(countryName : "Libya", currencyName : "Libyan Dinar", currencyCode : "LYD", exchangeRate : 1.2235),
            "Liechtenstein": Country(countryName : "Liechtenstein", currencyName : "Swiss Franc", currencyCode : "CHF", exchangeRate : 0.93288499999999996),
            "Lithuania": Country(countryName : "Lithuania", currencyName : "Lithuanian Litas", currencyCode : "LTL", exchangeRate : 2.6678000000000002),
            "Luxembourg": Country(countryName : "Luxembourg", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Macau": Country(countryName : "Macau", currencyName : "Macau Pataca", currencyCode : "MOP", exchangeRate : 7.9834500000000003),
            "Macedonia": Country(countryName : "Macedonia", currencyName : "Denar", currencyCode : "MKD", exchangeRate : 47.529998999999997),
            "Madagascar": Country(countryName : "Madagascar", currencyName : "Malagasy Franc", currencyCode : "MGF", exchangeRate : 0),
            "Malawi": Country(countryName : "Malawi", currencyName : "Malawi Kwacha", currencyCode : "MWK", exchangeRate : 397.64999399999999),
            "Malaysia": Country(countryName : "Malaysia", currencyName : "Malaysian Ringgit", currencyCode : "MYR", exchangeRate : 3.2170000000000001),
            "Maldives": Country(countryName : "Maldives", currencyName : "Maldive Rufiyaa", currencyCode : "MVR", exchangeRate : 15.4),
            "Mali": Country(countryName : "Mali", currencyName : "CFA Franc BCEAO", currencyCode : "XOF", exchangeRate : 507.14999399999999),
            "Malta": Country(countryName : "Malta", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Marshall Islands": Country(countryName : "Marshall Islands", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "Martinique (French),": Country(countryName : "Martinique French),", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Mauritania": Country(countryName : "Mauritania", currencyName : "Mauritanian Ouguiya", currencyCode : "MRO", exchangeRate : 290.5),
            "Mauritius": Country(countryName : "Mauritius", currencyName : "Mauritius Rupee", currencyCode : "MUR", exchangeRate : 31.670000000000002),
            "Mayotte": Country(countryName : "Mayotte", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Mexico": Country(countryName : "Mexico", currencyName : "Mexican Nuevo Peso", currencyCode : "MXN", exchangeRate : 13.168900000000001),
            "Micronesia": Country(countryName : "Micronesia", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "Moldova": Country(countryName : "Moldova", currencyName : "Moldovan Leu", currencyCode : "MDL", exchangeRate : 14.273999999999999),
            "Monaco": Country(countryName : "Monaco", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Mongolia": Country(countryName : "Mongolia", currencyName : "Mongolian Tugrik", currencyCode : "MNT", exchangeRate : 1833.5),
            "Montenegro": Country(countryName : "Montenegro", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Montserrat": Country(countryName : "Montserrat", currencyName : "East Caribbean Dollar", currencyCode : "XCD", exchangeRate : 2.7000000000000002),
            "Morocco": Country(countryName : "Morocco", currencyName : "Moroccan Dirham", currencyCode : "MAD", exchangeRate : 8.5734999999999992),
            "Mozambique": Country(countryName : "Mozambique", currencyName : "Mozambique Metical", currencyCode : "MZN", exchangeRate : 30.600000000000001),
            "Myanmar": Country(countryName : "Myanmar", currencyName : "Myanmar Kyat", currencyCode : "MMK", exchangeRate : 980),
            "Namibia": Country(countryName : "Namibia", currencyName : "Namibian Dollar", currencyCode : "NAD", exchangeRate : 10.956),
            "Nauru": Country(countryName : "Nauru", currencyName : "Australian Dollar", currencyCode : "AUD", exchangeRate : 1.102633),
            "Nepal": Country(countryName : "Nepal", currencyName : "Nepalese Rupee", currencyCode : "NPR", exchangeRate : 98.580001999999993),
            "Netherlands Antilles": Country(countryName : "Netherlands Antilles", currencyName : "Netherlands Antillean Guilder", currencyCode : "ANG", exchangeRate : 1.7725),
            "Netherlands": Country(countryName : "Netherlands", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "New Caledonia (French),": Country(countryName : "New Caledonia French),", currencyName : "CFP Franc", currencyCode : "XPF", exchangeRate : 92.139999000000003),
            "New Zealand": Country(countryName : "New Zealand", currencyName : "New Zealand Dollar", currencyCode : "NZD", exchangeRate : 1.2225239999999999),
            "Nicaragua": Country(countryName : "Nicaragua", currencyName : "Nicaraguan Cordoba Oro", currencyCode : "NIO", exchangeRate : 26.225000000000001),
            "Niger": Country(countryName : "Niger", currencyName : "CFA Franc BCEAO", currencyCode : "XOF", exchangeRate : 507.14999399999999),
            "Nigeria": Country(countryName : "Nigeria", currencyName : "Nigerian Naira", currencyCode : "NGN", exchangeRate : 163.14999399999999),
            "Niue": Country(countryName : "Niue", currencyName : "New Zealand Dollar", currencyCode : "NZD", exchangeRate : 1.2225239999999999),
            "Norfolk Island": Country(countryName : "Norfolk Island", currencyName : "Australian Dollar", currencyCode : "AUD", exchangeRate : 1.102633),
            "Northern Mariana Islands": Country(countryName : "Northern Mariana Islands", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "Norway": Country(countryName : "Norway", currencyName : "Norwegian Krone", currencyCode : "NOK", exchangeRate : 6.4035000000000002),
            "Oman": Country(countryName : "Oman", currencyName : "Omani Rial", currencyCode : "OMR", exchangeRate : 0.3851),
            "Pakistan": Country(countryName : "Pakistan", currencyName : "Pakistan Rupee", currencyCode : "PKR", exchangeRate : 102.75),
            "Palau": Country(countryName : "Palau", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "Panama": Country(countryName : "Panama", currencyName : "Panamanian Balboa", currencyCode : "PAB", exchangeRate : 1),
            "Papua New Guinea": Country(countryName : "Papua New Guinea", currencyName : "Papua New Guinea Kina", currencyCode : "PGK", exchangeRate : 2.4761000000000002),
            "Paraguay": Country(countryName : "Paraguay", currencyName : "Paraguay Guarani", currencyCode : "PYG", exchangeRate : 4283.0649409999996),
            "Peru": Country(countryName : "Peru", currencyName : "Peruvian Nuevo Sol", currencyCode : "PEN", exchangeRate : 2.8639999999999999),
            "Philippines": Country(countryName : "Philippines", currencyName : "Philippine Peso", currencyCode : "PHP", exchangeRate : 44.185001),
            "Pitcairn Island": Country(countryName : "Pitcairn Island", currencyName : "New Zealand Dollar", currencyCode : "NZD", exchangeRate : 1.2225239999999999),
            "Poland": Country(countryName : "Poland", currencyName : "Polish Zloty", currencyCode : "PLN", exchangeRate : 3.2341000000000002),
            "Polynesia (French),": Country(countryName : "Polynesia French),", currencyName : "CFP Franc", currencyCode : "XPF", exchangeRate : 92.139999000000003),
            "Portugal": Country(countryName : "Portugal", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Puerto Rico": Country(countryName : "Puerto Rico", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "Qatar": Country(countryName : "Qatar", currencyName : "Qatari Rial", currencyCode : "QAR", exchangeRate : 3.6417999999999999),
            "Reunion (French),": Country(countryName : "Reunion French),", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Romania": Country(countryName : "Romania", currencyName : "Romanian New Leu", currencyCode : "RON", exchangeRate : 3.41065),
            "Russia": Country(countryName : "Russia", currencyName : "Russian Ruble", currencyCode : "RUB", exchangeRate : 38.340000000000003),
            "Rwanda": Country(countryName : "Rwanda", currencyName : "Rwanda Franc", currencyCode : "RWF", exchangeRate : 688),
            "Saint Helena": Country(countryName : "Saint Helena", currencyName : "St. Helena Pound", currencyCode : "SHP", exchangeRate : 0.61480000000000001),
            "Saint Kitts & Nevis Anguilla": Country(countryName : "Saint Kitts & Nevis Anguilla", currencyName : "East Caribbean Dollar", currencyCode : "XCD", exchangeRate : 2.7000000000000002),
            "Saint Lucia": Country(countryName : "Saint Lucia", currencyName : "East Caribbean Dollar", currencyCode : "XCD", exchangeRate : 2.7000000000000002),
            "Saint Pierre and Miquelon": Country(countryName : "Saint Pierre and Miquelon", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Saint Vincent & Grenadines": Country(countryName : "Saint Vincent & Grenadines", currencyName : "East Caribbean Dollar", currencyCode : "XCD", exchangeRate : 2.7000000000000002),
            "Samoa": Country(countryName : "Samoa", currencyName : "Samoan Tala", currencyCode : "WST", exchangeRate : 2.3683169999999998),
            "San Marino": Country(countryName : "San Marino", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Sao Tome and Principe": Country(countryName : "Sao Tome and Principe", currencyName : "Dobra", currencyCode : "STD", exchangeRate : 18995),
            "Saudi Arabia": Country(countryName : "Saudi Arabia", currencyName : "Saudi Riyal", currencyCode : "SAR", exchangeRate : 3.7507999999999999),
            "Senegal": Country(countryName : "Senegal", currencyName : "CFA Franc BCEAO", currencyCode : "XOF", exchangeRate : 507.14999399999999),
            "Serbia": Country(countryName : "Serbia", currencyName : "Dinar", currencyCode : "RSD", exchangeRate : 91.980498999999994),
            "Seychelles": Country(countryName : "Seychelles", currencyName : "Seychelles Rupee", currencyCode : "SCR", exchangeRate : 13.045),
            "Sierra Leone": Country(countryName : "Sierra Leone", currencyName : "Sierra Leone Leone", currencyCode : "SLL", exchangeRate : 4370),
            "Singapore": Country(countryName : "Singapore", currencyName : "Singapore Dollar", currencyCode : "SGD", exchangeRate : 1.261315),
            "Slovakia": Country(countryName : "Slovakia", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Slovenia": Country(countryName : "Slovenia", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Solomon Islands": Country(countryName : "Solomon Islands", currencyName : "Solomon Islands Dollar", currencyCode : "SBD", exchangeRate : 7.3261060000000002),
            "Somalia": Country(countryName : "Somalia", currencyName : "Somali Shilling", currencyCode : "SOS", exchangeRate : 826),
            "South Africa": Country(countryName : "South Africa", currencyName : "South African Rand", currencyCode : "ZAR", exchangeRate : 10.91375),
            "South Georgia & South Sandwich Islands": Country(countryName : "South Georgia & South Sandwich Islands", currencyName : "Pound Sterling", currencyCode : "GBP", exchangeRate : 0.614838),
            "South Sudan": Country(countryName : "South Sudan", currencyName : "South Sudan Pound", currencyCode : "SSP", exchangeRate : 0),
            "Spain": Country(countryName : "Spain", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Sri Lanka": Country(countryName : "Sri Lanka", currencyName : "Sri Lanka Rupee", currencyCode : "LKR", exchangeRate : 130.279999),
            "Sudan": Country(countryName : "Sudan", currencyName : "Sudanese Pound", currencyCode : "SDG", exchangeRate : 5.6924999999999999),
            "Suriname": Country(countryName : "Suriname", currencyName : "Surinam Dollar", currencyCode : "SRD", exchangeRate : 3.2749999999999999),
            "Svalbard and Jan Mayen Islands": Country(countryName : "Svalbard and Jan Mayen Islands", currencyName : "Norwegian Krone", currencyCode : "NOK", exchangeRate : 6.4035000000000002),
            "Swaziland": Country(countryName : "Swaziland", currencyName : "Swaziland Lilangeni", currencyCode : "SZL", exchangeRate : 10.964),
            "Sweden": Country(countryName : "Sweden", currencyName : "Swedish Krona", currencyCode : "SEK", exchangeRate : 7.1234000000000002),
            "Switzerland": Country(countryName : "Switzerland", currencyName : "Swiss Franc", currencyCode : "CHF", exchangeRate : 0.93288499999999996),
            "Syria": Country(countryName : "Syria", currencyName : "Syrian Pound", currencyCode : "SYP", exchangeRate : 157.5),
            "Taiwan": Country(countryName : "Taiwan", currencyName : "Taiwan Dollar", currencyCode : "TWD", exchangeRate : 30.115499),
            "Tajikistan": Country(countryName : "Tajikistan", currencyName : "Tajik Somoni", currencyCode : "TJS", exchangeRate : 4.9930000000000003),
            "Tanzania": Country(countryName : "Tanzania", currencyName : "Tanzanian Shilling", currencyCode : "TZS", exchangeRate : 1661.5),
            "Thailand": Country(countryName : "Thailand", currencyName : "Thai Baht", currencyCode : "THB", exchangeRate : 32.229999999999997),
            "Togo": Country(countryName : "Togo", currencyName : "CFA Franc BCEAO", currencyCode : "XOF", exchangeRate : 507.14999399999999),
            "Tokelau": Country(countryName : "Tokelau", currencyName : "New Zealand Dollar", currencyCode : "NZD", exchangeRate : 1.2225239999999999),
            "Tonga": Country(countryName : "Tonga", currencyName : "Tongan Pa'anga", currencyCode : "TOP", exchangeRate : 1.908571),
            "Trinidad and Tobago": Country(countryName : "Trinidad and Tobago", currencyName : "Trinidad and Tobago Dollar", currencyCode : "TTD", exchangeRate : 6.3479999999999999),
            "Tunisia": Country(countryName : "Tunisia", currencyName : "Tunisian Dollar", currencyCode : "TND", exchangeRate : 1.7649999999999999),
            "Turkey": Country(countryName : "Turkey", currencyName : "Turkish Lira", currencyCode : "TRY", exchangeRate : 2.2039),
            "Turkmenistan": Country(countryName : "Turkmenistan", currencyName : "Manat", currencyCode : "TMT", exchangeRate : 2.8504999999999998),
            "Turks and Caicos Islands": Country(countryName : "Turks and Caicos Islands", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "Tuvalu": Country(countryName : "Tuvalu", currencyName : "Australian Dollar", currencyCode : "AUD", exchangeRate : 1.102633),
            "U.K.": Country(countryName : "U.K.", currencyName : "Pound Sterling", currencyCode : "GBP", exchangeRate : 0.614838),
            "Uganda": Country(countryName : "Uganda", currencyName : "Uganda Shilling", currencyCode : "UGX", exchangeRate : 2605),
            "Ukraine": Country(countryName : "Ukraine", currencyName : "Ukraine Hryvnia", currencyCode : "UAH", exchangeRate : 12.993),
            "United Arab Emirates": Country(countryName : "United Arab Emirates", currencyName : "Arab Emirates Dirham", currencyCode : "AED", exchangeRate : 3.673),
            "Uruguay": Country(countryName : "Uruguay", currencyName : "Uruguayan Peso", currencyCode : "UYU", exchangeRate : 24.329999999999998),
            "USA Minor Outlying Islands": Country(countryName : "USA Minor Outlying Islands", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "USA": Country(countryName : "USA", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "Uzbekistan": Country(countryName : "Uzbekistan", currencyName : "Uzbekistan Sum", currencyCode : "UZS", exchangeRate : 2359.5600589999999),
            "Vanuatu": Country(countryName : "Vanuatu", currencyName : "Vanuatu Vatu", currencyCode : "VUV", exchangeRate : 96.199996999999996),
            "Vatican": Country(countryName : "Vatican", currencyName : "Euro", currencyCode : "EUR", exchangeRate : 0.77190300000000001),
            "Venezuela": Country(countryName : "Venezuela", currencyName : "Venezuelan Bolivar", currencyCode : "VEF", exchangeRate : 6.2877000000000001),
            "Vietnam": Country(countryName : "Vietnam", currencyName : "Vietnamese Dong", currencyCode : "VND", exchangeRate : 21180),
            "Virgin Islands (British),": Country(countryName : "Virgin Islands British),", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "Virgin Islands (USA),": Country(countryName : "Virgin Islands USA),", currencyName : "US Dollar", currencyCode : "USD", exchangeRate : 1),
            "Wallis and Futuna Islands": Country(countryName : "Wallis and Futuna Islands", currencyName : "CFP Franc", currencyCode : "XPF", exchangeRate : 92.139999000000003),
            "Western Sahara": Country(countryName : "Western Sahara", currencyName : "Moroccan Dirham", currencyCode : "MAD", exchangeRate : 8.5734999999999992),
            "Yemen": Country(countryName : "Yemen", currencyName : "Yemeni Rial", currencyCode : "YER", exchangeRate : 214.904999),
            "Zambia": Country(countryName : "Zambia", currencyName : "Zambian Kwacha", currencyCode : "ZMW", exchangeRate : 6.1600000000000001),
            "Zimbabwe": Country(countryName : "Zimbabwe", currencyName : "Zimbabwe Dollar", currencyCode : "ZWD", exchangeRate : 0)

        ]
        
        localeList = [
            Locale(name: "Prague", taxRate: 0.0, tipRate: 0.0, precision: 1.0, countryName: countryList["Czech Rep."]!),
            Locale(name: "Texas", taxRate: 0.825, tipRate: 0.0, precision: 0.25, countryName: countryList["USA"]!)
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
                        if(countryToIterate.currencyCode == currencyCode)
                        {
                            countryToIterate.exchangeRate = quote // set the country exchange rate
                            
                            self.localeList.append(Locale(name: countryToIterate.countryName, taxRate: 0.0, tipRate: 0.0, precision: 1.0, countryName: countryToIterate))
                                     // create all countries as locales
                        
                            println(String(format: "updating exchange for %@", countryToIterate.currencyCode))
                            
                        }
                    }
                }
                        println("Finished Refreshing Exchange Rates")
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