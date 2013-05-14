desc "This task is reseting counter caches"
task :reset_counters => :environment do
  User.find_each do |user| 
    User.reset_counters user.id, :albums
    user.update_attribute :friends_count, user.friends.length
  end

  ContentPiece.find_each do |cp|
    ContentPiece.reset_counters cp.id, :comments
  end  
end
