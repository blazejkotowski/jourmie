object @album
attributes :id, :name, :start_date, :end_date, :cover_image, :slug, :places_count, :participations_count

node(:start_date_string) { |album| album.start_date.strftime("%d.%m.%Y") }
node(:end_date_string) { |album| album.end_date.strftime("%d.%m.%Y") }

child(:places) do
  extends 'places/show'
end

child(:participations) do 
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
end

child(:participants_profiles => :participants) do
  attributes :id, :permalink
  node(:path) { |profile| show_profile_path(profile.user) }
  node(:avatar) do |profile|
    { 
      :small => profile.avatar.url(:small),
      :tiny => profile.avatar.url(:tiny)
    }
  end
end
