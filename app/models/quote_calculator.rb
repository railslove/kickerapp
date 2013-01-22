class QuoteCalculator
  def self.win_lose_quote(wins, loses)
    if wins + loses > 0
      wins.to_f / (wins + loses)
    else
      0
    end
  end


  def self.elo_quote(elo_player, elo_opponent, win, elo_partner = nil)
    if elo_partner.present?
      team_elo = (elo_player + elo_partner).to_f / 2
      difference = (elo_opponent - team_elo)
    else
      difference = (elo_opponent - elo_player)
    end
    difference = 400 if difference > 400
    ea = 1.0 / (1 + (10 ** (difference.to_f / 400)))
    elo_neu = (elo_player + 15 * (win - ea)).round
  end

end
