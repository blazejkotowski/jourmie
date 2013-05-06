unless @participation.new_record?
  object @participation
  extends 'participations/show'
else
  node(:error) { "There was some error while creating new participation" }
end
