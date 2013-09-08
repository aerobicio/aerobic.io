Then(/^I should be on the "(.*?)" route$/) do |path_helper|
  current_path.should == send(path_helper.to_sym)
end
