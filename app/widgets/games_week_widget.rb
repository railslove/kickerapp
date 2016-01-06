widget :games_week do
  key "a32e94e925190177d9e78db9eefd182e59fe6aee"
  type "line"
  data do
    {
      items: Match.reorder(:date).where(date: (12.weeks.ago..Time.now)).group_by{|m| m.date.to_date.cweek}.map{|w|[w.last.count]}.flatten,
      x_axis: (0..12).map{|w|w.weeks.ago.to_date.cweek},
      y_axis: [0,100,200,300,400,500,600]
    }
  end
end
