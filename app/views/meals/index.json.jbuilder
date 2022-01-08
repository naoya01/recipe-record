json.array! @meals, partial: "meals/meal", as: :meal
json.array!(@meals) do |event|
  json.extract! event, :id, :title, :description, :date
  json.start event.start_date
  json.end event.end_date
  json.start event.mealtime
  json.url event_url(event, format: :html)
end