Given(/^I have documented my CSS$/) do
  visit kayessess.root_path

  anchors = page.all('.kayessess__node').reject{|anchor|
    anchor[:href] == "/styleguide/styleguide"
  }

  @section_anchors = Hash[anchors.map{|anchor| [anchor.text, anchor]}]
end

Then(/^I should be able to view each component$/) do
  @section_anchors.each do |ancor_label, anchor|
    puts "- #{ancor_label}"
    step %Q{I view the "#{ancor_label}" styleguide section}
    visit kayessess.root_path
  end
end

And(/I view the "(.*)" styleguide section/) do |section|
  section = @section_anchors[section]
  section.click
  page.should have_content section.text
end
