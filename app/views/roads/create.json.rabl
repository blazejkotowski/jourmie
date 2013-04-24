object false

if @created
  code = 200
  message = "Successfully created new road."
else
  code = 500
  message = "There was some problem creating new road."
end

node(:status) do 
  { :code => code, :message => message } 
end
