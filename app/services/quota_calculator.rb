# frozen_string_literal: true

class QuotaCalculator
  def self.win_lose_quota(wins, losses)
    if wins + losses > 0
      (wins.to_f / (wins + losses) * 100).round
    else
      0
    end
  end

  def self.elo_quota(elo_player, elo_opponent, win)
    difference = (elo_opponent - elo_player)
    difference = 400 if difference > 400
    ea = 1.0 / (1 + (10**(difference.to_f / 400)))
    elo_neu = (elo_player + 16 * (win - ea)).round
    change = (elo_neu - elo_player).abs > 1 ? elo_neu - elo_player : (win == 1 ? 1 : -1)
  end
end
