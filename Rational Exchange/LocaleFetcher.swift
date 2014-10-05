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

class LocaleList { //:NSObject {
    
    var localeList:[Locale]
    var countryList: [Country]
    var states: [String: String]
    
   // var delegate:ViewController?
    
    init () {//override init() {
        localeList = [Locale]()
//        countryList = [Country]()
//        states = [String: String]()
//        super.init()
        countryList = [
            Country(name: "Afghanistan", currencyName: "Afghanistan Afghani", currencyCode: "AFN", exchangeRate: 1.0, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:"Round up.", taxString:"Tax varies.", ISOAbbreviation:"AF"), // just a test 56.68
            Country(name: "Albania", currencyName: "Albanian Lek", currencyCode: "ALL", exchangeRate: 108.175003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AL"),
            Country(name: "Algeria", currencyName: "Algerian Dinar", currencyCode: "DZD", exchangeRate: 81.324996999999996, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"DZ"),
            Country(name: "American Samoa", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AS"),
            Country(name: "Andorra", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AD"),
            Country(name: "Angola", currencyName: "Angolan Kwanza", currencyCode: "AOA", exchangeRate: 97.889999000000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AO"),
            Country(name: "Anguilla", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AI"),
            Country(name: "Antarctica", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AQ"),
            Country(name: "Antigua and Barbuda", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AG"),
            Country(name: "Argentina", currencyName: "Argentine Peso", currencyCode: "ARS", exchangeRate: 8.4012499999999992, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AR"),
            Country(name: "Armenia", currencyName: "Armenian Dram", currencyCode: "AMD", exchangeRate: 408.83999599999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AM"),
            Country(name: "Aruba", currencyName: "Aruban Guilder", currencyCode: "AWG", exchangeRate: 1.79, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AW"),
            Country(name: "Australia", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AU"),
            Country(name: "Austria", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.05, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AT"),
            Country(name: "Azerbaijan", currencyName: "Azerbaijan New Manat", currencyCode: "AZN", exchangeRate: 0.7843, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AZ"),
            Country(name: "Bahamas", currencyName: "Bahamian Dollar", currencyCode: "BSD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BS"),
            Country(name: "Bahrain", currencyName: "Bahraini Dinar", currencyCode: "BHD", exchangeRate: 0.37709999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BH"),
            Country(name: "Bangladesh", currencyName: "Bangladeshi Taka", currencyCode: "BDT", exchangeRate: 77.480002999999996, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BD"),
            Country(name: "Barbados", currencyName: "Barbados Dollar", currencyCode: "BBD", exchangeRate: 2, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BB"),
            Country(name: "Belarus", currencyName: "Belarussian Ruble", currencyCode: "BYR", exchangeRate: 10515, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BY"),
            Country(name: "Belgium", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BE"),
            Country(name: "Belize", currencyName: "Belize Dollar", currencyCode: "BZD", exchangeRate: 1.9950000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BZ"),
            Country(name: "Benin", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BJ"),
            Country(name: "Bermuda", currencyName: "Bermudian Dollar", currencyCode: "BMD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BM"),
            Country(name: "Bhutan", currencyName: "Bhutan Ngultrum", currencyCode: "BTN", exchangeRate: 61.095001000000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BT"),
            Country(name: "Bolivia", currencyName: "Boliviano", currencyCode: "BOB", exchangeRate: 6.9100000000000001, tipRate:0.05, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BO"),
            Country(name: "Bosnia-Herzegovina", currencyName: "Marka", currencyCode: "BAM", exchangeRate: 1.51295, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BA"),
            Country(name: "Botswana", currencyName: "Botswana Pula", currencyCode: "BWP", exchangeRate: 9.0991999999999997, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BW"),
            Country(name: "Bouvet Island", currencyName: "Norwegian Krone", currencyCode: "NOK", exchangeRate: 6.4035000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BV"),
            Country(name: "Brazil", currencyName: "Brazilian Real", currencyCode: "BRL", exchangeRate: 2.3372000000000002, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BR"),
            Country(name: "British Indian Ocean Territory", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"IO"),
            Country(name: "Brunei Darussalam", currencyName: "Brunei Dollar", currencyCode: "BND", exchangeRate: 1.2609999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BN"),
            Country(name: "Bulgaria", currencyName: "Bulgarian Lev", currencyCode: "BGN", exchangeRate: 1.5154000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BG"),
            Country(name: "Burkina Faso", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BF"),
            Country(name: "Burundi", currencyName: "Burundi Franc", currencyCode: "BIF", exchangeRate: 1535, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"BI"),
            Country(name: "Cambodia", currencyName: "Kampuchean Riel", currencyCode: "KHR", exchangeRate: 4065, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"KH"),
            Country(name: "Cameroon", currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 506.43273900000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CM"),
            Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA"),
            Country(name: "Cape Verde", currencyName: "Cape Verde Escudo", currencyCode: "CVE", exchangeRate: 85.5, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CV"),
            Country(name: "Cayman Islands", currencyName: "Cayman Islands Dollar", currencyCode: "KYD", exchangeRate: 0.81999999999999995, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"KY"),
            Country(name: "Central African Republic", currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 506.43273900000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CF"),
            Country(name: "Chad", currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 506.43273900000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TD"),
            Country(name: "Chile", currencyName: "Chilean Peso", currencyCode: "CLP", exchangeRate: 591.96997099999999, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CL"),
            Country(name: "China", currencyName: "Yuan Renminbi", currencyCode: "CNY", exchangeRate: 6.1478999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CN"),
            Country(name: "Christmas Island", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CX"),
            Country(name: "Cocos (Keeling|), Islands", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CC"),
            Country(name: "Colombia", currencyName: "Colombian Peso", currencyCode: "COP", exchangeRate: 1984.400024, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CO"),
            Country(name: "Comoros", currencyName: "Comoros Franc", currencyCode: "KMF", exchangeRate: 380.27499399999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"KM"),
            Country(name: "Congo", currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 506.43273900000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CG"),
            Country(name: "Cook Islands", currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 1.2225239999999999, tipRate:0.0, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CK"),
            Country(name: "Costa Rica", currencyName: "Costa Rican Colon", currencyCode: "CRC", exchangeRate: 541.95001200000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CR"),
            Country(name: "Croatia", currencyName: "Croatian Kuna", currencyCode: "HRK", exchangeRate: 5.8852000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"HR"),
            Country(name: "Cuba", currencyName: "Cuban Peso", currencyCode: "CUP", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CU"),
            Country(name: "Cyprus", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CY"),
            Country(name: "Czech Republic", currencyName: "Czech Koruna", currencyCode: "CZK", exchangeRate: 21.247999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CZ"),
            Country(name: "Denmark", currencyName: "Danish Krone", currencyCode: "DKK", exchangeRate: 5.7484999999999999, tipRate:0.0, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"DK"),
            Country(name: "Djibouti", currencyName: "Djibouti Franc", currencyCode: "DJF", exchangeRate: 182, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"DJ"),
            Country(name: "Dominica", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"DM"),
            Country(name: "Dominican Republic", currencyName: "Dominican Peso", currencyCode: "DOP", exchangeRate: 43.810001, tipRate:0.2, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"DO"),
            Country(name: "Ecuador", currencyName: "Ecuador Sucre", currencyCode: "ECS", exchangeRate: 0, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"EC"),
            Country(name: "Egypt", currencyName: "Egyptian Pound", currencyCode: "EGP", exchangeRate: 7.1488500000000004, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"EG"),
            Country(name: "El Salvador", currencyName: "El Salvador Colon", currencyCode: "SVC", exchangeRate: 8.7469999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SV"),
            Country(name: "Equatorial Guinea", currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 506.43273900000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GQ"),
            Country(name: "Eritrea", currencyName: "Eritrean Nakfa", currencyCode: "ERN", exchangeRate: 15.1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"ER"),
            Country(name: "Estonia", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"EE"),
            Country(name: "Ethiopia", currencyName: "Ethiopian Birr", currencyCode: "ETB", exchangeRate: 19.912001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"ET"),
            Country(name: "European Union", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"EU"),
            Country(name: "Falkland Islands (Malvinas)", currencyName: "Falkland Islands Pound", currencyCode: "FKP", exchangeRate: 0.61480000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"FK"),
            Country(name: "Faroe Islands", currencyName: "Danish Krone", currencyCode: "DKK", exchangeRate: 5.7484999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"FO"),
            Country(name: "Fiji", currencyName: "Fiji Dollar", currencyCode: "FJD", exchangeRate: 1.8845000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"FJ"),
            Country(name: "Finland", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:"Leave the change for exceptional service.", taxString:nil, ISOAbbreviation:"FI"),
            Country(name: "France", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"FR"),
            Country(name: "French Guiana", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GF"),
            Country(name: "French Southern Territories", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TF"),
            Country(name: "Gabon", currencyName: "CFA Franc BEAC", currencyCode: "XAF", exchangeRate: 506.43273900000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GA"),
            Country(name: "Gambia", currencyName: "Gambian Dalasi", currencyCode: "GMD", exchangeRate: 39.650002000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GM"),
            Country(name: "Georgia (Country)", currencyName: "Georgian Lari", currencyCode: "GEL", exchangeRate: 1.7381500000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GE"),
            Country(name: "Germany", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.05, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"DE"),
            Country(name: "Ghana", currencyName: "Ghanaian Cedi", currencyCode: "GHS", exchangeRate: 3.5924999999999998, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GH"),
            Country(name: "Gibraltar", currencyName: "Gibraltar Pound", currencyCode: "GIP", exchangeRate: 0.61480000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GI"),
            Country(name: "England", currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.614838, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:"Bartenders don't expect tips.", taxString:nil, ISOAbbreviation:"GB"),
            Country(name: "Greece", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:"Round your bill up.", taxString:nil, ISOAbbreviation:"GR"),
            Country(name: "Greenland", currencyName: "Danish Krone", currencyCode: "DKK", exchangeRate: 5.7484999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GL"),
            Country(name: "Grenada", currencyName: "East Carribean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GD"),
            Country(name: "Guadeloupe (French)", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GP"),
            Country(name: "Guam (USA)", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GU"),
            Country(name: "Guernsey", currencyName: "Pound Sterling", currencyCode: "GGP", exchangeRate: 0, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GG"),
            Country(name: "Guinea Bissau", currencyName: "Guinea-Bissau Peso", currencyCode: "GWP", exchangeRate: 0, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GW"),
            Country(name: "Guinea", currencyName: "Guinea Franc", currencyCode: "GNF", exchangeRate: 6830, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GN"),
            Country(name: "Guyana", currencyName: "Guyana Dollar", currencyCode: "GYD", exchangeRate: 205.699997, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GY"),
            Country(name: "Haiti", currencyName: "Haitian Gourde", currencyCode: "HTG", exchangeRate: 44.700001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"HT"),
            Country(name: "Heard Island and McDonald Islands", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"HM"),
            Country(name: "Honduras", currencyName: "Honduran Lempira", currencyCode: "HNL", exchangeRate: 21.105, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"HN"),
            Country(name: "Hong Kong", currencyName: "Hong Kong Dollar", currencyCode: "HKD", exchangeRate: 7.750845, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"HK"),
            Country(name: "Hungary", currencyName: "Hungarian Forint", currencyCode: "HUF", exchangeRate: 242.48500100000001, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"HU"),
            Country(name: "Iceland", currencyName: "Iceland Krona", currencyCode: "ISK", exchangeRate: 118.650002, tipRate:0.0, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"IS"),
            Country(name: "India", currencyName: "Indian Rupee", currencyCode: "INR", exchangeRate: 61.080002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"IN"),
            Country(name: "Indonesia", currencyName: "Indonesian Rupiah", currencyCode: "IDR", exchangeRate: 11965, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"ID"),
            Country(name: "Iran", currencyName: "Iranian Rial", currencyCode: "IRR", exchangeRate: 26661, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"IR"),
            Country(name: "Iraq", currencyName: "Iraqi Dinar", currencyCode: "IQD", exchangeRate: 1162, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"IQ"),
            Country(name: "Ireland", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.0, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"IE"),
            Country(name: "Isle of Man", currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.614838, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"IM"),
            Country(name: "Israel", currencyName: "Israeli New Shekel", currencyCode: "ILS", exchangeRate: 3.6402000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"IL"),
            Country(name: "Italy", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:"You can leave the change.", taxString:nil, ISOAbbreviation:"IT"),
            Country(name: "Ivory Coast", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CI"),
            Country(name: "Jamaica", currencyName: "Jamaican Dollar", currencyCode: "JMD", exchangeRate: 112.5, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"JM"),
            Country(name: "Japan", currencyName: "Japanese Yen", currencyCode: "JPY", exchangeRate: 107.230003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"JP"),
            Country(name: "Jersey", currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.614838, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"JE"),
            Country(name: "Jordan", currencyName: "Jordanian Dinar", currencyCode: "JOD", exchangeRate: 0.70899999999999996, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"JO"),
            Country(name: "Kazakhstan", currencyName: "Kazakhstan Tenge", currencyCode: "KZT", exchangeRate: 181.925003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"KZ"),
            Country(name: "Kenya", currencyName: "Kenyan Shilling", currencyCode: "KES", exchangeRate: 89.099997999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"KE"),
            Country(name: "Kiribati", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"KI"),
            Country(name: "Korea-North", currencyName: "North Korean Won", currencyCode: "KPW", exchangeRate: 900, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"KP"),
            Country(name: "Korea-South", currencyName: "Korean Won", currencyCode: "KRW", exchangeRate: 1033.4849850000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"KR"),
            Country(name: "Kuwait", currencyName: "Kuwaiti Dinar", currencyCode: "KWD", exchangeRate: 0.28739999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"KW"),
            Country(name: "Kyrgyzstan", currencyName: "Som", currencyCode: "KGS", exchangeRate: 53.913502000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"KG"),
            Country(name: "Laos", currencyName: "Lao Kip", currencyCode: "LAK", exchangeRate: 8044.5, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"LA"),
            Country(name: "Latvia", currencyName: "Latvian Lats", currencyCode: "LVL", exchangeRate: 0.54330000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"LV"),
            Country(name: "Lebanon", currencyName: "Lebanese Pound", currencyCode: "LBP", exchangeRate: 1513.5, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"LB"),
            Country(name: "Lesotho", currencyName: "Lesotho Loti", currencyCode: "LSL", exchangeRate: 10.9, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"LS"),
            Country(name: "Liberia", currencyName: "Liberian Dollar", currencyCode: "LRD", exchangeRate: 84.5, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"LR"),
            Country(name: "Libya", currencyName: "Libyan Dinar", currencyCode: "LYD", exchangeRate: 1.2235, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"LY"),
            Country(name: "Liechtenstein", currencyName: "Swiss Franc", currencyCode: "CHF", exchangeRate: 0.93288499999999996, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"LI"),
            Country(name: "Lithuania", currencyName: "Lithuanian Litas", currencyCode: "LTL", exchangeRate: 2.6678000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"LT"),
            Country(name: "Luxembourg", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"LU"),
            Country(name: "Macau", currencyName: "Macau Pataca", currencyCode: "MOP", exchangeRate: 7.9834500000000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MO"),
            Country(name: "Macedonia", currencyName: "Denar", currencyCode: "MKD", exchangeRate: 47.529998999999997, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MK"),
            Country(name: "Madagascar", currencyName: "Malagasy Franc", currencyCode: "MGF", exchangeRate: 0, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MG"),
            Country(name: "Malawi", currencyName: "Malawi Kwacha", currencyCode: "MWK", exchangeRate: 397.64999399999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MW"),
            Country(name: "Malaysia", currencyName: "Malaysian Ringgit", currencyCode: "MYR", exchangeRate: 3.2170000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MY"),
            Country(name: "Maldives", currencyName: "Maldive Rufiyaa", currencyCode: "MVR", exchangeRate: 15.4, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MV"),
            Country(name: "Mali", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"ML"),
            Country(name: "Malta", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MT"),
            Country(name: "Marshall Islands", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MH"),
            Country(name: "Martinique (French)", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MQ"),
            Country(name: "Mauritania", currencyName: "Mauritanian Ouguiya", currencyCode: "MRO", exchangeRate: 290.5, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MR"),
            Country(name: "Mauritius", currencyName: "Mauritius Rupee", currencyCode: "MUR", exchangeRate: 31.670000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MU"),
            Country(name: "Mayotte", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"YT"),
            Country(name: "Mexico", currencyName: "Mexican Nuevo Peso", currencyCode: "MXN", exchangeRate: 13.168900000000001, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MX"),
            Country(name: "Micronesia", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"FM"),
            Country(name: "Moldova", currencyName: "Moldovan Leu", currencyCode: "MDL", exchangeRate: 14.273999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MD"),
            Country(name: "Monaco", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MC"),
            Country(name: "Mongolia", currencyName: "Mongolian Tugrik", currencyCode: "MNT", exchangeRate: 1833.5, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MN"),
            Country(name: "Montenegro", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"ME"),
            Country(name: "Montserrat", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MS"),
            Country(name: "Morocco", currencyName: "Moroccan Dirham", currencyCode: "MAD", exchangeRate: 8.5734999999999992, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MA"),
            Country(name: "Mozambique", currencyName: "Mozambique Metical", currencyCode: "MZN", exchangeRate: 30.600000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MZ"),
            Country(name: "Myanmar", currencyName: "Myanmar Kyat", currencyCode: "MMK", exchangeRate: 980, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MM"),
            Country(name: "Namibia", currencyName: "Namibian Dollar", currencyCode: "NAD", exchangeRate: 10.956, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"NA"),
            Country(name: "Nauru", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"NR"),
            Country(name: "Nepal", currencyName: "Nepalese Rupee", currencyCode: "NPR", exchangeRate: 98.580001999999993, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"NP"),
            Country(name: "Netherlands Antilles", currencyName: "Netherlands Antillean Guilder", currencyCode: "ANG", exchangeRate: 1.7725, tipRate:0.05, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AN"),
            Country(name: "The Netherlands", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"NL"),
            Country(name: "New Caledonia (French)", currencyName: "CFP Franc", currencyCode: "XPF", exchangeRate: 92.139999000000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"NC"),
            Country(name: "New Zealand", currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 1.2225239999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"NZ"),
            Country(name: "Nicaragua", currencyName: "Nicaraguan Cordoba Oro", currencyCode: "NIO", exchangeRate: 26.225000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"NI"),
            Country(name: "Niger", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"NE"),
            Country(name: "Nigeria", currencyName: "Nigerian Naira", currencyCode: "NGN", exchangeRate: 163.14999399999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"NG"),
            Country(name: "Niue", currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 1.2225239999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"NU"),
            Country(name: "Norfolk Island", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"NF"),
            Country(name: "Northern Mariana Islands", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"MP"),
            Country(name: "Norway", currencyName: "Norwegian Krone", currencyCode: "NOK", exchangeRate: 6.4035000000000002, tipRate:0.0, additionalTaxRate:0.0, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"NO"),
            Country(name: "Oman", currencyName: "Omani Rial", currencyCode: "OMR", exchangeRate: 0.3851, tipRate:0.0, additionalTaxRate:0.0, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"OM"),
            Country(name: "Pakistan", currencyName: "Pakistan Rupee", currencyCode: "PKR", exchangeRate: 102.75, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"PK"),
            Country(name: "Palau", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"PW"),
            Country(name: "Panama", currencyName: "Panamanian Balboa", currencyCode: "PAB", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"PA"),
            Country(name: "Papua New Guinea", currencyName: "Papua New Guinea Kina", currencyCode: "PGK", exchangeRate: 2.4761000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"PG"),
            Country(name: "Paraguay", currencyName: "Paraguay Guarani", currencyCode: "PYG", exchangeRate: 4283.0649409999996, tipRate:0.0, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"PY"),
            Country(name: "Peru", currencyName: "Peruvian Nuevo Sol", currencyCode: "PEN", exchangeRate: 2.8639999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"PE"),
            Country(name: "Philippines", currencyName: "Philippine Peso", currencyCode: "PHP", exchangeRate: 44.185001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"PH"),
            Country(name: "Pitcairn Island", currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 1.2225239999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"PN"),
            Country(name: "Poland", currencyName: "Polish Zloty", currencyCode: "PLN", exchangeRate: 3.2341000000000002, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"PL"),
            Country(name: "Polynesia (French)", currencyName: "CFP Franc", currencyCode: "XPF", exchangeRate: 92.139999000000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"PF"),
            Country(name: "Portugal", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:"Tips are usually small.", taxString:nil, ISOAbbreviation:"PT"),
            Country(name: "Puerto Rico", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"PR"),
            Country(name: "Qatar", currencyName: "Qatari Rial", currencyCode: "QAR", exchangeRate: 3.6417999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"QA"),
            Country(name: "Reunion (French)", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"RE"),
            Country(name: "Romania", currencyName: "Romanian New Leu", currencyCode: "RON", exchangeRate: 3.41065, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"RO"),
            Country(name: "Russia", currencyName: "Russian Ruble", currencyCode: "RUB", exchangeRate: 38.340000000000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"RU"),
            Country(name: "Rwanda", currencyName: "Rwanda Franc", currencyCode: "RWF", exchangeRate: 688, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"RW"),
            Country(name: "Saint Helena", currencyName: "St. Helena Pound", currencyCode: "SHP", exchangeRate: 0.61480000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SH"),
            Country(name: "Saint Kitts & Nevis Anguilla", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"KN"),
            Country(name: "Saint Lucia", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"LC"),
            Country(name: "Saint Pierre and Miquelon", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"PM"),
            Country(name: "Saint Vincent & Grenadines", currencyName: "East Caribbean Dollar", currencyCode: "XCD", exchangeRate: 2.7000000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"VC"),
            Country(name: "Samoa", currencyName: "Samoan Tala", currencyCode: "WST", exchangeRate: 2.3683169999999998, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"WS"),
            Country(name: "San Marino", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SM"),
            Country(name: "Sao Tome and Principe", currencyName: "Dobra", currencyCode: "STD", exchangeRate: 18995, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"ST"),
            Country(name: "Saudi Arabia", currencyName: "Saudi Riyal", currencyCode: "SAR", exchangeRate: 3.7507999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SA"),
            Country(name: "Senegal", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SN"),
            Country(name: "Serbia", currencyName: "Dinar", currencyCode: "RSD", exchangeRate: 91.980498999999994, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"RS"),
            Country(name: "Seychelles", currencyName: "Seychelles Rupee", currencyCode: "SCR", exchangeRate: 13.045, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SC"),
            Country(name: "Sierra Leone", currencyName: "Sierra Leone Leone", currencyCode: "SLL", exchangeRate: 4370, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SL"),
            Country(name: "Singapore", currencyName: "Singapore Dollar", currencyCode: "SGD", exchangeRate: 1.261315, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SG"),
            Country(name: "Slovakia", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SK"),
            Country(name: "Slovenia", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SI"),
            Country(name: "Solomon Islands", currencyName: "Solomon Islands Dollar", currencyCode: "SBD", exchangeRate: 7.3261060000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SB"),
            Country(name: "Somalia", currencyName: "Somali Shilling", currencyCode: "SOS", exchangeRate: 826, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SO"),
            Country(name: "South Africa", currencyName: "South African Rand", currencyCode: "ZAR", exchangeRate: 10.91375, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"ZA"),
            Country(name: "South Georgia & South Sandwich Islands", currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.614838, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GS"),
            Country(name: "South Sudan", currencyName: "South Sudan Pound", currencyCode: "SSP", exchangeRate: 0, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SS"),
            Country(name: "Spain", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:0.1, additionalTaxRate:nil, precision:1.0, tipString:"Round up to the nearest Euro", taxString:nil, ISOAbbreviation:"ES"),
            Country(name: "Sri Lanka", currencyName: "Sri Lanka Rupee", currencyCode: "LKR", exchangeRate: 130.279999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"LK"),
            Country(name: "Sudan", currencyName: "Sudanese Pound", currencyCode: "SDG", exchangeRate: 5.6924999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SD"),
            Country(name: "Suriname", currencyName: "Surinam Dollar", currencyCode: "SRD", exchangeRate: 3.2749999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SR"),
            Country(name: "Svalbard and Jan Mayen Islands", currencyName: "Norwegian Krone", currencyCode: "NOK", exchangeRate: 6.4035000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SJ"),
            Country(name: "Swaziland", currencyName: "Swaziland Lilangeni", currencyCode: "SZL", exchangeRate: 10.964, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SZ"),
            Country(name: "Sweden", currencyName: "Swedish Krona", currencyCode: "SEK", exchangeRate: 7.1234000000000002, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:"Round up, but not expected.", taxString:nil, ISOAbbreviation:"SE"),
            Country(name: "Switzerland", currencyName: "Swiss Franc", currencyCode: "CHF", exchangeRate: 0.93288499999999996, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:"Round up to the nearest franc.", taxString:nil, ISOAbbreviation:"CH"),
            Country(name: "Syria", currencyName: "Syrian Pound", currencyCode: "SYP", exchangeRate: 157.5, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"SY"),
            Country(name: "Taiwan", currencyName: "Taiwan Dollar", currencyCode: "TWD", exchangeRate: 30.115499, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TW"),
            Country(name: "Tajikistan", currencyName: "Tajik Somoni", currencyCode: "TJS", exchangeRate: 4.9930000000000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TJ"),
            Country(name: "Tanzania", currencyName: "Tanzanian Shilling", currencyCode: "TZS", exchangeRate: 1661.5, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TZ"),
            Country(name: "Thailand", currencyName: "Thai Baht", currencyCode: "THB", exchangeRate: 32.229999999999997, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TH"),
            Country(name: "Togo", currencyName: "CFA Franc BCEAO", currencyCode: "XOF", exchangeRate: 507.14999399999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TG"),
            Country(name: "Tokelau", currencyName: "New Zealand Dollar", currencyCode: "NZD", exchangeRate: 1.2225239999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TK"),
            Country(name: "Tonga", currencyName: "Tongan Pa'anga", currencyCode: "TOP", exchangeRate: 1.908571, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TO"),
            Country(name: "Trinidad and Tobago", currencyName: "Trinidad and Tobago Dollar", currencyCode: "TTD", exchangeRate: 6.3479999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TT"),
            Country(name: "Tunisia", currencyName: "Tunisian Dollar", currencyCode: "TND", exchangeRate: 1.7649999999999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TN"),
            Country(name: "Turkey", currencyName: "Turkish Lira", currencyCode: "TRY", exchangeRate: 2.2039, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TR"),
            Country(name: "Turkmenistan", currencyName: "Manat", currencyCode: "TMT", exchangeRate: 2.8504999999999998, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TM"),
            Country(name: "Turks and Caicos Islands", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TC"),
            Country(name: "Tuvalu", currencyName: "Australian Dollar", currencyCode: "AUD", exchangeRate: 1.102633, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"TV"),
            Country(name: "U.K.", currencyName: "Pound Sterling", currencyCode: "GBP", exchangeRate: 0.614838, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"GB"),
            Country(name: "Uganda", currencyName: "Uganda Shilling", currencyCode: "UGX", exchangeRate: 2605, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"UG"),
            Country(name: "Ukraine", currencyName: "Ukraine Hryvnia", currencyCode: "UAH", exchangeRate: 12.993, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"UA"),
            Country(name: "United Arab Emirates", currencyName: "Arab Emirates Dirham", currencyCode: "AED", exchangeRate: 3.673, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"AE"),
            Country(name: "Uruguay", currencyName: "Uruguayan Peso", currencyCode: "UYU", exchangeRate: 24.329999999999998, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"UY"),
            Country(name: "USA Minor Outlying Islands", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"UM"),
            Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US"),
            Country(name: "Uzbekistan", currencyName: "Uzbekistan Sum", currencyCode: "UZS", exchangeRate: 2359.5600589999999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"UZ"),
            Country(name: "Vanuatu", currencyName: "Vanuatu Vatu", currencyCode: "VUV", exchangeRate: 96.199996999999996, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"VU"),
            Country(name: "Vatican", currencyName: "Euro", currencyCode: "EUR", exchangeRate: 0.77190300000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"VA"),
            Country(name: "Venezuela", currencyName: "Venezuelan Bolivar", currencyCode: "VEF", exchangeRate: 6.2877000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"VE"),
            Country(name: "Vietnam", currencyName: "Vietnamese Dong", currencyCode: "VND", exchangeRate: 21180, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"VN"),
            Country(name: "Virgin Islands (British)", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"VG"),
            Country(name: "Virgin Islands (USA)", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"VI"),
            Country(name: "Wallis and Futuna Islands", currencyName: "CFP Franc", currencyCode: "XPF", exchangeRate: 92.139999000000003, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"WF"),
            Country(name: "Western Sahara", currencyName: "Moroccan Dirham", currencyCode: "MAD", exchangeRate: 8.5734999999999992, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"EH"),
            Country(name: "Yemen", currencyName: "Yemeni Rial", currencyCode: "YER", exchangeRate: 214.904999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"YE"),
            Country(name: "Zambia", currencyName: "Zambian Kwacha", currencyCode: "ZMW", exchangeRate: 6.1600000000000001, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"ZM"),
            Country(name: "Zimbabwe", currencyName: "Zimbabwe Dollar", currencyCode: "ZWD", exchangeRate: 0, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"ZW"),
            
            
            Country(name: "Choose a Country", currencyName: "Money? Stone tablets?", currencyCode: "USD", exchangeRate: 1, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"C1")
                    ]
        
        states = [
            "AL": "Alabama",
            "AK": "Alaska",
            "AZ": "Arizona",
            "AR": "Arkansas",
            "CA": "California",
            "CO": "Colorado",
            "CT": "Connecticut",
            "DE": "Delaware",
            "DC": "District of Columbia",
            "FL": "Florida",
            "GA": "Georgia",
            "HI": "Hawaii",
            "ID": "Idaho",
            "IL": "Illinois",
            "IN": "Indiana",
            "IA": "Iowa",
            "KS": "Kansas",
            "KY": "Kentucky",
            "LA": "Louisiana",
            "ME": "Maine",
            "MD": "Maryland",
            "MA": "Massachusetts",
            "MI": "Michigan",
            "MN": "Minnesota",
            "MS": "Mississippi",
            "MO": "Missouri",
            "MT": "Montana",
            "NE": "Nebraska",
            "NV": "Nevada",
            "NH": "New Hampshire",
            "NJ": "New Jersey",
            "NM": "New Mexico",
            "NY": "New York",
            "NC": "North Carolina",
            "ND": "North Dakota",
            "OH": "Ohio",
            "OK": "Oklahoma",
            "OR": "Oregon",
            "PA": "Pennsylvania",
            "RI": "Rhode Island",
            "SC": "South Carolina",
            "SD": "South Dakota",
            "TN": "Tennessee",
            "TX": "Texas",
            "UT": "Utah",
            "VT": "Vermont",
            "VA": "Virginia",
            "WA": "Washington",
            "WV": "West Virginia",
            "WI": "Wisconsin",
            "WY": "Wyoming",
            
            "AB": "Alberta",
            "BC": "British Columbia",
            "MB": "Manitoba",
            "NB": "New Brunswick",
            "NL": "Newfoundland and Labrador",
            "NS": "Nova Scotia",
            "NT": "Northwest Territories",
            "NU": "Nunavut",
            "ON": "Ontario",
            "PE": "Prince Edward Island",
            "QC": "Quebec",
            "SK": "Saskatchewan",
            "YT": "Yukon"
        ]
        

        
        
        localeList = [
            Locale(name: "Prague", additionalTaxRate: getCountry("Czech Republic").additionalTaxRate, tipRate: 0.1, country: Country(name: "Czech Republic", currencyName: "Czech Koruna", currencyCode: "CZK", exchangeRate: 21.247999, tipRate:nil, additionalTaxRate:nil, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CZ")),
            
            Locale(name:"Alberta", additionalTaxRate: 0.05, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            Locale(name:"British Columbia", additionalTaxRate: 0.12, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            Locale(name:"Manitoba", additionalTaxRate: 0.13, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            Locale(name:"New Brunswick", additionalTaxRate: 0.13, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            Locale(name:"Newfoundland and Labrador", additionalTaxRate: 0.13, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            Locale(name:"Northwest Territories", additionalTaxRate: 0.05, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            Locale(name:"Nova Scotia", additionalTaxRate: 0.15, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            Locale(name:"Nunavut", additionalTaxRate: 0.05, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            Locale(name:"Ontario", additionalTaxRate: 0.13, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            Locale(name:"Prince Edward Island", additionalTaxRate: 0.14, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            Locale(name:"Quebec", additionalTaxRate: 0.14975, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            Locale(name:"Saskatchewan", additionalTaxRate: 0.10, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            Locale(name:"Yukon", additionalTaxRate: 0.05, tipRate: 0.20, country: Country(name: "Canada", currencyName: "Canadian Dollar", currencyCode: "CAD", exchangeRate: 1.0979099999999999, tipRate:0.2, additionalTaxRate:0.0875, precision:1.0, tipString:nil, taxString:nil, ISOAbbreviation:"CA")),
            
            Locale(name: "Alabama", additionalTaxRate: 0.085100000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Alaska", additionalTaxRate: 0.016900000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Arizona", additionalTaxRate: 0.081700000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Arkansas", additionalTaxRate: 0.091900000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "California", additionalTaxRate: 0.084100000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Colorado", additionalTaxRate: 0.073900000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Connecticut", additionalTaxRate: 0.063500000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Delaware", additionalTaxRate: 0.000000000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Florida", additionalTaxRate: 0.066200000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Georgia", additionalTaxRate: 0.069700000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Hawaii", additionalTaxRate: 0.043500000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Idaho", additionalTaxRate: 0.060300000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Illinois", additionalTaxRate: 0.081600000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Indiana", additionalTaxRate: 0.070000000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Iowa", additionalTaxRate: 0.067800000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Kansas", additionalTaxRate: 0.081500000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Kentucky", additionalTaxRate: 0.060000000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Louisiana", additionalTaxRate: 0.088900000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Maine", additionalTaxRate: 0.055000000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Maryland", additionalTaxRate: 0.060000000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Massachusetts", additionalTaxRate: 0.062500000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Michigan", additionalTaxRate: 0.060000000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Minnesota", additionalTaxRate: 0.071900000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Mississippi", additionalTaxRate: 0.070000000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Missouri", additionalTaxRate: 0.075800000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Montana", additionalTaxRate: 0.000000000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Nebraska", additionalTaxRate: 0.067900000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Nevada", additionalTaxRate: 0.079300000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "New Hampshire", additionalTaxRate: 0.000000000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "New Jersey", additionalTaxRate: 0.069700000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "New Mexico", additionalTaxRate: 0.072600000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "New York", additionalTaxRate: 0.084700000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "North Carolina", additionalTaxRate: 0.069000000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "North Dakota", additionalTaxRate: 0.065500000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Ohio", additionalTaxRate: 0.071100000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Oklahoma", additionalTaxRate: 0.087200000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Oregon", additionalTaxRate: 0.000000000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Pennsylvania", additionalTaxRate: 0.063400000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Rhode Island", additionalTaxRate: 0.070000000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "South Carolina", additionalTaxRate: 0.071900000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "South Dakota", additionalTaxRate: 0.058300000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Tennessee", additionalTaxRate: 0.094500000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Texas", additionalTaxRate: 0.081500000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Utah", additionalTaxRate: 0.066800000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Vermont", additionalTaxRate: 0.061400000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Virginia", additionalTaxRate: 0.056300000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Washington", additionalTaxRate: 0.088800000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "West Virginia", additionalTaxRate: 0.060700000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Wisconsin", additionalTaxRate: 0.054300000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "Wyoming", additionalTaxRate: 0.054900000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")),
            Locale(name: "District of Columbia", additionalTaxRate: 0.057500000, tipRate: 0.20, country: Country(name: "United States", currencyName: "US Dollar", currencyCode: "USD", exchangeRate: 1, tipRate: 0.15, additionalTaxRate:0.0964, precision:0.25, tipString:nil, taxString:nil, ISOAbbreviation:"US")
            )
        ]
        
        readCachedCountries()
        
        for countryToIterate in self.countryList
        {
            if(countryToIterate.exchangeRate != 0) {
                self.localeList.append(Locale(name: countryToIterate.name, additionalTaxRate: countryToIterate.additionalTaxRate, tipRate: countryToIterate.tipRate, country: countryToIterate))                
            }
        }
    
      // Parse Retreival
       
        
        
    }
        
    let cache = AwesomeCache<NSNumber>(name: "awesomeCache")
    
    func readCachedCountries () {
        for country in countryList {
            if((cache[country.name]) != nil) {
            country.exchangeRate = cache[country.name]! as Double
            }
            
        }
    }
    
    func cacheCountries() {
        for Country in countryList{
            cache[Country.name] = Country.exchangeRate
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
                                
                                // println(String(format: "updating exchange for %@ in %@ : %f", countryToIterate.currencyCode, countryToIterate.name, countryToIterate.exchangeRate))
                            }
                        }
                    }
                                // println("Finished Refreshing Exchange Rates")
                                self.cacheCountries()
                                
                }
            }
        }
    

    func getCountry(countryName:String) -> Country {
        var returnCountry = Country(name: "far", currencyName: "USD", currencyCode: "USD", exchangeRate: 2.0, tipRate: 0.2, additionalTaxRate: 0.2, precision: 1.0, tipString: "no way", taxString: "no fart", ISOAbbreviation: "UK")
        
        for Country in countryList {
            if (Country.name == countryName) {
                returnCountry = Country
            }
        }
//
//        for(var i=0; i < countryList.count; i++)
//        {
//            if(countryList[i].name == countryName)
//            {
//                returnCountry = countryList[i]
//
//            }
//        }
        
        
        return returnCountry
    }
    
    func getLocale(localeName: String) -> Locale {
        
        var returnLocale = Locale(name: "Choose a Locale", additionalTaxRate: nil, tipRate: nil, country: getCountry("Choose a Country"))
        
        for Locale in localeList {
            if (Locale.name == localeName) {
                returnLocale = Locale
            }
        }
        
//        for(var i=0;i < localeList.count; i++)
//        {
//            if(localeList[i].name == localeName)
//            {
//                return localeList[i]
//            }
//        }
        
        return  returnLocale
        
        // figure out a better default state
    }
        

}