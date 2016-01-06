widget :games_today do
  key "045b4612ce7e346d62591a12cb0f6af4e0703fee"
  type "geckometer"
  data do
    {
      value: Match.where(date: (Date.today..Date.tomorrow)).count,
      min: {
        value: 0,
        label: '0'
      },
      max: {
        value: 150,
        label: '150'
      }
    }
  end
end
