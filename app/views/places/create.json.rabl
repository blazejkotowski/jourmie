object false
child(@place) { attributes :id, :name, :date_from, :date_to }


if @created
  code = 200
  message = "Successfully created new place."
else
  code = 500
  message = "There was some problem creating new place."
end

node(:status) do 
  { :code => code, :message => message } 
end
