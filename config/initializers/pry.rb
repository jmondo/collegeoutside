silence_warnings do
  begin
    require 'pry'
    IRB = Pry
  rescue LoadError
  end
end
