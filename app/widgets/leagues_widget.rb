# frozen_string_literal: true

widget :leagues do
  key '847c94c9c84571bc16b1418b5bd804fbd29f8914'
  type 'rag'
  data do
    {
      green: {
        value: League.distinct.joins(:matches).where(matches: { date: ((Date.today.beginning_of_week - 1.week)..Time.now) }).count,
        label: I18n.l((Date.today.beginning_of_week - 1.week).to_date, format: :short)
      },
      amber: {
        value: League.distinct.joins(:matches).where(matches: { date: ((Date.today.beginning_of_week - 2.weeks)..Time.now) }).count - League.distinct.joins(:matches).where(matches: { date: ((Date.today.beginning_of_week - 1.weeks)..Time.now) }).count,
        label: I18n.l((Date.today.beginning_of_week - 2.weeks).to_date, format: :short)
      },
      red: {
        value: League.distinct.joins(:matches).where(matches: { date: ((Date.today.beginning_of_week - 4.weeks)..Time.now) }).count - League.distinct.joins(:matches).where(matches: { date: ((Date.today.beginning_of_week - 2.weeks)..Time.now) }).count,
        label: I18n.l((Date.today.beginning_of_week - 4.weeks).to_date, format: :short)
      }
    }
  end
end
