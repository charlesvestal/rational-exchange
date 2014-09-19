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
    var countryList: [Country]
    
    init() {
        countryList = [
            Country(name: "Afghanistan", currencyName: "Afghanistan Afghani", currencyCode: "AFN", exchangeRate: 56.68, tipRate:nil, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Albania", currencyName: "Albanian Lek", currencyCode: "ALL", exchangeRate: 108.175003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Algeria", currencyName: "Algerian Dinar", currencyCode: "DZD", exchangeRate: 81.324996999999996, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "American Samoa", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Andorra", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Angola", currencyName: "Angolan Kwanza", currencyCode: "AOA", exchangeRate: 97.889999000000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Anguilla", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Antarctica", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Antigua and Barbuda", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Argentina", currencyName: "Argentine Peso", currencyCode: "ARS", exchangeRate: 8.4012499999999992, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Armenia", currencyName: "Armenian Dram", currencyCode: "AMD", exchangeRate: 408.83999599999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Aruba", currencyName: "Aruban Guilder", currencyCode: "AWG", exchangeRate: 1.79, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Australia", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Austria", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Azerbaijan", currencyName: "Azerbaijan New Manat", currencyCode: "AZN", exchangeRate: 0.7843, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Bahamas", currencyName: "Bahamian Dollar", currencyCode: "BSD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Bahrain", currencyName: "Bahraini Dinar", currencyCode: "BHD", exchangeRate: 0.37709999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Bangladesh", currencyName: "Bangladeshi Taka", currencyCode: "BDT", exchangeRate: 77.480002999999996, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Barbados", currencyName: "Barbados Dollar", currencyCode: "BBD", exchangeRate: 2, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Belarus", currencyName: "Belarussian Ruble", currencyCode: "BYR", exchangeRate: 10515, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Belgium", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Belize", currencyName: "Belize Dollar", currencyCode: "BZD", exchangeRate: 1.9950000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Benin", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Bermuda", currencyName: "Bermudian Dollar", currencyCode: "BMD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Bhutan", currencyName: "Bhutan Ngultrum", currencyCode: "BTN", exchangeRate: 61.095001000000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Bolivia", currencyName: "Boliviano", currencyCode: "BOB", exchangeRate: 6.9100000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Bosnia-Herzegovina", currencyName: "Marka", currencyCode: "BAM", exchangeRate: 1.51295, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Botswana", currencyName: "Botswana Pula", currencyCode: "BWP", exchangeRate: 9.0991999999999997, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Bouvet Island", currencyName: "Norwegian Krone", currencyCode: "NOK", exchangeRate: 6.4035000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Brazil", currencyName: "Brazilian Real", currencyCode: "BRL", exchangeRate: 2.3372000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "British Indian Ocean Territory", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Brunei Darussalam", currencyName: "Brunei Dollar", currencyCode: "BND", exchangeRate: 1.2609999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Bulgaria", currencyName: "Bulgarian Lev", currencyCode: "BGN", exchangeRate: 1.5154000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Burkina Faso", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Burundi", currencyName: "Burundi Franc", currencyCode: "BIF", exchangeRate: 1535, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Cambodia", currencyName: "Kampuchean Riel", currencyCode: "KHR", exchangeRate: 4065, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Cameroon", currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 506.43273900000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Cape Verde", currencyName: "Cape Verde Escudo", currencyCode: "CVE", exchangeRate: 85.5, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Cayman Islands", currencyName: "Cayman Islands Dollar", currencyCode: "KYD", exchangeRate: 0.81999999999999995, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Central African Republic", currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 506.43273900000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Chad", currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 506.43273900000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Chile", currencyName: "Chilean Peso", currencyCode: "CLP", exchangeRate: 591.96997099999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "China", currencyName: "Yuan Renminbi", currencyCode: "CNY", exchangeRate: 6.1478999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Christmas Island", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Cocos (Keeling), Islands", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Colombia", currencyName: "Colombian Peso", currencyCode: "COP", exchangeRate: 1984.400024, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Comoros", currencyName: "Comoros Franc", currencyCode: "KMF", exchangeRate: 380.27499399999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Congo", currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 506.43273900000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Cook Islands", currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 1.2225239999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Costa Rica", currencyName: "Costa Rican Colon", currencyCode: "CRC", exchangeRate: 541.95001200000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Croatia", currencyName: "Croatian Kuna", currencyCode: "HRK", exchangeRate: 5.8852000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Cuba", currencyName: "Cuban Peso", currencyCode: "CUP", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Cyprus", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Czech Rep.", currencyName: "Czech Koruna", currencyCode: "CZK", exchangeRate: 21.247999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Denmark", currencyName: "Danish Krone", currencyCode: "DKK", exchangeRate: 5.7484999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Djibouti", currencyName: "Djibouti Franc", currencyCode: "DJF", exchangeRate: 182, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Dominica", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Dominican Republic", currencyName: "Dominican Peso", currencyCode: "DOP", exchangeRate: 43.810001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Ecuador", currencyName: "Ecuador Sucre", currencyCode: "ECS", exchangeRate: 0, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Egypt", currencyName: "Egyptian Pound", currencyCode: "EGP", exchangeRate: 7.1488500000000004, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "El Salvador", currencyName: "El Salvador Colon", currencyCode: "SVC", exchangeRate: 8.7469999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Equatorial Guinea", currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 506.43273900000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Eritrea", currencyName: "Eritrean Nakfa", currencyCode: "ERN", exchangeRate: 15.1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Estonia", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Ethiopia", currencyName: "Ethiopian Birr", currencyCode: "ETB", exchangeRate: 19.912001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "European Union", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Falkland Islands (Malvinas)", currencyName: "Falkland Islands Pound", currencyCode: "FKP", exchangeRate: 0.61480000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Faroe Islands", currencyName: "Danish Krone", currencyCode: "DKK", exchangeRate: 5.7484999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Fiji", currencyName: "Fiji Dollar", currencyCode: "FJD", exchangeRate: 1.8845000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Finland", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "France", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "French Guiana", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "French Southern Territories", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Gabon", currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 506.43273900000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Gambia", currencyName: "Gambian Dalasi", currencyCode: "GMD", exchangeRate: 39.650002000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Georgia", currencyName: "Georgian Lari", currencyCode: "GEL", exchangeRate: 1.7381500000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Germany", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Ghana", currencyName: "Ghanaian Cedi", currencyCode: "GHS", exchangeRate: 3.5924999999999998, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Gibraltar", currencyName: "Gibraltar Pound", currencyCode: "GIP", exchangeRate: 0.61480000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Great Britain", currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.614838, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Greece", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Greenland", currencyName: "Danish Krone", currencyCode: "DKK", exchangeRate: 5.7484999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Grenada", currencyName: "East Carribean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Guadeloupe (French)", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Guam (USA)", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Guernsey", currencyName: "Pound Sterling", currencyCode: "GGP", exchangeRate: 0, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Guinea Bissau", currencyName: "Guinea-Bissau Peso", currencyCode: "GWP", exchangeRate: 0, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Guinea", currencyName: "Guinea Franc", currencyCode: "GNF", exchangeRate: 6830, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Guyana", currencyName: "Guyana Dollar", currencyCode: "GYD", exchangeRate: 205.699997, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Haiti", currencyName: "Haitian Gourde", currencyCode: "HTG", exchangeRate: 44.700001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Heard Island and McDonald Islands", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Honduras", currencyName: "Honduran Lempira", currencyCode: "HNL", exchangeRate: 21.105, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Hong Kong", currencyName: "Hong Kong Dollar", currencyCode: "HKD", exchangeRate: 7.750845, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Hungary", currencyName: "Hungarian Forint", currencyCode: "HUF", exchangeRate: 242.48500100000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Iceland", currencyName: "Iceland Krona", currencyCode: "ISK", exchangeRate: 118.650002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "India", currencyName: "Indian Rupee", currencyCode: "INR", exchangeRate: 61.080002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Indonesia", currencyName: "Indonesian Rupiah", currencyCode: "IDR", exchangeRate: 11965, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Iran", currencyName: "Iranian Rial", currencyCode: "IRR", exchangeRate: 26661, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Iraq", currencyName: "Iraqi Dinar", currencyCode: "IQD", exchangeRate: 1162, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Ireland", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Isle of Man", currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.614838, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Israel", currencyName: "Israeli New Shekel", currencyCode: "ILS", exchangeRate: 3.6402000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Italy", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Ivory Coast", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Jamaica", currencyName: "Jamaican Dollar", currencyCode: "JMD", exchangeRate: 112.5, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Japan", currencyName: "Japanese Yen", currencyCode: "JPY", exchangeRate: 107.230003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Jersey", currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.614838, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Jordan", currencyName: "Jordanian Dinar", currencyCode: "JOD", exchangeRate: 0.70899999999999996, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Kazakhstan", currencyName: "Kazakhstan Tenge", currencyCode: "KZT", exchangeRate: 181.925003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Kenya", currencyName: "Kenyan Shilling", currencyCode: "KES", exchangeRate: 89.099997999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Kiribati", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Korea-North", currencyName: "North Korean Won", currencyCode: "KPW", exchangeRate: 900, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Korea-South", currencyName: "Korean Won", currencyCode: "KRW", exchangeRate: 1033.4849850000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Kuwait", currencyName: "Kuwaiti Dinar", currencyCode: "KWD", exchangeRate: 0.28739999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Kyrgyzstan", currencyName: "Som", currencyCode: "KGS", exchangeRate: 53.913502000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Laos", currencyName: "Lao Kip", currencyCode: "LAK", exchangeRate: 8044.5, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Latvia", currencyName: "Latvian Lats", currencyCode: "LVL", exchangeRate: 0.54330000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Lebanon", currencyName: "Lebanese Pound", currencyCode: "LBP", exchangeRate: 1513.5, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Lesotho", currencyName: "Lesotho Loti", currencyCode: "LSL", exchangeRate: 10.9, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Liberia", currencyName: "Liberian Dollar", currencyCode: "LRD", exchangeRate: 84.5, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Libya", currencyName: "Libyan Dinar", currencyCode: "LYD", exchangeRate: 1.2235, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Liechtenstein", currencyName: "Swiss Franc", currencyCode: "CHF", exchangeRate: 0.93288499999999996, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Lithuania", currencyName: "Lithuanian Litas", currencyCode: "LTL", exchangeRate: 2.6678000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Luxembourg", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Macau", currencyName: "Macau Pataca", currencyCode: "MOP", exchangeRate: 7.9834500000000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Macedonia", currencyName: "Denar", currencyCode: "MKD", exchangeRate: 47.529998999999997, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Madagascar", currencyName: "Malagasy Franc", currencyCode: "MGF", exchangeRate: 0, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Malawi", currencyName: "Malawi Kwacha", currencyCode: "MWK", exchangeRate: 397.64999399999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Malaysia", currencyName: "Malaysian Ringgit", currencyCode: "MYR", exchangeRate: 3.2170000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Maldives", currencyName: "Maldive Rufiyaa", currencyCode: "MVR", exchangeRate: 15.4, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Mali", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Malta", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Marshall Islands", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Martinique (French)", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Mauritania", currencyName: "Mauritanian Ouguiya", currencyCode: "MRO", exchangeRate: 290.5, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Mauritius", currencyName: "Mauritius Rupee", currencyCode: "MUR", exchangeRate: 31.670000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Mayotte", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Mexico", currencyName: "Mexican Nuevo Peso", currencyCode: "MXN", exchangeRate: 13.168900000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Micronesia", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Moldova", currencyName: "Moldovan Leu", currencyCode: "MDL", exchangeRate: 14.273999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Monaco", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Mongolia", currencyName: "Mongolian Tugrik", currencyCode: "MNT", exchangeRate: 1833.5, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Montenegro", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Montserrat", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Morocco", currencyName: "Moroccan Dirham", currencyCode: "MAD", exchangeRate: 8.5734999999999992, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Mozambique", currencyName: "Mozambique Metical", currencyCode: "MZN", exchangeRate: 30.600000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Myanmar", currencyName: "Myanmar Kyat", currencyCode: "MMK", exchangeRate: 980, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Namibia", currencyName: "Namibian Dollar", currencyCode: "NAD", exchangeRate: 10.956, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Nauru", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Nepal", currencyName: "Nepalese Rupee", currencyCode: "NPR", exchangeRate: 98.580001999999993, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Netherlands Antilles", currencyName: "Netherlands Antillean Guilder", currencyCode: "ANG", exchangeRate: 1.7725, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Netherlands", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "New Caledonia (French)", currencyName: "CFP Franc", currencyCode: "XPF", exchangeRate: 92.139999000000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "New Zealand", currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 1.2225239999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Nicaragua", currencyName: "Nicaraguan Cordoba Oro", currencyCode: "NIO", exchangeRate: 26.225000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Niger", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Nigeria", currencyName: "Nigerian Naira", currencyCode: "NGN", exchangeRate: 163.14999399999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Niue", currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 1.2225239999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Norfolk Island", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Northern Mariana Islands", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Norway", currencyName: "Norwegian Krone", currencyCode: "NOK", exchangeRate: 6.4035000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Oman", currencyName: "Omani Rial", currencyCode: "OMR", exchangeRate: 0.3851, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Pakistan", currencyName: "Pakistan Rupee", currencyCode: "PKR", exchangeRate: 102.75, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Palau", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Panama", currencyName: "Panamanian Balboa", currencyCode: "PAB", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Papua New Guinea", currencyName: "Papua New Guinea Kina", currencyCode: "PGK", exchangeRate: 2.4761000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Paraguay", currencyName: "Paraguay Guarani", currencyCode: "PYG", exchangeRate: 4283.0649409999996, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Peru", currencyName: "Peruvian Nuevo Sol", currencyCode: "PEN", exchangeRate: 2.8639999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Philippines", currencyName: "Philippine Peso", currencyCode: "PHP", exchangeRate: 44.185001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Pitcairn Island", currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 1.2225239999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Poland", currencyName: "Polish Zloty", currencyCode: "PLN", exchangeRate: 3.2341000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Polynesia (French)", currencyName: "CFP Franc", currencyCode: "XPF", exchangeRate: 92.139999000000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Portugal", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Puerto Rico", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Qatar", currencyName: "Qatari Rial", currencyCode: "QAR", exchangeRate: 3.6417999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Reunion (French)", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Romania", currencyName: "Romanian New Leu", currencyCode: "RON", exchangeRate: 3.41065, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Russia", currencyName: "Russian Ruble", currencyCode: "RUB", exchangeRate: 38.340000000000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Rwanda", currencyName: "Rwanda Franc", currencyCode: "RWF", exchangeRate: 688, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Saint Helena", currencyName: "St. Helena Pound", currencyCode: "SHP", exchangeRate: 0.61480000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Saint Kitts & Nevis Anguilla", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Saint Lucia", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Saint Pierre and Miquelon", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Saint Vincent & Grenadines", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Samoa", currencyName: "Samoan Tala", currencyCode: "WST", exchangeRate: 2.3683169999999998, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "San Marino", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Sao Tome and Principe", currencyName: "Dobra", currencyCode: "STD", exchangeRate: 18995, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Saudi Arabia", currencyName: "Saudi Riyal", currencyCode: "SAR", exchangeRate: 3.7507999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Senegal", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Serbia", currencyName: "Dinar", currencyCode: "RSD", exchangeRate: 91.980498999999994, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Seychelles", currencyName: "Seychelles Rupee", currencyCode: "SCR", exchangeRate: 13.045, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Sierra Leone", currencyName: "Sierra Leone Leone", currencyCode: "SLL", exchangeRate: 4370, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Singapore", currencyName: "Singapore Dollar", currencyCode: "SGD", exchangeRate: 1.261315, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Slovakia", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Slovenia", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Solomon Islands", currencyName: "Solomon Islands Dollar", currencyCode: "SBD", exchangeRate: 7.3261060000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Somalia", currencyName: "Somali Shilling", currencyCode: "SOS", exchangeRate: 826, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "South Africa", currencyName: "South African Rand", currencyCode: "ZAR", exchangeRate: 10.91375, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "South Georgia & South Sandwich Islands", currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.614838, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "South Sudan", currencyName: "South Sudan Pound", currencyCode: "SSP", exchangeRate: 0, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Spain", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Sri Lanka", currencyName: "Sri Lanka Rupee", currencyCode: "LKR", exchangeRate: 130.279999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Sudan", currencyName: "Sudanese Pound", currencyCode: "SDG", exchangeRate: 5.6924999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Suriname", currencyName: "Surinam Dollar", currencyCode: "SRD", exchangeRate: 3.2749999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Svalbard and Jan Mayen Islands", currencyName: "Norwegian Krone", currencyCode: "NOK", exchangeRate: 6.4035000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Swaziland", currencyName: "Swaziland Lilangeni", currencyCode: "SZL", exchangeRate: 10.964, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Sweden", currencyName: "Swedish Krona", currencyCode: "SEK", exchangeRate: 7.1234000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Switzerland", currencyName: "Swiss Franc", currencyCode: "CHF", exchangeRate: 0.93288499999999996, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Syria", currencyName: "Syrian Pound", currencyCode: "SYP", exchangeRate: 157.5, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Taiwan", currencyName: "Taiwan Dollar", currencyCode: "TWD", exchangeRate: 30.115499, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Tajikistan", currencyName: "Tajik Somoni", currencyCode: "TJS", exchangeRate: 4.9930000000000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Tanzania", currencyName: "Tanzanian Shilling", currencyCode: "TZS", exchangeRate: 1661.5, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Thailand", currencyName: "Thai Baht", currencyCode: "THB", exchangeRate: 32.229999999999997, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Togo", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Tokelau", currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 1.2225239999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Tonga", currencyName: "Tongan Pa'anga", currencyCode: "TOP", exchangeRate: 1.908571, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Trinidad and Tobago", currencyName: "Trinidad and Tobago Dollar", currencyCode: "TTD", exchangeRate: 6.3479999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Tunisia", currencyName: "Tunisian Dollar", currencyCode: "TND", exchangeRate: 1.7649999999999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Turkey", currencyName: "Turkish Lira", currencyCode: "TRY", exchangeRate: 2.2039, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Turkmenistan", currencyName: "Manat", currencyCode: "TMT", exchangeRate: 2.8504999999999998, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Turks and Caicos Islands", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Tuvalu", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "U.K.", currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.614838, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Uganda", currencyName: "Uganda Shilling", currencyCode: "UGX", exchangeRate: 2605, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Ukraine", currencyName: "Ukraine Hryvnia", currencyCode: "UAH", exchangeRate: 12.993, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "United Arab Emirates", currencyName: "Arab Emirates Dirham", currencyCode: "AED", exchangeRate: 3.673, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Uruguay", currencyName: "Uruguayan Peso", currencyCode: "UYU", exchangeRate: 24.329999999999998, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "USA Minor Outlying Islands", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "United States (USA)", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0, precision:0.25),
            Country(name: "Uzbekistan", currencyName: "Uzbekistan Sum", currencyCode: "UZS", exchangeRate: 2359.5600589999999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Vanuatu", currencyName: "Vanuatu Vatu", currencyCode: "VUV", exchangeRate: 96.199996999999996, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Vatican", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Venezuela", currencyName: "Venezuelan Bolivar", currencyCode: "VEF", exchangeRate: 6.2877000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Vietnam", currencyName: "Vietnamese Dong", currencyCode: "VND", exchangeRate: 21180, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Virgin Islands (British)", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Virgin Islands (USA)", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Wallis and Futuna Islands", currencyName: "CFP Franc", currencyCode: "XPF", exchangeRate: 92.139999000000003, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Western Sahara", currencyName: "Moroccan Dirham", currencyCode: "MAD", exchangeRate: 8.5734999999999992, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Yemen", currencyName: "Yemeni Rial", currencyCode: "YER", exchangeRate: 214.904999, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Zambia", currencyName: "Zambian Kwacha", currencyCode: "ZMW", exchangeRate: 6.1600000000000001, tipRate:0.0, additionalTaxRate:0.0, precision:1.0),
            Country(name: "Zimbabwe", currencyName: "Zimbabwe Dollar", currencyCode: "ZWD", exchangeRate: 0, tipRate:0.0, additionalTaxRate:0.0, precision:1.0)

        ]
        
        localeList = [Locale]()
        
        localeList = [
            Locale(name: "Oslo", additionalTaxRate: getCountry("Norway").additionalTaxRate, tipRate: getCountry("Norway").tipRate, country: getCountry("Norway")),
            Locale(name: "Alabama", additionalTaxRate: 0.085100000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Alaska", additionalTaxRate: 0.016900000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Arizona", additionalTaxRate: 0.081700000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Arkansas", additionalTaxRate: 0.091900000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "California", additionalTaxRate: 0.084100000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Colorado", additionalTaxRate: 0.073900000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Connecticut", additionalTaxRate: 0.063500000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Delaware", additionalTaxRate: 0.000000000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Florida", additionalTaxRate: 0.066200000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Georgia", additionalTaxRate: 0.069700000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Hawaii", additionalTaxRate: 0.043500000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Idaho", additionalTaxRate: 0.060300000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Illinois", additionalTaxRate: 0.081600000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Indiana", additionalTaxRate: 0.070000000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Iowa", additionalTaxRate: 0.067800000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Kansas", additionalTaxRate: 0.081500000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Kentucky", additionalTaxRate: 0.060000000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Louisiana", additionalTaxRate: 0.088900000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Maine", additionalTaxRate: 0.055000000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Maryland", additionalTaxRate: 0.060000000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Massachusetts", additionalTaxRate: 0.062500000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Michigan", additionalTaxRate: 0.060000000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Minnesota", additionalTaxRate: 0.071900000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Mississippi", additionalTaxRate: 0.070000000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Missouri", additionalTaxRate: 0.075800000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Montana", additionalTaxRate: 0.000000000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Nebraska", additionalTaxRate: 0.067900000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Nevada", additionalTaxRate: 0.079300000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "New Hampshire", additionalTaxRate: 0.000000000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "New Jersey", additionalTaxRate: 0.069700000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "New Mexico", additionalTaxRate: 0.072600000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "New York", additionalTaxRate: 0.084700000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "North Carolina", additionalTaxRate: 0.069000000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "North Dakota", additionalTaxRate: 0.065500000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Ohio", additionalTaxRate: 0.071100000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Oklahoma", additionalTaxRate: 0.087200000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Oregon", additionalTaxRate: 0.000000000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Pennsylvania", additionalTaxRate: 0.063400000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Rhode Island", additionalTaxRate: 0.070000000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "South Carolina", additionalTaxRate: 0.071900000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "South Dakota", additionalTaxRate: 0.058300000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Tennessee", additionalTaxRate: 0.094500000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Texas", additionalTaxRate: 0.081500000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Utah", additionalTaxRate: 0.066800000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Vermont", additionalTaxRate: 0.061400000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Virginia (b)", additionalTaxRate: 0.056300000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Washington", additionalTaxRate: 0.088800000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "West Virginia", additionalTaxRate: 0.060700000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Wisconsin", additionalTaxRate: 0.054300000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "Wyoming", additionalTaxRate: 0.054900000, tipRate: 0.20, country: getCountry("United States (USA)")),
            Locale(name: "D.C.", additionalTaxRate: 0.057500000, tipRate: 0.20, country: getCountry("United States (USA)")),
        ]
        
        for countryToIterate in self.countryList
        {
            
            self.localeList.append(Locale(name: countryToIterate.name, additionalTaxRate: countryToIterate.additionalTaxRate, tipRate: countryToIterate.tipRate, country: countryToIterate))
            
            println(String(format: "Created locale from database for %@", countryToIterate.name))
            
        }

    }
    
    
    func refreshCountries() {
        
        let url = "http://finance.yahoo.com/webservice/v1/symbols/allcurrencies/quote?format=json"
        
        Alamofire.request(.GET, url)
            .responseJSON { (request, response, data, error) in
                 // add error handling
                if (error != nil)
                {
                    println(error)
                }
                else
                {
                
                    let jsonData = JSONValue(data!)
                    
                    for resource in jsonData["list"]["resources"].array!
                    {
                        
                        // set the price
                        let quote = resource["resource"]["fields"]["price"].double!
                        
                        // get the currency code from the yahoo quote
                        var currencyCode = resource["resource"]["fields"]["symbol"].string!
                            let stringLength = countElements(currencyCode) // strip this off for the yahoo finance API
                            let substringIndex = stringLength - 2
                            currencyCode = currencyCode.substringToIndex(advance(currencyCode.startIndex, substringIndex))
                        
                        for countryToIterate in self.countryList
                        {
                            if(countryToIterate.currencyCode == currencyCode)
                            {
                                countryToIterate.exchangeRate = quote // set the country exchange rate
                                
                                println(String(format: "updating exchange for %@ in %@ : %f", countryToIterate.currencyCode, countryToIterate.name, countryToIterate.exchangeRate))
                            }
                        }
                    }
                                println("Finished Refreshing Exchange Rates")
                }
            }
        }
    

    func getCountry(countryName:String) -> Country {
        for(var i=0; i < countryList.count; i++)
        {
            if(countryList[i].name == countryName)
            {
                return countryList[i]
            }
        }
        return countryList[0]
    }
    
    func getLocale(localeName: String) -> Locale {
        
        for(var i=0;i < localeList.count; i++)
        {
            if(localeList[i].name == localeName)
            {
                return localeList[i]
            }
        }
        return  Locale(name: "burp", additionalTaxRate: 0.825, tipRate: 0.0, country: getCountry("Czech Rep."))

    }
    

}