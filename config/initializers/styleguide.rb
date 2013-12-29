if defined?(Kayessess)
  Kayessess::ApplicationController.skip_before_filter :login_required
end
