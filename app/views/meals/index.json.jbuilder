json.array!(@meals) do |meal|
  json.id meal.id
  json.title meal.title
  json.start meal.date
  json.end meal.date
end

