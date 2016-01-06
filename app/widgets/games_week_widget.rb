widget :games_week do
  key "a32e94e925190177d9e78db9eefd182e59fe6aee"
  type "line"
  data do
    {
      items: Match.reorder(:date).where(date: (10.weeks.ago..Time.now)).group_by{|m| m.date.to_date.cweek}.map{|w|[x: w.first, y: w.last.count]}.flatten,
      y_axis: [0,100,200,300,400,500,600],
      incomplete_from: Date.today.cweek
    }
  end
end
