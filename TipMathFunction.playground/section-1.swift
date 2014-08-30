class TipCalculator {

    let exchangeRate:Double
    let hereTheyWant:Double
    let thereTaxRate:Double
    let thereTipRate:Double
    let homeTaxRate:Double
    let homeTipRate:Double
    
    init(hereTheyWant:Double, exchangeRate:Double, thereTaxRate:Double, thereTipRate:Double, homeTaxRate:Double, homeTipRate:Double) {
        self.hereTheyWant = hereTheyWant
        self.exchangeRate = exchangeRate
        self.thereTaxRate = 0.01 * thereTaxRate
        self.thereTipRate = 0.01 * thereTipRate
        self.homeTaxRate  = 0.01 * homeTaxRate
        self.homeTipRate  = 0.01 * homeTipRate
    }

    func calcTotals() -> [String: Double]
    {
        var retval = Dictionary<String, Double>()
        let totalamount:Double = (hereTheyWant * (1.0 + thereTaxRate + thereTipRate) / exchangeRate)
        let shouldFeelLike = totalamount/(1.0 + homeTaxRate + homeTipRate)
        let shouldTipLike = homeTipRate * shouldFeelLike
        let shouldTaxLike = homeTaxRate * shouldFeelLike
        retval["total"] = totalamount
        retval["shouldFeelLike"] = shouldFeelLike
        retval["shouldTipLike"] = shouldTipLike
        retval["shouldTaxLike"] = shouldTaxLike
        return retval
    }
    
}

let tipCalcNOKtoUSA = TipCalculator(hereTheyWant: 96, exchangeRate: 6.0, thereTaxRate: 0.0, thereTipRate: 0.0, homeTaxRate: 8.25, homeTipRate: 20)

let tipCalcUSAtoNOK = TipCalculator(hereTheyWant: 12.50, exchangeRate: 1/6, thereTaxRate: 8.25, thereTipRate: 20, homeTaxRate: 0, homeTipRate: 0)

tipCalcNOKtoUSA.calcTotals()
tipCalcUSAtoNOK.calcTotals()




