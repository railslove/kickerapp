class QuoteCalculator
  def self.win_lose_quote(wins, loses)
    if wins + loses > 0
      quote = wins.to_f / (wins + loses)
    else
      0
    end
  end
end
