#= require vendor
#= require peek
#= require peek/views/dalli
#= require peek/views/performance_bar
#= require app
#= require_tree ./lib
#= require_tree ./config
#= require application/controllers/view_controller
#= require_tree ./application/models
#= require_tree ./application/collections
#= require_tree ./application/components
#= require_tree ./application/controllers

ready = ->
  new app.controllers.PanelsController(el: "body")
  new app.controllers.NprogressController(el: $(document))
  new app.controllers.ResponsiveNavigationController(el: $(document))

$(document).ready(ready)
$(document).on('page:load', ready)
