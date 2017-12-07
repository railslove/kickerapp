# frozen_string_literal: true

widget :games_week do
  key 'a32e94e925190177d9e78db9eefd182e59fe6aee'
  type 'line'
  data do
    {
      items: Match.reorder(:date).where(date: (10.weeks.ago..Time.now)).group_by { |m| m.date.to_date.cweek }.map { |w| [x: w.last.first.date.beginning_of_week.to_date, y: w.last.count] }.flatten,
      y_axis: [0, 100, 200, 300, 400, 500, 600],
      x_axis: {
        type: 'datetime'
      },
      incomplete_from: Date.today.beginning_of_week
    }
  end
end
