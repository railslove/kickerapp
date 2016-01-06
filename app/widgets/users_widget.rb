widget :users do
  key "a0b3cef53c10bfdf1965a3046569e0d6a76776ab"
  type "number_and_secondary"
  data do
    {
      value: User.distinct.where('users.created_at < ?', Date.today).joins(:history_entries).where(history_entries: { created_at: (5.weeks.ago..Date.today)}).count,
      previous: User.distinct.joins(:history_entries).where(history_entries: { created_at: (5.weeks.ago..Date.today)}).count
    }
  end
end
