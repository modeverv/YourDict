json.array!(@words) do |word|
  json.extract! word, :userid, :word, :translate, :count, :memorize_count, :last_memorize_date
  json.url word_url(word, format: :json)
end
