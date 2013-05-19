unless @participation.new_record?
  object @participation
  extends 'participations/show'
  child(:user => :profile) do |user|
    node(:display_name) { user.profile.display_name }
    node(:avatar) do
      {
        :small => user.profile.avatar.url(:small),
        :tiny => user.profile.avatar.url(:tiny)
      }
    end
  end
else
  node(:error) { "There was some error while creating new participation" }
end
