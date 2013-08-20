Given(/^I have documented my CSS$/) do
  @styleguide_views = Dir.glob(Rails.root.join("app/views/documentation/styleguide/*.html.erb"))
  @styleguide_views.map! { |f| File.basename(f)[/^[a-z]+/] }
end

Then(/^I should be able to browse rule classifications in the styleguide$/) do
  @styleguide_views.each do |view|
    visit "/styleguide/#{view}"
    page.should have_content(view.to_s.titleize)
    page.should have_selector("body#styleguide")
  end
end

Then(/^I should be able to view an example for each component$/) do
  @styleguide_views.each do |view|
    visit styleguide_path(:id => view.to_s)

    all('.detail-link').each { |detail_link|
      visit detail_link[:href]
      page.should have_selector("body#styleguide.styleguide-example")
      page.should have_selector(".section-#{detail_link['data-section']}")
    }
  end
end
