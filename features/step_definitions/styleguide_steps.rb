Given(/^I have documented my CSS$/) do
  visit "/styleguide"

  @styleguide_sections = page.all('.kayessess__node').reject{|anchor|
    anchor[:href] == "/styleguide/styleguide"
  }
end

Then(/^I should be able to view each component$/) do
  @styleguide_sections.each do |anchor|
    anchor.click
    page.should have_content anchor.text
    visit "/styleguide"
  end
end
