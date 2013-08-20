# The style guide is the documentation of our CSS powered by KSS.
#
# It should only be exposed in development.
class Documentation::StyleguideController < ApplicationController
  skip_before_filter :login_required
  before_filter :styleguide

  layout "styleguide"

  def index; end

  def show
    @section = @styleguide.section(params[:id])

    render "documentation/styleguide/docs/#{clean_param(params[:id])}"
  end

  def example
    render "documentation/styleguide/docs/#{params[:styleguide_id]}/_section_#{clean_param(params[:example_id])}", :layout => "styleguide_example"
  end

  private

  def styleguide
    @styleguide ||= Kss::Parser.new(File.expand_path('app/assets/stylesheets', Rails.root))
  end

  def clean_param(param)
    param.gsub(".", "_")
  end
end
