# Example time formats
{ :short_date => "%x", :long_date => "%a, %b %d, %Y" }.each do |k, v|
  Time::DATE_FORMATS.update(k => v)
  Date::DATE_FORMATS.update(k => v)
end
