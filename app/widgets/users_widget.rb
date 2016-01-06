widget :users do
  key "a0b3cef53c10bfdf1965a3046569e0d6a76776ab"
  type "number_and_secondary"
  data do
    {
      value: User.distinct.joins(:history_entries).where(history_entries: { created_at: (4.weeks.ago.beginning_of_week..Date.today)}).count,
      previous: User.distinct.where('users.created_at < ?', Date.today).joins(:history_entries).where(history_entries: { created_at: (5.weeks.ago..Time.now)}).count
    }
  end
end
